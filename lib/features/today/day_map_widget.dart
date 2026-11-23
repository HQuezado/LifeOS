import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';

/// Mapa do Dia (Anti-Cegueira Temporal):
/// exibe compromissos do Google Agenda / locais como marcos na trilha do dia,
/// contagem regressiva até o próximo marco e Zonas de Exploração nos intervalos livres.
class DayMapWidget extends ConsumerStatefulWidget {
  const DayMapWidget({super.key});

  @override
  ConsumerState<DayMapWidget> createState() => _DayMapWidgetState();
}

class _DayMapWidgetState extends ConsumerState<DayMapWidget> {
  bool _syncing = false;

  static String _fmtTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static String _fmtDuration(Duration d) {
    if (d.inMinutes < 60) return '${d.inMinutes} min';
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}min';
  }

  Future<void> _syncGoogle() async {
    setState(() => _syncing = true);
    try {
      final result =
          await ref.read(googleSyncServiceProvider).connectAndSyncToday();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Text(result.message),
        ),
      );
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  void _openAddEventSheet() {
    final titleCtrl = TextEditingController();
    final now = DateTime.now();
    var start = TimeOfDay(hour: (now.hour + 1) % 24, minute: 0);
    var durationMin = 60;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: LifeOsColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            18,
            18,
            18,
            MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NOVO MARCO NO MAPA DO DIA',
                style: LifeOsTheme.pixelTitle(size: 11, color: LifeOsColors.gold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleCtrl,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Ex.: Reunião, Academia, Consulta...',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: ctx,
                          initialTime: start,
                        );
                        if (picked != null) {
                          setSheetState(() => start = picked);
                        }
                      },
                      icon: const Icon(Icons.schedule_rounded, size: 18),
                      label: Text(
                        'Início: ${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<int>(
                    value: durationMin,
                    dropdownColor: LifeOsColors.surface,
                    items: const [
                      DropdownMenuItem(value: 30, child: Text('30 min')),
                      DropdownMenuItem(value: 60, child: Text('1 hora')),
                      DropdownMenuItem(value: 90, child: Text('1h 30m')),
                      DropdownMenuItem(value: 120, child: Text('2 horas')),
                    ],
                    onChanged: (v) {
                      if (v != null) setSheetState(() => durationMin = v);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PixelButton(
                label: 'ADICIONAR MARCO',
                onPressed: () async {
                  final text = titleCtrl.text.trim();
                  if (text.isEmpty) return;
                  final today = DateTime.now();
                  final startDt = DateTime(
                    today.year,
                    today.month,
                    today.day,
                    start.hour,
                    start.minute,
                  );
                  await ref.read(googleSyncServiceProvider).addLocalEvent(
                        title: text,
                        startTime: startDt,
                        endTime: startDt.add(Duration(minutes: durationMin)),
                      );
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(todayEventsProvider);
    final now = DateTime.now();

    return PixelPanel(
      borderColor: LifeOsColors.xpBar,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.map_rounded, color: LifeOsColors.xpBar, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'MAPA DO DIA',
                  style: LifeOsTheme.pixelTitle(
                    size: 10,
                    color: LifeOsColors.xpBar,
                  ),
                ),
              ),
              IconButton(
                onPressed: _syncing ? null : _syncGoogle,
                tooltip: 'Sincronizar Google Agenda & Tasks',
                icon: _syncing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: LifeOsColors.xpBar,
                        ),
                      )
                    : const Icon(
                        Icons.sync_rounded,
                        size: 20,
                        color: LifeOsColors.xpBar,
                      ),
              ),
              IconButton(
                onPressed: _openAddEventSheet,
                tooltip: 'Adicionar marco local',
                icon: const Icon(
                  Icons.add_alarm_rounded,
                  size: 20,
                  color: LifeOsColors.gold,
                ),
              ),
            ],
          ),
          eventsAsync.when(
            data: (events) {
              if (events.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Sem compromissos marcados hoje — dia aberto para exploração! Toque em 🔄 para sincronizar o Google Agenda ou ⏰ para adicionar um marco.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: LifeOsColors.textSecondary,
                      height: 1.35,
                    ),
                  ),
                );
              }

              CalendarEvent? nextEvent;
              for (final ev in events) {
                if (ev.startTime.isAfter(now)) {
                  nextEvent = ev;
                  break;
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (nextEvent != null) ...[
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 4, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      color: LifeOsColors.gold.withValues(alpha: 0.16),
                      child: Text(
                        '⏳ Próximo marco em ${_fmtDuration(nextEvent.startTime.difference(now))}: ${nextEvent.title}',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: LifeOsColors.gold,
                        ),
                      ),
                    ),
                  ],
                  ...List.generate(events.length, (i) {
                    final ev = events[i];
                    final isPast = ev.endTime.isBefore(now);
                    final isNow =
                        !ev.startTime.isAfter(now) && ev.endTime.isAfter(now);

                    // Calcula Zona de Exploração livre até o próximo compromisso (>= 30 min)
                    Duration? freeGap;
                    if (i + 1 < events.length) {
                      final gap = events[i + 1].startTime.difference(ev.endTime);
                      if (gap.inMinutes >= 30) freeGap = gap;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: isNow
                                  ? LifeOsColors.gold
                                  : (isPast
                                      ? LifeOsColors.textMuted
                                      : LifeOsColors.xpBar),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              ev.isAllDay
                                  ? 'Dia todo'
                                  : '${_fmtTime(ev.startTime)}–${_fmtTime(ev.endTime)}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: isPast
                                    ? LifeOsColors.textMuted
                                    : LifeOsColors.xpBar,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                ev.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: isPast
                                      ? LifeOsColors.textMuted
                                      : LifeOsColors.textPrimary,
                                  decoration: isPast
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                            if (ev.googleEventId == null)
                              GestureDetector(
                                onTap: () => ref
                                    .read(googleSyncServiceProvider)
                                    .deleteEvent(ev.id),
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 16,
                                  color: LifeOsColors.textMuted,
                                ),
                              ),
                          ],
                        ),
                        if (freeGap != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 4,
                              top: 4,
                              bottom: 6,
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(left: 12),
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: LifeOsColors.border,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                '🧭 Zona de Exploração: ${_fmtDuration(freeGap)} livre',
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: LifeOsColors.success,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        else
                          const SizedBox(height: 6),
                      ],
                    );
                  }),
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('Erro no Mapa do Dia: $e'),
          ),
        ],
      ),
    );
  }
}

