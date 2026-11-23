import 'dart:math';

import 'rpg_models.dart';

enum ChestRarity {
  common(key: 'common', label: 'Baú Comum', minGold: 35, maxGold: 70, bonusXp: 25),
  rare(key: 'rare', label: 'Baú Raro', minGold: 80, maxGold: 150, bonusXp: 60),
  epic(key: 'epic', label: 'Baú Épico', minGold: 180, maxGold: 320, bonusXp: 120);

  const ChestRarity({
    required this.key,
    required this.label,
    required this.minGold,
    required this.maxGold,
    required this.bonusXp,
  });

  final String key;
  final String label;
  final int minGold;
  final int maxGold;
  final int bonusXp;

  static ChestRarity fromKey(String key) {
    return ChestRarity.values.firstWhere(
      (r) => r.key == key,
      orElse: () => ChestRarity.common,
    );
  }
}

class RewardOutcome {
  const RewardOutcome({
    required this.xpGained,
    required this.goldGained,
    required this.isCritical,
    required this.criticalMultiplier,
    required this.droppedChest,
    required this.showMicroTaskGentleReminder,
    required this.classBonusNotes,
    this.heroLeveledUp = false,
    this.attributeLeveledUp = false,
  });

  final int xpGained;
  final int goldGained;
  final bool isCritical;
  final double criticalMultiplier;
  final ChestRarity? droppedChest;
  final bool showMicroTaskGentleReminder;
  final List<String> classBonusNotes;
  final bool heroLeveledUp;
  final bool attributeLeveledUp;

  RewardOutcome copyWith({
    bool? heroLeveledUp,
    bool? attributeLeveledUp,
  }) {
    return RewardOutcome(
      xpGained: xpGained,
      goldGained: goldGained,
      isCritical: isCritical,
      criticalMultiplier: criticalMultiplier,
      droppedChest: droppedChest,
      showMicroTaskGentleReminder: showMicroTaskGentleReminder,
      classBonusNotes: classBonusNotes,
      heroLeveledUp: heroLeveledUp ?? this.heroLeveledUp,
      attributeLeveledUp: attributeLeveledUp ?? this.attributeLeveledUp,
    );
  }
}

/// Motor puro e testável de recompensas do LifeOS:
/// calcula bônus de Classe, Atributos, Móveis da Casa Viva, Poção de Foco,
/// Modo Energia, regra das 10 micro-tarefas, Acertos Críticos e Baús.
class RewardEngine {
  RewardEngine([Random? random]) : _rng = random ?? Random();

  final Random _rng;

  static const int raidEnemyBaseXp = 25;
  static const int raidEnemyBaseGold = 18;
  static const int raidClearBonusXp = 80;
  static const int raidClearBonusGold = 60;

  /// Calcula a chance de Acerto Crítico (0.0 a 0.65).
  static double criticalChance({
    required HeroClass heroClass,
    required int dexterityLevel,
    Set<String> ownedFurnitureIds = const {},
  }) {
    var chance = 0.10 + (dexterityLevel - 1) * 0.005;
    if (heroClass == HeroClass.rogue) {
      chance += 0.08;
    }
    if (ownedFurnitureIds.contains('furn_workbench')) {
      final mult = heroClass == HeroClass.alchemist ? 1.2 : 1.0;
      chance += 0.04 * mult;
    }
    return chance.clamp(0.05, 0.65);
  }

