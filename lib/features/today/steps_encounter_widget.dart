import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../core/widgets/reward_feedback.dart';
import '../../data/database/app_database.dart';
import '../../data/services/step_encounter_service.dart';
import '../../providers/app_providers.dart';

/// Card de Caminhada (Pedômetro) + Encontros Aleatórios / Sidequests na aba Hoje.
class StepsEncounterWidget extends ConsumerWidget {
  const StepsEncounterWidget({super.key, required this.hero});

  final HeroProfile hero;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(stepEncounterServiceProvider);
    final encounter = ref.watch(activeStepEncounterProvider).value ??
        service.activeEncounter;

    final steps = hero.stepsToday;
    final progressInMilestone = steps % StepEncounterService.stepsPerEncounter;

    return PixelPanel(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.directions_walk_rounded,
                color: LifeOsColors.success,
                size: 22,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'PASSOS: $steps',
                  style: LifeOsTheme.pixelTitle(
                    size: 9.5,
                    color: LifeOsColors.success,
                  ),
                ),
              ),
              if (!service.isListening)
                TextButton(
                  onPressed: () async {
                    final res = await service.startPedometer();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(res.message)),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: LifeOsColors.success,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    side: const BorderSide(
                      color: LifeOsColors.success,
                      width: 1.5,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text(
                    'ATIVAR',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          PixelProgressBar(
            current: progressInMilestone,
            max: StepEncounterService.stepsPerEncounter,
            fillColor: LifeOsColors.success,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Próx. encontro: ${StepEncounterService.stepsPerEncounter - progressInMilestone} passos',
                style: const TextStyle(
                  fontSize: 11.5,
                  color: LifeOsColors.textSecondary,
                ),
              ),
              GestureDetector(
                onTap: () => service.addDemoSteps(500),
                child: const Text(
                  '+500 passos',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: LifeOsColors.gold,
                  ),
                ),
              ),
            ],
          ),

          // Encontro Aleatório / Sidequest ativa!
          if (encounter != null) ...[
            const Divider(height: 20, color: LifeOsColors.border),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  encounter.attribute.icon,
                  color: encounter.isRare
                      ? LifeOsColors.gold
                      : encounter.attribute.color,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${encounter.isRare ? '✨ ' : '⚔️ '}${encounter.enemyName.toUpperCase()}',
                              style: LifeOsTheme.pixelTitle(
                                size: 9,
                                color: encounter.isRare
                                    ? LifeOsColors.gold
                                    : LifeOsColors.xpBar,
                              ),
                            ),
                          ),
                          if (encounter.isRare)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              color: LifeOsColors.gold.withValues(alpha: 0.22),
                              child: const Text(
                                'RARO',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: LifeOsColors.gold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        encounter.questTitle,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (encounter.flavorText.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          encounter.flavorText,
                          style: const TextStyle(
                            fontSize: 12,
                            color: LifeOsColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            PixelButton(
              label:
                  'CONCLUIR (+${encounter.rewardXp} XP ${encounter.attribute.shortName} • +${encounter.rewardGold}g)',
              onPressed: () async {
                final outcome = await service.completeActiveEncounter();
                if (outcome != null && context.mounted) {
                  showRewardFeedback(
                    context,
                    outcome: outcome,
                    attribute: encounter.attribute,
                  );
                }
              },
            ),
          ],
        ],
      ),
    );
  }
}

