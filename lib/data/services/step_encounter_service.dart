import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/rpg/reward_engine.dart';
import '../../core/rpg/rpg_models.dart';
import '../repositories/hero_repository.dart';

class StepSidequest {
  const StepSidequest({
    required this.id,
    required this.enemyName,
    required this.questTitle,
    required this.flavorText,
    required this.attribute,
    required this.rewardXp,
    required this.rewardGold,
    this.rarity = 'common',
  });

  final String id;
  final String enemyName;
  final String questTitle;
  final String flavorText;
  final RpgAttribute attribute;
  final int rewardXp;
  final int rewardGold;
  final String rarity;

  bool get isRare => rarity == 'rare';

  factory StepSidequest.fromJson(Map<String, dynamic> json) {
    return StepSidequest(
      id: json['id'] as String? ?? 'sq_fallback',
      enemyName: json['enemyName'] as String,
      questTitle: json['questTitle'] as String,
      flavorText: json['flavorText'] as String? ?? '',
      attribute: RpgAttribute.fromKey(json['attribute'] as String? ?? 'VIG'),
      rewardXp: (json['rewardXp'] as num?)?.toInt() ?? 40,
      rewardGold: (json['rewardGold'] as num?)?.toInt() ?? 30,
      rarity: json['rarity'] as String? ?? 'common',
    );
  }
}

/// Serviço de Pedômetro + Encontros Aleatórios (125 Sidequests via JSON + Notificação).
/// A cada 1.000 passos caminhados, dispara uma notificação estilo RPG e gera uma Sidequest!
class StepEncounterService {
  StepEncounterService(this._heroRepository);

  final HeroRepository _heroRepository;
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  final Random _rng = Random();

  static const int stepsPerEncounter = 1000;

  static const List<StepSidequest> _fallbackPool = [
    StepSidequest(
      id: 'sq_vig_01',
      enemyName: 'Slime da Sede',
      questTitle: 'Beba 1 copo cheio de água agora',
      flavorText: 'Um slime azul salta na trilha pedindo um golinho de hidratação!',
      attribute: RpgAttribute.vigor,
      rewardXp: 40,
      rewardGold: 30,
    ),
  ];

  List<StepSidequest>? _loadedPool;
  final List<String> _recentQuestIds = [];

  bool _notificationsReady = false;
  StreamSubscription<StepCount>? _stepSub;
  int? _sessionBaseSensorSteps;
  int _persistedBaseSteps = 0;

  final _activeEncounterController =
      StreamController<StepSidequest?>.broadcast();
  StepSidequest? _activeEncounter;

  Stream<StepSidequest?> get activeEncounterStream =>
      _activeEncounterController.stream;
  StepSidequest? get activeEncounter => _activeEncounter;
  bool get isListening => _stepSub != null;

  Future<List<StepSidequest>> _getPool() async {
    if (_loadedPool != null) return _loadedPool!;
    try {
      final raw = await rootBundle.loadString('assets/data/sidequests.json');
      final list = jsonDecode(raw) as List<dynamic>;
      _loadedPool = list
          .map((e) => StepSidequest.fromJson(e as Map<String, dynamic>))
          .toList();
      if (_loadedPool!.isNotEmpty) return _loadedPool!;
    } catch (_) {}
    return _fallbackPool;
  }

