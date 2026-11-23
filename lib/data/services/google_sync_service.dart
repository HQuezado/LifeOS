import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as gcal;
import 'package:googleapis/tasks/v1.dart' as gtasks;
import 'package:http/http.dart' as http;

import '../../core/rpg/rpg_models.dart';
import '../database/app_database.dart';

class _BearerAuthClient extends http.BaseClient {
  _BearerAuthClient(this._accessToken, [http.Client? inner])
      : _inner = inner ?? http.Client();

  final String _accessToken;
  final http.Client _inner;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $_accessToken';
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}

class SyncResult {
  const SyncResult({
    required this.ok,
    required this.message,
    this.eventsSynced = 0,
    this.tasksImported = 0,
    this.accountEmail,
  });

  final bool ok;
  final String message;
  final int eventsSynced;
  final int tasksImported;
  final String? accountEmail;
}

/// Serviço 100% local-first de sincronização com Google Agenda e Google Tasks
/// via OAuth direto no dispositivo (sem servidor próprio), além de Backup JSON.
class GoogleSyncService {
  GoogleSyncService(this._db);

  final AppDatabase _db;
  bool _initialized = false;
  GoogleSignInAccount? _currentAccount;

  static const List<String> _scopes = [
    gcal.CalendarApi.calendarReadonlyScope,
    gtasks.TasksApi.tasksScope,
  ];

