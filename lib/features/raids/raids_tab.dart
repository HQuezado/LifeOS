import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../core/widgets/reward_feedback.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/raid_repository.dart';
import '../../providers/app_providers.dart';

class RaidsTab extends ConsumerWidget {
  const RaidsTab({super.key, required this.hero});

  final HeroProfile hero;

  void _openCreateRaidSheet(BuildContext context, WidgetRef ref) {
    final titleCtrl = TextEditingController();
    final stepCtrls = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    final stepAttrs = [
      RpgAttribute.intellect,
      RpgAttribute.dexterity,
      RpgAttribute.vigor,
    ];

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
                      'NOVA RAID',
                      style: LifeOsTheme.pixelTitle(
                        size: 12,
                        color: LifeOsColors.gold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleCtrl,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Nome da Raid',
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Inimigos e atributos:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: LifeOsColors.gold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(stepCtrls.length, (i) {
                      final attr = stepAttrs[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: stepCtrls[i],
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  hintText: 'Inimigo ${i + 1}',
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                final nextIdx =
                                    (RpgAttribute.values.indexOf(attr) + 1) %
                                        RpgAttribute.values.length;
                                setSheetState(
                                  () => stepAttrs[i] =
                                      RpgAttribute.values[nextIdx],
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 13,
                                ),
                                decoration: BoxDecoration(
                                  color: attr.color.withValues(alpha: 0.2),
                                  border: Border.all(
                                    color: attr.color,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  attr.shortName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: attr.color,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    TextButton.icon(
                      onPressed: () {
                        setSheetState(() {
                          stepCtrls.add(TextEditingController());
                          stepAttrs.add(RpgAttribute.intellect);
                        });
                      },
                      icon: const Icon(Icons.add_rounded, color: LifeOsColors.xpBar),
                      label: const Text(
                        '+ Inimigo',
                        style: TextStyle(color: LifeOsColors.xpBar),
                      ),
                    ),
                    const SizedBox(height: 10),
                    PixelButton(
                      label: 'CRIAR RAID',
                      onPressed: () async {
                        final title = titleCtrl.text.trim();
                        final steps = <({String title, RpgAttribute attribute})>[
                          for (var i = 0; i < stepCtrls.length; i++)
                            if (stepCtrls[i].text.trim().isNotEmpty)
                              (
                                title: stepCtrls[i].text.trim(),
                                attribute: stepAttrs[i],
                              ),
                        ];
                        if (title.isEmpty || steps.isEmpty) return;

                        final raidId =
                            await ref.read(raidRepositoryProvider).createRaid(
                                  title: title,
                                  steps: steps,
                                );
                        if (ctx.mounted) {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => RaidBattleScreen(
                                raidId: raidId,
                                hero: hero,
                              ),
                            ),
                          );
                        }
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
  Widget build(BuildContext context, WidgetRef ref) {
    final raidsAsync = ref.watch(raidsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openCreateRaidSheet(context, ref),
        backgroundColor: LifeOsColors.gold,
        foregroundColor: LifeOsColors.bgDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: LifeOsColors.textPrimary, width: 2),
        ),
        icon: const Icon(Icons.shield_rounded),
        label: Text(
          'NOVA RAID',
          style: LifeOsTheme.pixelTitle(size: 9, color: LifeOsColors.bgDark),
        ),
      ),
      body: raidsAsync.when(
        data: (raids) {
          if (raids.isEmpty) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                PixelPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.shield_rounded,
                            color: LifeOsColors.gold,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'SISTEMA DE RAIDS',
                            style: LifeOsTheme.pixelTitle(
                              size: 11,
                              color: LifeOsColors.gold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Quebre tarefas maiores em inimigos — cada um pode evoluir um atributo diferente.',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: LifeOsColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      const Divider(height: 20, color: LifeOsColors.border),
                      const Text(
                        '▸ Inimigo: +25 XP e +18 Ouro\n▸ Vitória da Raid: +80 XP, +60 Ouro + Baú',
                        style: TextStyle(fontSize: 13, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 92),
            itemCount: raids.length,
            itemBuilder: (context, index) {
              final item = raids[index];
              final attr = RpgAttribute.fromKey(item.raid.attributeKey);
              final done = item.raid.isCompleted;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => RaidBattleScreen(
                          raidId: item.raid.id,
                          hero: hero,
                        ),
                      ),
                    );
                  },
                  child: PixelPanel(
                    borderColor: done ? LifeOsColors.success : attr.color,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              done
                                  ? Icons.emoji_events_rounded
                                  : Icons.shield_rounded,
                              color: done ? LifeOsColors.gold : attr.color,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item.raid.title,
                                style: const TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 19,
                                color: LifeOsColors.textMuted,
                              ),
                              onPressed: () => ref
                                  .read(raidRepositoryProvider)
                                  .deleteRaid(item.raid.id),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        PixelProgressBar(
                          current: item.defeatedCount,
                          max: item.totalCount,
                          fillColor:
                              done ? LifeOsColors.success : LifeOsColors.gold,
                          height: 12,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              done
                                  ? 'RAID CONCLUÍDA!'
                                  : 'Próximo: ${item.currentEnemy?.title ?? ''}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: done
                                    ? LifeOsColors.success
                                    : LifeOsColors.textSecondary,
                              ),
                            ),
                            Text(
                              '${item.defeatedCount}/${item.totalCount} inimigos',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: LifeOsColors.gold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro ao carregar Raids: $e')),
      ),
    );
  }
}

/// Tela de Batalha 16-bit de uma Raid: Herói vs Inimigo Atual!
class RaidBattleScreen extends ConsumerWidget {
  const RaidBattleScreen({
    super.key,
    required this.raidId,
    required this.hero,
  });

  final int raidId;
  final HeroProfile hero;

  static ({String label, Color color, IconData icon}) _enemyVisual(
    String type,
  ) {
    return switch (type) {
      'slime' => (
          label: 'Slime da Distração',
          color: const Color(0xFF56C271),
          icon: Icons.bubble_chart_rounded,
        ),
      'goblin' => (
          label: 'Goblin da Procrastinação',
          color: const Color(0xFFA7F070),
          icon: Icons.pest_control_rounded,
        ),
      'skeleton' => (
          label: 'Esqueleto da Inércia',
          color: const Color(0xFFB8C4D4),
          icon: Icons.coronavirus_rounded,
        ),
      'orc' => (
          label: 'Orc do Bloqueio',
          color: const Color(0xFFE8A849),
          icon: Icons.whatshot_rounded,
        ),
      'boss' => (
          label: 'Guardião Final da Raid',
          color: const Color(0xFFE43B44),
          icon: Icons.local_fire_department_rounded,
        ),
      _ => (
          label: 'Golem de Pedra',
          color: const Color(0xFF94B0C2),
          icon: Icons.terrain_rounded,
        ),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raidStream = ref.watch(raidRepositoryProvider).watchRaidById(raidId);
    final heroClass = HeroClass.fromKey(hero.heroClass);

    return Scaffold(
      appBar: AppBar(title: const Text('BATALHA DE RAID')),
      body: StreamBuilder<RaidWithEnemies?>(
        stream: raidStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final current = data.currentEnemy;
          final currentAttr = current != null
              ? RpgAttribute.fromKey(current.attributeKey)
              : RpgAttribute.fromKey(data.raid.attributeKey);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                data.raid.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              PixelProgressBar(
                current: data.defeatedCount,
                max: data.totalCount,
                fillColor: LifeOsColors.gold,
              ),
              const SizedBox(height: 6),
              Text(
                'Ondas: ${data.defeatedCount}/${data.totalCount}',
                style: const TextStyle(
                  fontSize: 12.5,
                  color: LifeOsColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),

              // Arena 16-bit
              if (current != null) ...[
                Builder(
                  builder: (context) {
                    final visual = _enemyVisual(current.enemyType);
                    return PixelPanel(
                      borderColor: visual.color,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  HeroSpriteWidget(
                                    assetPath: heroClass.spriteAsset,
                                    size: 82,
                                    armorTint: ArmorTint.fromKey(hero.armorTint),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    hero.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'VS',
                                style: LifeOsTheme.pixelTitle(
                                  size: 14,
                                  color: LifeOsColors.gold,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 82,
                                    height: 82,
                                    decoration: BoxDecoration(
                                      color: LifeOsColors.bgDark,
                                      border: Border.all(
                                        color: visual.color,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      visual.icon,
                                      size: 46,
                                      color: visual.color,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    visual.label,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                      color: visual.color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(height: 24, color: LifeOsColors.border),
                          Text(
                            'MISSÃO DESTE INIMIGO:',
                            style: LifeOsTheme.pixelTitle(
                              size: 9,
                              color: LifeOsColors.xpBar,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            current.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            color: currentAttr.color.withValues(alpha: 0.2),
                            child: Text(
                              'Atributo: ${currentAttr.name} (${currentAttr.shortName})',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: currentAttr.color,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          PixelButton(
                            label: 'DERROTAR (+25 XP / +18g)',
                            backgroundColor: LifeOsColors.success,
                            textColor: LifeOsColors.bgDark,
                            onPressed: () async {
                              final result = await ref
                                  .read(raidRepositoryProvider)
                                  .defeatEnemy(current.id);
                              if (result != null && context.mounted) {
                                showRewardFeedback(
                                  context,
                                  outcome: result.outcome,
                                  attribute: currentAttr,
                                  isRaidVictory: result.raidCompleted,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ] else ...[
                PixelPanel(
                  borderColor: LifeOsColors.gold,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.emoji_events_rounded,
                        size: 52,
                        color: LifeOsColors.gold,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'MASMORRA LIMPA!',
                        style: LifeOsTheme.pixelTitle(
                          size: 13,
                          color: LifeOsColors.gold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Todos os inimigos desta Raid foram derrotados! Confira seu Baú na aba Herói.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: LifeOsColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 18),

              // Lista de todos os inimigos da Raid
              Text(
                'ONDAS DA MASMORRA',
                style: LifeOsTheme.pixelTitle(size: 10, color: LifeOsColors.gold),
              ),
              const SizedBox(height: 8),
              ...data.enemies.map((e) {
                final enemyAttr = RpgAttribute.fromKey(e.attributeKey);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PixelPanel(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    borderColor: e.isDefeated
                        ? LifeOsColors.success
                        : (e.id == current?.id
                            ? LifeOsColors.gold
                            : LifeOsColors.border),
                    child: Row(
                      children: [
                        Icon(
                          e.isDefeated
                              ? Icons.check_box_rounded
                              : Icons.sailing_rounded,
                          size: 18,
                          color: e.isDefeated
                              ? LifeOsColors.success
                              : LifeOsColors.textMuted,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            e.title,
                            style: TextStyle(
                              decoration: e.isDefeated
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: e.isDefeated
                                  ? LifeOsColors.textMuted
                                  : LifeOsColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          enemyAttr.shortName,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w900,
                            color: enemyAttr.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

