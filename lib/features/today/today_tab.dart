import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../core/widgets/reward_feedback.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/hero_repository.dart';
import '../../providers/app_providers.dart';
import 'day_map_widget.dart';
import 'steps_encounter_widget.dart';

class TodayTab extends ConsumerStatefulWidget {
  const TodayTab({super.key, required this.hero});

  final HeroProfile hero;

  @override
  ConsumerState<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends ConsumerState<TodayTab> {
  RpgAttribute? _selectedFilter;
  DateTime? _flashMissionEndsAt;
  Timer? _flashTimer;
  Timer? _cooldownRefreshTimer;

  bool get _isFlashActive =>
      _flashMissionEndsAt != null &&
      DateTime.now().isBefore(_flashMissionEndsAt!);

  @override
  void initState() {
    super.initState();
    // Atualiza a barra de recarga da Missão Relâmpago periodicamente.
    _cooldownRefreshTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) {
        if (mounted &&
            HeroRepository.flashMissionRemaining(widget.hero) > Duration.zero) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _flashTimer?.cancel();
    _cooldownRefreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _startFlashMission() async {
    final remaining = HeroRepository.flashMissionRemaining(widget.hero);
    if (remaining > Duration.zero) {
      final mins = (remaining.inSeconds / 60).ceil().clamp(1, 60);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '⏳ Missão Relâmpago em recarga: faltam $mins min.',
          ),
        ),
      );
      return;
    }