  /// Calcula a recompensa ao concluir uma tarefa comum ou micro-tarefa.
  RewardOutcome calculateTaskReward({
    required TaskDifficulty difficulty,
    required RpgAttribute attribute,
    required HeroClass heroClass,
    required Map<RpgAttribute, int> attributeLevels,
    required bool energyModeActive,
    required int microTasksCompletedTodayBeforeThis,
    required int totalTasksCompletedTodayBeforeThis,
    required bool bardInspirationActive,
    bool flashMissionActive = false,
    bool focusPotionActive = false,
    Set<String> ownedFurnitureIds = const {},
  }) {
    var xp = difficulty.baseXp.toDouble();
    var gold = difficulty.baseGold.toDouble();
    final notes = <String>[];

    final isMicro = difficulty == TaskDifficulty.micro;
    final houseBoost = heroClass == HeroClass.alchemist ? 1.2 : 1.0;
    var showMicroReminder = false;

    // 1. Modo Energia / Dia Sem Culpa (dobra Ouro de micro-vitórias)
    if (energyModeActive && isMicro) {
      gold *= 2.0;
      notes.add('Modo Energia: Ouro 2x em micro-vitória');
      if (ownedFurnitureIds.contains('furn_fireplace')) {
        final fireBonus = (15 * houseBoost).round();
        gold += fireBonus;
        notes.add('Lareira: +${fireBonus}g no Modo Energia');
      }
    } else if (isMicro &&
        microTasksCompletedTodayBeforeThis >=
            RpgProgression.softMicroTaskDailyLimit) {
      xp *= 0.5;
      showMicroReminder = true;
    }

    // 2. Bônus de Passiva de Classe
    if (heroClass == HeroClass.warrior && attribute == RpgAttribute.vigor) {
      xp *= 1.15;
      gold *= 1.15;
      notes.add('Guerreiro: +15% VIG');
    } else if (heroClass == HeroClass.mage &&
        attribute == RpgAttribute.intellect) {
      xp *= 1.15;
      notes.add('Mago: +15% XP INT');
    } else if (heroClass == HeroClass.alchemist &&
        attribute == RpgAttribute.wisdom) {
      xp *= 1.15;
      notes.add('Alquimista: +15% XP SAB');
    } else if (heroClass == HeroClass.bard &&
        attribute == RpgAttribute.charisma) {
      xp *= 1.15;
      gold *= 1.15;
      notes.add('Bardo: +15% CAR');
    }

    // 3. Passivas Reais dos Móveis da Casa Viva
    if (ownedFurnitureIds.contains('furn_garden') &&
        attribute == RpgAttribute.vigor) {
      gold *= (1.0 + 0.10 * houseBoost);
      notes.add('Horta de Ervas: +${(10 * houseBoost).round()}% Ouro VIG');
    }
    if (ownedFurnitureIds.contains('furn_arcane_desk') &&
        attribute == RpgAttribute.intellect) {
      xp *= (1.0 + 0.10 * houseBoost);
      notes.add('Escrivaninha Arcana: +${(10 * houseBoost).round()}% XP INT');
    }
    if (ownedFurnitureIds.contains('furn_fireplace') &&
        attribute == RpgAttribute.wisdom) {
      xp *= (1.0 + 0.10 * houseBoost);
      notes.add('Lareira: +${(10 * houseBoost).round()}% XP SAB');
    }
    if (ownedFurnitureIds.contains('furn_tavern_table') &&
        attribute == RpgAttribute.charisma) {
      gold *= (1.0 + 0.15 * houseBoost);
      notes.add('Mesa de Taverna: +${(15 * houseBoost).round()}% Ouro CAR');
    }
    if (ownedFurnitureIds.contains('furn_star_library')) {
      xp *= (1.0 + 0.10 * houseBoost);
      notes.add('Biblioteca Estelar: +${(10 * houseBoost).round()}% XP');
    }

    // 4. Poção de Foco (+25% XP por 1h)
    if (focusPotionActive) {
      xp *= 1.25;
      notes.add('Poção de Foco: +25% XP');
    }

    // 5. Habilidade Inspiração do Bardo (+25% XP em tarefa de outro atributo)
    if (bardInspirationActive && attribute != RpgAttribute.charisma) {
      xp *= 1.25;
      notes.add('Inspiração do Bardo: +25% XP');
    }

    // 6. Habilidade Golpe Constante do Guerreiro (a cada 3 tarefas no dia)
    if (heroClass == HeroClass.warrior &&
        (totalTasksCompletedTodayBeforeThis + 1) % 3 == 0) {
      gold += 25;
      notes.add('Golpe Constante: +25 Ouro');
    }

    // 7. Missão Relâmpago ativa
    if (flashMissionActive) {
      final flashGold = heroClass == HeroClass.rogue ? 42.0 : 35.0;
      gold += flashGold;
      notes.add('Missão Relâmpago: +${flashGold.round()} Ouro');
    }

    // 8. Acerto Crítico (Dopamina Variável)
    final desLevel = attributeLevels[RpgAttribute.dexterity] ?? 1;
    final critChance = criticalChance(
      heroClass: heroClass,
      dexterityLevel: desLevel,
      ownedFurnitureIds: ownedFurnitureIds,
    );
    final isCrit = _rng.nextDouble() < critChance;
    var critMult = 1.0;
    if (isCrit) {
      critMult = _rng.nextBool() ? 1.5 : 2.0;
      xp *= critMult;
      gold *= critMult;
    }

    // 9. Chance de Baú Misterioso (aumenta com Sabedoria e dificuldade)
    ChestRarity? chest;
    final sabLevel = attributeLevels[RpgAttribute.wisdom] ?? 1;
    if (heroClass == HeroClass.alchemist &&
        energyModeActive &&
        isMicro &&
        (microTasksCompletedTodayBeforeThis + 1) == 3) {
      chest = ChestRarity.common;
      notes.add('Elixir da Calma: Baú Comum garantido!');
    } else {
      final baseChestChance = switch (difficulty) {
        TaskDifficulty.micro => 0.04,
        TaskDifficulty.easy => 0.08,
        TaskDifficulty.medium => 0.14,
        TaskDifficulty.hard => 0.22,
      };
      final totalChestChance =
          (baseChestChance + (sabLevel - 1) * 0.01 + (flashMissionActive ? 0.12 : 0))
              .clamp(0.0, 0.55);
      if (_rng.nextDouble() < totalChestChance) {
        chest = _rollChestRarity(bonusLuck: (sabLevel - 1) * 0.015);
      }
    }

    return RewardOutcome(
      xpGained: xp.round(),
      goldGained: gold.round(),
      isCritical: isCrit,
      criticalMultiplier: critMult,
      droppedChest: chest,
      showMicroTaskGentleReminder: showMicroReminder,
      classBonusNotes: notes,
    );
  }

