import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeos/core/dungeon/dungeon_catalog.dart';
import 'package:lifeos/core/dungeon/dungeon_combat.dart';
import 'package:lifeos/core/dungeon/dungeon_generator.dart';
import 'package:lifeos/core/dungeon/dungeon_models.dart';
import 'package:lifeos/core/rpg/reward_engine.dart';
import 'package:lifeos/core/rpg/rpg_models.dart';
import 'package:lifeos/core/rpg/shop_catalog.dart';
import 'package:lifeos/core/social/gratitude_seal.dart';
import 'package:lifeos/data/database/app_database.dart';
import 'package:lifeos/data/services/step_encounter_service.dart';
import 'package:lifeos/features/dungeon/dungeon_run_screen.dart';
import 'package:lifeos/providers/app_providers.dart';
import 'package:material_ui/material_ui.dart';

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

  group('Phase 3 Shop & House Passives', () {
    test('Bard and Charisma combine for shop discount capped at 25%', () {
      expect(
        ShopCatalog.discountedPrice(
          basePrice: 100,
          heroClass: HeroClass.bard,
          charismaLevel: 1,
        ),
        90,
      );
      expect(
        ShopCatalog.discountedPrice(
          basePrice: 100,
          heroClass: HeroClass.bard,
          charismaLevel: 20,
        ),
        75, // Capped at 25% OFF
      );
    });

    test('House furniture and Focus Potion stack real XP/Gold bonuses', () {
      final engine = RewardEngine(Random(99));
      final outcome = engine.calculateTaskReward(
        difficulty: TaskDifficulty.medium, // 60 XP / 40 Gold
        attribute: RpgAttribute.intellect,
        heroClass: HeroClass.alchemist, // +20% furniture boost!
        attributeLevels: {for (final a in RpgAttribute.values) a: 1},
        energyModeActive: false,
        microTasksCompletedTodayBeforeThis: 0,
        totalTasksCompletedTodayBeforeThis: 0,
        bardInspirationActive: false,
        focusPotionActive: true,
        ownedFurnitureIds: {'furn_arcane_desk', 'furn_star_library'},
      );

      // 60 * 1.12 (arcane desk +20% alch) * 1.12 (star library +20% alch) * 1.25 (potion) = 94+
      expect(outcome.xpGained, greaterThanOrEqualTo(94));
    });
  });

  group('Phase 5 Sidequests Catalog', () {
    test('assets/data/sidequests.json contains 125 valid sidequests (25 per attribute)', () {
      final raw = File('assets/data/sidequests.json').readAsStringSync();
      final decoded = jsonDecode(raw) as List<dynamic>;
      final quests = decoded
          .map((e) => StepSidequest.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(quests.length, 125);
      for (final attr in RpgAttribute.values) {
        expect(quests.where((q) => q.attribute == attr).length, 25);
      }
    });
  });

  group('Phase 6 Procedural Dungeons & Combat', () {
    late DungeonCatalog catalog;

    setUpAll(() {
      catalog = DungeonCatalog.fromRawJson(
        bestiaryJson: File('assets/data/bestiary.json').readAsStringSync(),
        itemsJson: File('assets/data/dungeon_items.json').readAsStringSync(),
      );
    });

    test('Bestiary has 30 monsters (5 bosses) and Items has 53 equips + 15 consumables across all 11 categories with valid PNG assets', () {
      expect(catalog.monsters.length, 30);
      expect(catalog.monsters.where((m) => m.isBoss).length, 5);
      expect(catalog.equipment.length, 53);
      expect(catalog.consumables.length, 15);
      for (final cat in DungeonShopCategory.values) {
        expect(
          catalog.allItems.any((i) => i.category == cat),
          isTrue,
          reason: 'Empty category ${cat.key}',
        );
        expect(File(cat.iconAsset).existsSync(), isTrue, reason: 'Missing ${cat.iconAsset}');
      }

      for (final m in catalog.monsters) {
        expect(File(m.spriteAsset).existsSync(), isTrue, reason: 'Missing ${m.spriteAsset}');
      }
      for (final item in catalog.allItems) {
        expect(File(item.iconAsset).existsSync(), isTrue, reason: 'Missing ${item.iconAsset}');
      }
      for (final tile in DungeonTileType.values) {
        if (tile.asset != null) {
          expect(File(tile.asset!).existsSync(), isTrue, reason: 'Missing ${tile.asset}');
        }
      }
    });

    test('Seeded generator is deterministic and guarantees reachable stairs across all 5 biomes', () {
      for (final biome in DungeonBiome.values) {
        final floorA = DungeonGenerator.generateFloor(
          biome: biome,
          seed: 424242,
          floorNumber: biome.maxFloors,
          heroLevel: 6,
          catalog: catalog,
        );
        final floorB = DungeonGenerator.generateFloor(
          biome: biome,
          seed: 424242,
          floorNumber: biome.maxFloors,
          heroLevel: 6,
          catalog: catalog,
        );

        expect(floorA.startPos, floorB.startPos);
        expect(floorA.stairsPos, floorB.stairsPos);
        expect(floorA.enemies.length, floorB.enemies.length);
        expect(floorA.enemies.any((e) => e.isBoss), isTrue);

        // BFS check from startPos to stairsPos
        final visited = <GridPos>{floorA.startPos};
        final queue = <GridPos>[floorA.startPos];
        while (queue.isNotEmpty) {
          final cur = queue.removeAt(0);
          for (final d in const [GridPos(1, 0), GridPos(-1, 0), GridPos(0, 1), GridPos(0, -1)]) {
            final next = GridPos(cur.x + d.x, cur.y + d.y);
            if (!floorA.inBounds(next.x, next.y) || visited.contains(next)) continue;
            if (floorA.tileAt(next.x, next.y).walkable) {
              visited.add(next);
              queue.add(next);
            }
          }
        }
        expect(visited.contains(floorA.stairsPos), isTrue, reason: 'Unreachable stairs in ${biome.key}');
      }
    });

    test('Monster attributes scale with hero level, floor depth and boss multiplier', () {
      final slime = catalog.monsterById('mob_forest_slime')!;
      final treant = catalog.bossForBiome(DungeonBiome.forest);

      final lv1Floor1 = DungeonCombatEngine.instantiateEnemy(
        uid: 1,
        template: slime,
        x: 0,
        y: 0,
        heroLevel: 1,
        floorNumber: 1,
      );
      final lv10Floor5 = DungeonCombatEngine.instantiateEnemy(
        uid: 2,
        template: slime,
        x: 0,
        y: 0,
        heroLevel: 10,
        floorNumber: 5,
      );
      final bossLv10 = DungeonCombatEngine.instantiateEnemy(
        uid: 3,
        template: treant,
        x: 0,
        y: 0,
        heroLevel: 10,
        floorNumber: 5,
      );

      expect(lv10Floor5.maxHp, greaterThan(lv1Floor1.maxHp * 2));
      expect(bossLv10.maxHp, greaterThan(lv10Floor5.maxHp * 2));
    });

    testWidgets('DungeonRunScreen renders viewport cleanly without FlutterError', (tester) async {
      final hero = HeroProfile(
        id: 1,
        name: 'Teste',
        heroClass: HeroClass.warrior.key,
        level: 3,
        currentXp: 0,
        gold: 100,
        bardInspirationActive: false,
        armorTint: ArmorTint.original.key,
        soundEnabled: true,
        stepsToday: 0,
        lastEncounterStepMilestone: 0,
        expeditionKeys: 3,
        gratitudeSentCount: 0,
        lastGratitudeSentLevel: 0,
        gratitudeReceivedCount: 0,
        lastGratitudeReceivedLevel: 0,
        createdAt: DateTime(2026),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dungeonInventoryProvider.overrideWith(
              (ref) => Stream.value(const <DungeonInventoryData>[]),
            ),
          ],
          child: MaterialApp(
            home: DungeonRunScreen(
              hero: hero,
              attributes: {for (final a in RpgAttribute.values) a: 2},
              equippedItems: const [],
              catalog: catalog,
              biome: DungeonBiome.forest,
              seed: 404481,
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.textContaining('BOSQUE SUSSURRANTE'), findsOneWidget);
    });
  });

  group('Phase 7 Gratitude Seals (Anti-Abuse & HMAC Integrity)', () {
    test('Signed seal encodes, extracts from WhatsApp text and rejects tampering', () {
      final payload = GratitudeSealPayload(
        tokenId: 'abc1234567890def',
        senderUid: 'hero998877665544',
        senderName: 'Aldric',
        senderLevel: 4,
        xpAmount: GratitudeSealCodec.systemBlessingXpForLevel(4),
        goldAmount: 50,
        itemId: 'wpn_iron_sword',
        note: 'Valeu pela carona hoje!',
        createdEpochSec: DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000,
      );

      final code = GratitudeSealCodec.encode(payload);
      final whatsappMsg = GratitudeSealCodec.buildShareMessage(
        payload: payload,
        sealCode: code,
        itemName: 'Espada de Ferro',
      );

      final parsed = GratitudeSealCodec.decodeAndVerify(whatsappMsg);
      expect(parsed.error, isNull);
      expect(parsed.payload, isNotNull);
      expect(parsed.payload!.senderName, 'Aldric');
      expect(parsed.payload!.xpAmount, 135);
      expect(parsed.payload!.goldAmount, 50);
      expect(parsed.payload!.itemId, 'wpn_iron_sword');

      // Tamper with a single character in the code -> signature must fail!
      final tampered = code.replaceFirst('LIFEOS-GRAT-', 'LIFEOS-GRAT-X');
      final bad = GratitudeSealCodec.decodeAndVerify(tampered);
      expect(bad.payload, isNull);
      expect(bad.error, isNotNull);
    });

    test('Anti-abuse enforces max 1 use per level and max 5 uses total for both send and receive', () {
      // First send at level 2 -> allowed
      expect(
        GratitudeSealCodec.canSend(heroLevel: 2, sentCount: 0, lastSentLevel: 0).allowed,
        isTrue,
      );
      // Second send still at level 2 -> blocked
      expect(
        GratitudeSealCodec.canSend(heroLevel: 2, sentCount: 1, lastSentLevel: 2).allowed,
        isFalse,
      );
      // Next level (level 3) -> allowed again
      expect(
        GratitudeSealCodec.canSend(heroLevel: 3, sentCount: 1, lastSentLevel: 2).allowed,
        isTrue,
      );
      // After 5 sends -> permanently blocked even at level 20
      expect(
        GratitudeSealCodec.canSend(heroLevel: 20, sentCount: 5, lastSentLevel: 10).allowed,
        isFalse,
      );
      // Same rules for receive
      expect(
        GratitudeSealCodec.canReceive(heroLevel: 4, receivedCount: 2, lastReceivedLevel: 4).allowed,
        isFalse,
      );
      expect(
        GratitudeSealCodec.canReceive(heroLevel: 5, receivedCount: 5, lastReceivedLevel: 4).allowed,
        isFalse,
      );
    });
  });
}