    await ref.read(heroRepositoryProvider).recordFlashMissionStart();
    _flashTimer?.cancel();
    if (!mounted) return;
    setState(() {
      _flashMissionEndsAt = DateTime.now().add(const Duration(minutes: 15));
    });
    _flashTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || !_isFlashActive) {
        timer.cancel();
        if (mounted) setState(() => _flashMissionEndsAt = null);
      } else {
        setState(() {});
      }
    });
  }

  String _flashCountdownText() {
    if (!_isFlashActive) return '';
    final diff = _flashMissionEndsAt!.difference(DateTime.now());
    final mins = diff.inMinutes.toString().padLeft(2, '0');
    final secs = (diff.inSeconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  Future<void> _activateEnergyMode() async {
    final activated =
        await ref.read(heroRepositoryProvider).activateEnergyMode();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          activated
              ? 'Modo Energia ativado hoje! Micro-vitórias dão Ouro em dobro.'
              : 'Modo Energia em recarga semanal (1x a cada 7 dias).',
        ),
      ),
    );
  }

  Future<void> _completeTask(Task task) async {
    final flashWasActive = _isFlashActive;
    final outcome = await ref.read(taskRepositoryProvider).completeTask(
          task.id,
          flashMissionActive: flashWasActive,
        );
    if (flashWasActive && mounted) {
      _flashTimer?.cancel();
      setState(() => _flashMissionEndsAt = null);
    }
    if (outcome != null && mounted) {
      showRewardFeedback(
        context,
        outcome: outcome,
        attribute: RpgAttribute.fromKey(task.attributeKey),
      );
    }
  }

  void _openAddTaskSheet() {
    final titleCtrl = TextEditingController();
    var selectedAttr = RpgAttribute.vigor;
    var selectedDiff = TaskDifficulty.easy;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: LifeOsColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                18,
                18,
                18,
                MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NOVA ATIVIDADE',
                      style: LifeOsTheme.pixelTitle(
                        size: 12,
                        color: LifeOsColors.gold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleCtrl,
                      autofocus: true,
                      maxLength: 100,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Ex.: Beber água, Ler 10 págs, Responder msg...',
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Atributo que essa atividade aprimora:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: LifeOsColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: RpgAttribute.values.map((attr) {
                        final active = attr == selectedAttr;
                        return ChoiceChip(
                          label: Text('${attr.shortName} • ${attr.name}'),
                          selected: active,
                          selectedColor: attr.color.withValues(alpha: 0.3),
                          side: BorderSide(
                            color: active ? attr.color : LifeOsColors.border,
                            width: 1.5,
                          ),
                          onSelected: (_) =>
                              setSheetState(() => selectedAttr = attr),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Dificuldade (XP / Ouro base):',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: LifeOsColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: TaskDifficulty.values.map((diff) {
                        final active = diff == selectedDiff;
                        return ChoiceChip(
                          label: Text(
                            '${diff.label} (${diff.baseXp} XP / ${diff.baseGold}g)',
                          ),
                          selected: active,
                          selectedColor:
                              LifeOsColors.gold.withValues(alpha: 0.25),
                          side: BorderSide(
                            color: active
                                ? LifeOsColors.gold
                                : LifeOsColors.border,
                            width: 1.5,
                          ),
                          onSelected: (_) =>
                              setSheetState(() => selectedDiff = diff),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 18),
                    PixelButton(
                      label: 'ADICIONAR ATIVIDADE',
                      onPressed: () async {
                        final text = titleCtrl.text.trim();
                        if (text.isEmpty) return;
                        await ref.read(taskRepositoryProvider).addTask(
                              title: text,
                              attribute: selectedAttr,
                              difficulty: selectedDiff,
                            );
                        if (ctx.mounted) Navigator.of(ctx).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksProvider);
    final energyActive = HeroRepository.isEnergyModeActive(widget.hero);
    final cooldownDays = HeroRepository.energyModeCooldownDays(widget.hero);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddTaskSheet,
        backgroundColor: LifeOsColors.gold,
        foregroundColor: LifeOsColors.bgDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: LifeOsColors.textPrimary, width: 2),
        ),
        icon: const Icon(Icons.add_rounded),
        label: Text(
          'ATIVIDADE',
          style: LifeOsTheme.pixelTitle(size: 9, color: LifeOsColors.bgDark),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 92),
        children: [
          // 0. Mapa do Dia (Google Agenda + Zonas de Exploração)
          const DayMapWidget(),
          const SizedBox(height: 12),

          // 0.5. Contador de Passos & Encontros Aleatórios (Sidequests)
          StepsEncounterWidget(hero: widget.hero),
          const SizedBox(height: 12),

          // 1. Modo Energia / Dia Sem Culpa (1x por semana)
          PixelPanel(
            borderColor: energyActive
                ? LifeOsColors.success
                : cooldownDays == 0
                    ? LifeOsColors.xpBar
                    : LifeOsColors.border,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                Icon(
                  energyActive
                      ? Icons.local_fire_department_rounded
                      : Icons.battery_charging_full_rounded,
                  color: energyActive ? LifeOsColors.success : LifeOsColors.xpBar,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        energyActive
                            ? 'MODO ENERGIA ATIVO HOJE'
                            : 'MODO ENERGIA (1x/SEM)',
                        style: LifeOsTheme.pixelTitle(
                          size: 9,
                          color: energyActive
                              ? LifeOsColors.success
                              : LifeOsColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        energyActive
                            ? 'Ouro 2x em micro-vitórias hoje'
                            : cooldownDays == 0
                                ? 'Ouro 2x em micro-vitórias'
                                : 'Recarga: $cooldownDays dia(s)',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: LifeOsColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!energyActive && cooldownDays == 0)
                  TextButton(
                    onPressed: _activateEnergyMode,
                    style: TextButton.styleFrom(
                      backgroundColor:
                          LifeOsColors.xpBar.withValues(alpha: 0.16),
                      foregroundColor: LifeOsColors.xpBar,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: LifeOsColors.xpBar, width: 1.5),
                      ),
                    ),
                    child: const Text(
                      'ATIVAR',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 2. Missão Relâmpago (15 min)
          PixelPanel(
            borderColor:
                _isFlashActive ? LifeOsColors.gold : LifeOsColors.border,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.flash_on_rounded,
                  color: LifeOsColors.gold,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isFlashActive
                            ? 'MISSÃO RELÂMPAGO • ${_flashCountdownText()}'
                            : 'MISSÃO RELÂMPAGO',
                        style: LifeOsTheme.pixelTitle(
                          size: 9,
                          color: LifeOsColors.gold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isFlashActive
                            ? '+35 Ouro ao concluir 1 tarefa antes de zerar'
                            : '1 tarefa em 15 min = +35 Ouro',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: LifeOsColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_isFlashActive)
                  _FlashCooldownButton(
                    progress: HeroRepository.flashMissionChargeProgress(
                      widget.hero,
                    ),
                    onTap: _startFlashMission,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. Filtro por Atributo
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: const Text('Todos'),
                    selected: _selectedFilter == null,
                    onSelected: (_) => setState(() => _selectedFilter = null),
                  ),
                ),
                ...RpgAttribute.values.map(
                  (attr) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(attr.shortName),
                      selected: _selectedFilter == attr,
                      selectedColor: attr.color.withValues(alpha: 0.25),
                      onSelected: (_) => setState(() => _selectedFilter = attr),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 4. Lista de Atividades
          tasksAsync.when(
            data: (allTasks) {
              final filtered = _selectedFilter == null
                  ? allTasks
                  : allTasks
                      .where((t) => t.attributeKey == _selectedFilter!.key)
                      .toList();

              final pending = filtered.where((t) => !t.isCompleted).toList();
              final completed = filtered.where((t) => t.isCompleted).toList();

              if (filtered.isEmpty) {
                return PixelPanel(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.checklist_rounded,
                        size: 36,
                        color: LifeOsColors.textMuted,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sem atividades ainda',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Toque em "+ ATIVIDADE" para começar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: LifeOsColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (pending.isNotEmpty) ...[
                    Text(
                      'PENDENTES (${pending.length})',
                      style: LifeOsTheme.pixelTitle(
                        size: 9,
                        color: LifeOsColors.gold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...pending.map(
                      (task) => _TaskCard(
                        task: task,
                        onComplete: () => _completeTask(task),
                        onCycleAttribute: () {
                          final current = RpgAttribute.fromKey(task.attributeKey);
                          final next = RpgAttribute.values[
                              (RpgAttribute.values.indexOf(current) + 1) %
                                  RpgAttribute.values.length];
                          ref
                              .read(taskRepositoryProvider)
                              .updateTaskAttribute(task.id, next);
                        },
                        onCycleDifficulty: () {
                          final current = TaskDifficulty.values.firstWhere(
                            (d) => d.key == task.difficulty,
                            orElse: () => TaskDifficulty.easy,
                          );
                          final next = TaskDifficulty.values[
                              (TaskDifficulty.values.indexOf(current) + 1) %
                                  TaskDifficulty.values.length];
                          ref
                              .read(taskRepositoryProvider)
                              .updateTaskDifficulty(task.id, next);
                        },
                        onDelete: () =>
                            ref.read(taskRepositoryProvider).deleteTask(task.id),
                      ),
                    ),
                  ],
                  if (completed.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Text(
                      'CONCLUÍDAS (${completed.length})',
                      style: LifeOsTheme.pixelTitle(
                        size: 9,
                        color: LifeOsColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...completed.map(
                      (task) => _TaskCard(
                        task: task,
                        onComplete: null,
                        onDelete: () =>
                            ref.read(taskRepositoryProvider).deleteTask(task.id),
                      ),
                    ),
                  ],
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Erro ao carregar atividades: $e'),
          ),
        ],
      ),
    );
  }
}

class _FlashCooldownButton extends StatelessWidget {
  const _FlashCooldownButton({
    required this.progress,
    required this.onTap,
  });

  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ready = progress >= 1.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        height: 36,
        decoration: BoxDecoration(
          color: LifeOsColors.bgDark,
          border: Border.all(
            color: ready ? LifeOsColors.gold : LifeOsColors.border,
            width: 1.5,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Barra de recarga que enche gradualmente durante 1 hora
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                heightFactor: 1.0,
                child: Container(
                  color: ready
                      ? LifeOsColors.gold.withValues(alpha: 0.24)
                      : LifeOsColors.goldDark.withValues(alpha: 0.38),
                ),
              ),
            ),
            Center(
              child: Text(
                ready ? '15 MIN' : '${(progress * 100).round()}%',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 11.5,
                  color: ready ? LifeOsColors.gold : LifeOsColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.onComplete,
    this.onCycleAttribute,
    this.onCycleDifficulty,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback? onComplete;
  final VoidCallback? onCycleAttribute;
  final VoidCallback? onCycleDifficulty;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final attr = RpgAttribute.fromKey(task.attributeKey);
    final diff = TaskDifficulty.values.firstWhere(
      (d) => d.key == task.difficulty,
      orElse: () => TaskDifficulty.easy,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PixelPanel(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        borderColor: task.isCompleted ? LifeOsColors.surfaceHighlight : attr.color,
        child: Row(
          children: [
            GestureDetector(
              onTap: onComplete,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: task.isCompleted
                      ? LifeOsColors.success
                      : LifeOsColors.bgDark,
                  border: Border.all(
                    color: task.isCompleted ? LifeOsColors.success : attr.color,
                    width: 2,
                  ),
                ),
                child: task.isCompleted
                    ? const Icon(
                        Icons.check_rounded,
                        size: 18,
                        color: LifeOsColors.bgDark,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: task.isCompleted
                          ? LifeOsColors.textMuted
                          : LifeOsColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onCycleAttribute,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: attr.color.withValues(alpha: 0.18),
                            border: Border.all(color: attr.color, width: 1.2),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(attr.icon, size: 12, color: attr.color),
                              const SizedBox(width: 4),
                              Text(
                                attr.shortName,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: attr.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onCycleDifficulty,
                        child: Text(
                          '${diff.label} • ${diff.baseXp} XP • ${diff.baseGold}g',
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: LifeOsColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline_rounded,
                size: 19,
                color: LifeOsColors.textMuted,
              ),
              onPressed: onDelete,
              tooltip: 'Remover atividade',
            ),
          ],
        ),
      ),
    );
  }
}