  Future<void> _initNotifications() async {
    if (_notificationsReady) return;
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidInit);
    await _notifications.initialize(settings: settings);
    _notificationsReady = true;
  }

  /// Solicita permissões (Atividade Física + Notificações) e inicia o pedômetro.
  Future<({bool ok, String message})> startPedometer() async {
    try {
      await _initNotifications();
      final activityStatus = await Permission.activityRecognition.request();
      await Permission.notification.request();

      if (!activityStatus.isGranted) {
        return (
          ok: false,
          message: 'Permita "Atividade Física" para contar seus passos.',
        );
      }

      final hero = await _heroRepository.getHero();
      _persistedBaseSteps = hero?.stepsToday ?? 0;
      _sessionBaseSensorSteps = null;

      await _stepSub?.cancel();
      _stepSub = Pedometer.stepCountStream.listen(
        (event) => _onSensorSteps(event.steps),
        onError: (_) {},
      );

      return (ok: true, message: 'Pedômetro ativo! Caminhe para achar encontros.');
    } catch (_) {
      return (
        ok: false,
        message: 'Sensor de passos indisponível neste aparelho.',
      );
    }
  }

  Future<void> _onSensorSteps(int sensorTotal) async {
    _sessionBaseSensorSteps ??= sensorTotal;
    final delta = (sensorTotal - _sessionBaseSensorSteps!).clamp(0, 100000);
    final totalToday = _persistedBaseSteps + delta;
    await _applySteps(totalToday);
  }

  /// Adiciona passos manualmente (útil para testar encontros ou registrar caminhada).
  Future<void> addDemoSteps(int amount) async {
    await _initNotifications();
    final hero = await _heroRepository.getHero();
    final current = hero?.stepsToday ?? 0;
    await _applySteps(current + amount);
  }

  Future<void> _applySteps(int totalToday) async {
    final hero = await _heroRepository.getHero();
    if (hero == null) return;

    final currentMilestone = totalToday ~/ stepsPerEncounter;
    if (currentMilestone > hero.lastEncounterStepMilestone) {
      await _heroRepository.updateSteps(
        stepsToday: totalToday,
        lastMilestone: currentMilestone,
      );
      await _triggerRandomEncounter(totalToday);
    } else {
      await _heroRepository.updateSteps(stepsToday: totalToday);
    }
  }

  Future<StepSidequest> _pickSidequest() async {
    final pool = await _getPool();
    final wantRare = _rng.nextDouble() < 0.25;
    var candidates = pool
        .where((q) => q.isRare == wantRare && !_recentQuestIds.contains(q.id))
        .toList();
    if (candidates.isEmpty) {
      candidates = pool.where((q) => !_recentQuestIds.contains(q.id)).toList();
    }
    if (candidates.isEmpty) candidates = pool;

    final chosen = candidates[_rng.nextInt(candidates.length)];
    _recentQuestIds.add(chosen.id);
    if (_recentQuestIds.length > 15) {
      _recentQuestIds.removeAt(0);
    }
    return chosen;
  }

  Future<void> _triggerRandomEncounter(int totalSteps) async {
    final quest = await _pickSidequest();
    _activeEncounter = quest;
    _activeEncounterController.add(quest);

    try {
      await _initNotifications();
      const androidDetails = AndroidNotificationDetails(
        'lifeos_encounters',
        'Encontros na Trilha',
        channelDescription:
            'Sidequests aleatórias disparadas pelos seus passos no LifeOS.',
        importance: Importance.high,
        priority: Priority.high,
      );
      final prefix = quest.isRare ? '✨ ENCONTRO RARO: ' : '⚔️ ';
      await _notifications.show(
        id: 1001,
        title: '$prefix${quest.enemyName} ($totalSteps passos)',
        body: '${quest.questTitle} (+${quest.rewardXp} XP / +${quest.rewardGold}g)',
        notificationDetails: const NotificationDetails(android: androidDetails),
      );
    } catch (_) {}
  }

  /// Conclui a Sidequest ativa e concede XP, Ouro e chance de Baú (maior se rara!).
  Future<RewardOutcome?> completeActiveEncounter() async {
    final quest = _activeEncounter;
    if (quest == null) return null;

    _activeEncounter = null;
    _activeEncounterController.add(null);

    final chestRoll = _rng.nextDouble();
    final ChestRarity? dropChest = quest.isRare
        ? (chestRoll < 0.45 ? ChestRarity.rare : ChestRarity.common)
        : (chestRoll < 0.25 ? ChestRarity.common : null);

    final progress = await _heroRepository.awardProgress(
      attribute: quest.attribute,
      xpGained: quest.rewardXp,
      goldGained: quest.rewardGold,
      droppedChest: dropChest,
      chestSource: 'Sidequest: ${quest.enemyName}',
    );

    return RewardOutcome(
      xpGained: quest.rewardXp,
      goldGained: quest.rewardGold,
      isCritical: quest.isRare,
      criticalMultiplier: 1.0,
      droppedChest: dropChest,
      showMicroTaskGentleReminder: false,
      classBonusNotes: [
        if (quest.isRare) 'Encontro Raro vencido!' else 'Sidequest: ${quest.enemyName}',
      ],
      heroLeveledUp: progress.heroLeveledUp,
      attributeLeveledUp: progress.attributeLeveledUp,
    );
  }

  void dispose() {
    _stepSub?.cancel();
    _activeEncounterController.close();
  }
}
