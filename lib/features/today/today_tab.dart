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

  bool get _isFlashActive =>
      _flashMissionEndsAt != null &&
      DateTime.now().isBefore(_flashMissionEndsAt!);

  @override
  void dispose() {
    _flashTimer?.cancel();
    super.dispose();
  }

  void _startFlashMission() {
    _flashTimer?.cancel();
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
          // 1. Modo Energia / Dia Sem Culpa (1x por semana)
          PixelPanel(
            borderColor: energyActive
                ? LifeOsColors.success
                : cooldownDays == 0
                    ? LifeOsColors.xpBar
                    : LifeOsColors.border,
            padding: const EdgeInsets.all(12),
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
                            ? 'Dia sem culpa: micro-vitórias dão Ouro 2x!'
                            : cooldownDays == 0
                                ? 'Dia difícil? Ative para dobrar o Ouro de micro-vitórias.'
                                : 'Em recarga: disponível novamente em $cooldownDays dia(s).',
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
            padding: const EdgeInsets.all(12),
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
                            ? 'Conclua qualquer tarefa antes do tempo acabar para +35 Ouro e sorte extra de Baú!'
                            : 'Desafio de 15 min: conclua 1 tarefa rápida por Ouro bônus.',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: LifeOsColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_isFlashActive)
                  TextButton(
                    onPressed: _startFlashMission,
                    style: TextButton.styleFrom(
                      backgroundColor: LifeOsColors.gold.withValues(alpha: 0.16),
                      foregroundColor: LifeOsColors.gold,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: LifeOsColors.gold, width: 1.5),
                      ),
                    ),
                    child: const Text(
                      '15 MIN',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                    ),
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
                        'Nenhuma atividade cadastrada ainda.',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Toque em "+ ATIVIDADE" para cadastrar hábitos ou tarefas que evoluem seus 5 atributos!',
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

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.onComplete,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback? onComplete;
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
                      Icon(attr.icon, size: 13, color: attr.color),
                      const SizedBox(width: 4),
                      Text(
                        attr.shortName,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: attr.color,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${diff.label} • ${diff.baseXp} XP • ${diff.baseGold}g',
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: LifeOsColors.textSecondary,
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