  String? get connectedEmail => _currentAccount?.email;
  bool get isConnected => _currentAccount != null;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize();
    _initialized = true;
  }

  /// Observa compromissos de hoje em ordem cronológica (cache local SQLite).
  Stream<List<CalendarEvent>> watchTodayEvents() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (_db.select(_db.calendarEvents)
          ..where((e) =>
              e.endTime.isBiggerOrEqualValue(startOfDay) &
              e.startTime.isSmallerThanValue(endOfDay))
          ..orderBy([(e) => OrderingTerm.asc(e.startTime)]))
        .watch();
  }

  /// Adiciona um marco/compromisso local no Mapa do Dia (funciona 100% offline).
  Future<void> addLocalEvent({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) async {
    await _db.into(_db.calendarEvents).insert(
          CalendarEventsCompanion.insert(
            title: title.trim(),
            startTime: startTime,
            endTime: endTime,
            location: Value(location?.trim()),
          ),
        );
  }

  Future<void> deleteEvent(int id) async {
    await (_db.delete(_db.calendarEvents)..where((e) => e.id.equals(id))).go();
  }

  /// Conecta conta Google e sincroniza compromissos de hoje + tarefas do Google Tasks.
  Future<SyncResult> connectAndSyncToday() async {
    try {
      await _ensureInitialized();
      _currentAccount ??= await GoogleSignIn.instance.authenticate(
        scopeHint: _scopes,
      );

      final account = _currentAccount;
      if (account == null) {
        return const SyncResult(
          ok: false,
          message: 'Login Google cancelado.',
        );
      }

      final auth = await account.authorizationClient.authorizeScopes(_scopes);
      final client = _BearerAuthClient(auth.accessToken);

      try {
        final eventsSynced = await _syncCalendarToday(client);
        final tasksImported = await _syncGoogleTasks(client);
        return SyncResult(
          ok: true,
          message:
              'Sincronizado! $eventsSynced evento(s) no Mapa do Dia e $tasksImported nova(s) tarefa(s) do Google Tasks.',
          eventsSynced: eventsSynced,
          tasksImported: tasksImported,
          accountEmail: account.email,
        );
      } finally {
        client.close();
      }
    } catch (e) {
      return SyncResult(
        ok: false,
        message:
            'Não foi possível conectar ao Google agora. Verifique se o OAuth Android está configurado no Google Cloud Console.\nDetalhe: $e',
      );
    }
  }

  Future<void> disconnect() async {
    try {
      await _ensureInitialized();
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
    _currentAccount = null;
  }

  Future<int> _syncCalendarToday(_BearerAuthClient client) async {
    final api = gcal.CalendarApi(client);
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final response = await api.events.list(
      'primary',
      timeMin: startOfDay.toUtc(),
      timeMax: endOfDay.toUtc(),
      singleEvents: true,
      orderBy: 'startTime',
    );

    final items = response.items ?? const [];

    await _db.transaction(() async {
      // Limpa apenas eventos sincronizados anteriormente (mantém compromissos locais manuais)
      await (_db.delete(_db.calendarEvents)
            ..where((e) => e.googleEventId.isNotNull()))
          .go();

      for (final ev in items) {
        final summary = ev.summary?.trim();
        if (summary == null || summary.isEmpty) continue;

        final start = ev.start?.dateTime?.toLocal() ??
            ev.start?.date?.toLocal() ??
            startOfDay;
        final end = ev.end?.dateTime?.toLocal() ??
            ev.end?.date?.toLocal() ??
            start.add(const Duration(hours: 1));
        final isAllDay = ev.start?.dateTime == null;

        await _db.into(_db.calendarEvents).insert(
              CalendarEventsCompanion.insert(
                googleEventId: Value(ev.id),
                title: summary,
                startTime: start,
                endTime: end,
                isAllDay: Value(isAllDay),
                location: Value(ev.location),
              ),
            );
      }
    });

    return items.length;
  }

  Future<int> _syncGoogleTasks(_BearerAuthClient client) async {
    final api = gtasks.TasksApi(client);
    final response = await api.tasks.list(
      '@default',
      showCompleted: false,
      maxResults: 50,
    );

    final items = response.items ?? const [];
    var imported = 0;

    for (final t in items) {
      final title = t.title?.trim();
      final gId = t.id;
      if (title == null || title.isEmpty || gId == null) continue;

      final existing = await (_db.select(_db.tasks)
            ..where((row) => row.googleTaskId.equals(gId)))
          .getSingleOrNull();
      if (existing != null) continue;

      await _db.into(_db.tasks).insert(
            TasksCompanion.insert(
              title: title,
              attributeKey: RpgAttribute.dexterity.key,
              difficulty: Value(TaskDifficulty.easy.key),
              googleTaskId: Value(gId),
            ),
          );
      imported++;
    }

    return imported;
  }

  /// Exporta todo o save local do LifeOS em JSON para backup manual no dispositivo.
  Future<String> exportSaveJson() async {
    final hero = await (_db.select(_db.heroProfiles)..limit(1)).getSingleOrNull();
    final attrs = await _db.select(_db.attributeStats).get();
    final owned = await _db.select(_db.ownedItems).get();

    final payload = {
      'app': 'LifeOS',
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'hero': hero == null
          ? null
          : {
              'name': hero.name,
              'heroClass': hero.heroClass,
              'level': hero.level,
              'currentXp': hero.currentXp,
              'gold': hero.gold,
            },
      'attributes': attrs
          .map((a) => {
                'key': a.attributeKey,
                'level': a.level,
                'currentXp': a.currentXp,
              })
          .toList(),
      'ownedItems': owned
          .map((o) => {
                'itemId': o.itemId,
                'category': o.category,
                'isEquipped': o.isEquipped,
              })
          .toList(),
    };

    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  /// Restaura o save local a partir de um JSON exportado anteriormente.
  Future<bool> importSaveJson(String rawJson) async {
    try {
      final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
      if (decoded['app'] != 'LifeOS' || decoded['hero'] == null) return false;

      final heroMap = decoded['hero'] as Map<String, dynamic>;
      final attrsList = (decoded['attributes'] as List<dynamic>? ?? []);
      final ownedList = (decoded['ownedItems'] as List<dynamic>? ?? []);

      await _db.transaction(() async {
        await _db.delete(_db.heroProfiles).go();
        await _db.delete(_db.attributeStats).go();
        await _db.delete(_db.ownedItems).go();

        await _db.into(_db.heroProfiles).insert(
              HeroProfilesCompanion.insert(
                name: heroMap['name'] as String,
                heroClass: heroMap['heroClass'] as String,
                level: Value((heroMap['level'] as num).toInt()),
                currentXp: Value((heroMap['currentXp'] as num).toInt()),
                gold: Value((heroMap['gold'] as num).toInt()),
              ),
            );

        for (final item in attrsList) {
          final m = item as Map<String, dynamic>;
          await _db.into(_db.attributeStats).insert(
                AttributeStatsCompanion.insert(
                  attributeKey: m['key'] as String,
                  level: Value((m['level'] as num).toInt()),
                  currentXp: Value((m['currentXp'] as num).toInt()),
                ),
              );
        }

        for (final item in ownedList) {
          final m = item as Map<String, dynamic>;
          await _db.into(_db.ownedItems).insert(
                OwnedItemsCompanion.insert(
                  itemId: m['itemId'] as String,
                  category: m['category'] as String,
                  isEquipped: Value(m['isEquipped'] as bool? ?? true),
                ),
              );
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  }
}

