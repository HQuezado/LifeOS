import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lifeos/core/rpg/reward_engine.dart';
import 'package:lifeos/core/rpg/rpg_models.dart';

void main() {
  group('LifeOS RPG Progression', () {
    test('5 classes map 1:1 to all 5 attributes', () {
      expect(HeroClass.values.length, 5);
      expect(RpgAttribute.values.length, 5);

      final mappedAttributes =
          HeroClass.values.map((c) => c.primaryAttribute).toSet();
      expect(mappedAttributes, RpgAttribute.values.toSet());
    });

    test('Hero general XP curve is linear and constant', () {
      expect(RpgProgression.xpForNextHeroLevel(1), 100);
      expect(RpgProgression.xpForNextHeroLevel(2), 150);
      expect(RpgProgression.xpForNextHeroLevel(5), 300);
      expect(RpgProgression.xpForNextHeroLevel(10), 550);
    });

    test('Attribute XP curve is linear and lighter than general XP', () {
      expect(RpgProgression.xpForNextAttributeLevel(1), 60);
      expect(RpgProgression.xpForNextAttributeLevel(2), 90);
      expect(RpgProgression.xpForNextAttributeLevel(5), 180);
      expect(RpgProgression.xpForNextAttributeLevel(10), 330);
    });

    test('House stages unlock at levels 1, 5, 10, 20', () {
      expect(RpgProgression.houseStageName(1), 'Cabana Inicial');
      expect(RpgProgression.houseStageName(5), 'Casa de Madeira');
      expect(RpgProgression.houseStageName(10), 'Mansão do Aventureiro');
      expect(RpgProgression.houseStageName(20), 'Santuário Lendário');
    });
  });

  group('Phase 2 RewardEngine (ADHD Core Loop)', () {
    test('11th micro-task triggers gentle reminder and 50% XP outside Energy Mode', () {
      final engine = RewardEngine(Random(42));
      final outcome = engine.calculateTaskReward(
        difficulty: TaskDifficulty.micro,
        attribute: RpgAttribute.dexterity,
        heroClass: HeroClass.warrior,
        attributeLevels: {for (final a in RpgAttribute.values) a: 1},
        energyModeActive: false,
        microTasksCompletedTodayBeforeThis: 10,
        totalTasksCompletedTodayBeforeThis: 10,
        bardInspirationActive: false,
      );

      expect(outcome.showMicroTaskGentleReminder, isTrue);
      // Base micro XP is 15 -> 50% = 7.5 -> 8 (or 12/15 if crit)
      if (!outcome.isCritical) {
        expect(outcome.xpGained, 8);
      }
    });

    test('Energy Mode doubles micro-task gold and disables gentle XP penalty', () {
      final engine = RewardEngine(Random(7));
      final outcome = engine.calculateTaskReward(
        difficulty: TaskDifficulty.micro,
        attribute: RpgAttribute.wisdom,
        heroClass: HeroClass.warrior,
        attributeLevels: {for (final a in RpgAttribute.values) a: 1},
        energyModeActive: true,
        microTasksCompletedTodayBeforeThis: 12,
        totalTasksCompletedTodayBeforeThis: 12,
        bardInspirationActive: false,
      );

      expect(outcome.showMicroTaskGentleReminder, isFalse);
      expect(outcome.goldGained, greaterThanOrEqualTo(20));
    });

    test('Final Raid enemy always awards clear bonus and drops a Raid Chest', () {
      final engine = RewardEngine(Random(1));
      final outcome = engine.calculateRaidEnemyReward(
        isFinalEnemy: true,
        heroClass: HeroClass.mage,
        attributeLevels: {for (final a in RpgAttribute.values) a: 1},
      );

      expect(outcome.droppedChest, isNotNull);
      expect(outcome.xpGained, greaterThanOrEqualTo(105));
      expect(outcome.goldGained, greaterThanOrEqualTo(78));
    });
  });
}