  /// Calcula a recompensa ao derrotar 1 inimigo de Raid (ou limpar a Raid inteira).
  RewardOutcome calculateRaidEnemyReward({
    required bool isFinalEnemy,
    required HeroClass heroClass,
    required Map<RpgAttribute, int> attributeLevels,
    bool focusPotionActive = false,
    Set<String> ownedFurnitureIds = const {},
  }) {
    var xp = raidEnemyBaseXp.toDouble();
    var gold = raidEnemyBaseGold.toDouble();
    final notes = <String>[];
    final houseBoost = heroClass == HeroClass.alchemist ? 1.2 : 1.0;

    if (isFinalEnemy) {
      xp += raidClearBonusXp;
      gold += raidClearBonusGold;
      notes.add('Raid Concluída: +$raidClearBonusXp XP e +$raidClearBonusGold Ouro');
    }

    final intLevel = attributeLevels[RpgAttribute.intellect] ?? 1;
    xp *= 1.0 + (intLevel - 1) * 0.02;

    if (heroClass == HeroClass.mage) {
      xp *= 1.15;
      notes.add('Mago: +15% XP em Raid');
    }
    if (ownedFurnitureIds.contains('furn_arcane_desk')) {
      xp *= (1.0 + 0.10 * houseBoost);
      notes.add('Escrivaninha Arcana: +${(10 * houseBoost).round()}% XP');
    }
    if (ownedFurnitureIds.contains('furn_forge')) {
      xp *= (1.0 + 0.15 * houseBoost);
      gold *= (1.0 + 0.15 * houseBoost);
      notes.add('Forja do Aventureiro: +${(15 * houseBoost).round()}% Raid');
    }
    if (ownedFurnitureIds.contains('furn_star_library')) {
      xp *= (1.0 + 0.10 * houseBoost);
    }
    if (focusPotionActive) {
      xp *= 1.25;
      notes.add('Poção de Foco: +25% XP');
    }

    final desLevel = attributeLevels[RpgAttribute.dexterity] ?? 1;
    final isCrit = _rng.nextDouble() <
        criticalChance(
          heroClass: heroClass,
          dexterityLevel: desLevel,
          ownedFurnitureIds: ownedFurnitureIds,
        );
    var critMult = 1.0;
    if (isCrit) {
      critMult = 1.5;
      xp *= critMult;
      gold *= critMult;
    }

    ChestRarity? chest;
    if (isFinalEnemy) {
      final sabLevel = attributeLevels[RpgAttribute.wisdom] ?? 1;
      final mageBonus = heroClass == HeroClass.mage ? 0.20 : 0.0;
      chest = _rollChestRarity(
        bonusLuck: 0.15 + mageBonus + (sabLevel - 1) * 0.02,
      );
    }

    return RewardOutcome(
      xpGained: xp.round(),
      goldGained: gold.round(),
      isCritical: isCrit,
      criticalMultiplier: critMult,
      droppedChest: chest,
      showMicroTaskGentleReminder: false,
      classBonusNotes: notes,
    );
  }

  /// Rola o loot ao abrir um Baú Misterioso.
  ({int gold, int xp}) rollChestLoot(ChestRarity rarity) {
    final goldSpan = rarity.maxGold - rarity.minGold + 1;
    final gold = rarity.minGold + _rng.nextInt(goldSpan);
    return (gold: gold, xp: rarity.bonusXp);
  }

  ChestRarity _rollChestRarity({double bonusLuck = 0.0}) {
    final roll = _rng.nextDouble() + bonusLuck;
    if (roll >= 0.92) return ChestRarity.epic;
    if (roll >= 0.60) return ChestRarity.rare;
    return ChestRarity.common;
  }
}
