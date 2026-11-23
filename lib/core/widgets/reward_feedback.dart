import 'package:material_ui/material_ui.dart';

import '../rpg/reward_engine.dart';
import '../rpg/rpg_models.dart';
import '../theme/lifeos_theme.dart';
import 'pixel_panel.dart';

/// Exibe feedback visual imediato (SnackBar ou Dialog) para vitórias,
/// Acertos Críticos, Level Ups, Baús e recomendação gentil de micro-tarefas.
void showRewardFeedback(
  BuildContext context, {
  required RewardOutcome outcome,
  required RpgAttribute attribute,
  bool isRaidVictory = false,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();

  final headline = isRaidVictory
      ? 'RAID CONCLUÍDA!'
      : outcome.isCritical
          ? 'ACERTO CRÍTICO (${outcome.criticalMultiplier}x)!'
          : 'VITÓRIA!';

  final extras = <String>[
    ...outcome.classBonusNotes,
    if (outcome.heroLeveledUp) 'LEVEL UP! +${RpgProgression.levelUpGoldBonus} Ouro!',
    if (outcome.attributeLeveledUp) '${attribute.name} subiu de nível!',
    if (outcome.droppedChest != null)
      'Dropou ${outcome.droppedChest!.label}! Abra na aba Herói.',
  ];

  // Se houve Level Up ou Vitória de Raid ou Baú, mostra um modal 16-bit celebratório!
  if (isRaidVictory || outcome.heroLeveledUp || outcome.droppedChest != null) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: PixelPanel(
          borderColor:
              outcome.isCritical || isRaidVictory ? LifeOsColors.gold : LifeOsColors.xpBar,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                headline,
                textAlign: TextAlign.center,
                style: LifeOsTheme.pixelTitle(
                  size: 13,
                  color: LifeOsColors.gold,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                '+${outcome.xpGained} XP (${attribute.shortName})   •   +${outcome.goldGained} Ouro',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: LifeOsColors.xpBar,
                ),
              ),
              if (extras.isNotEmpty) ...[
                const Divider(height: 20, color: LifeOsColors.border),
                ...extras.map(
                  (line) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '★ $line',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: LifeOsColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
              if (outcome.showMicroTaskGentleReminder) ...[
                const SizedBox(height: 10),
                const Text(
                  'Dica gentil: você já fez mais de 10 micro-tarefas hoje (XP reduzido para 50%). Que tal encarar uma tarefa Fácil/Média ou uma Raid?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: LifeOsColors.textSecondary,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              PixelButton(
                label: 'CONTINUAR',
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        ),
      ),
    );
    return;
  }

  // Caso normal / Crítico simples: SnackBar ágil que não interrompe o fluxo.
  final subtitle = <String>[
    '+${outcome.xpGained} XP (${attribute.shortName}) • +${outcome.goldGained} Ouro',
    ...extras,
    if (outcome.showMicroTaskGentleReminder)
      'Mais de 10 micro-tarefas hoje (50% XP) — que tal tentar uma tarefa maior?',
  ].join('\n');

  messenger.showSnackBar(
    SnackBar(
      backgroundColor:
          outcome.isCritical ? const Color(0xFF3E2D18) : LifeOsColors.surface,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: outcome.showMicroTaskGentleReminder ? 5 : 3),
      shape: Border.all(
        color: outcome.isCritical ? LifeOsColors.gold : LifeOsColors.xpBar,
        width: 2,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: LifeOsTheme.pixelTitle(
              size: 10,
              color: outcome.isCritical ? LifeOsColors.gold : LifeOsColors.xpBar,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: LifeOsColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

