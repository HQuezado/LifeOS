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
/// calcula bônus de Classe, Atributos, Modo Energia, regra das 10 micro-tarefas,
/// Acertos Críticos e drop de Baús Misteriosos.
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
  }) {
    var chance = 0.10 + (dexterityLevel - 1) * 0.005;
    if (heroClass == HeroClass.rogue) {
      chance += 0.08;
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
  }) {
    var xp = difficulty.baseXp.toDouble();
    var gold = difficulty.baseGold.toDouble();
    final notes = <String>[];

    final isMicro = difficulty == TaskDifficulty.micro;
    var showMicroReminder = false;

    // 1. Modo Energia / Dia Sem Culpa (dobra Ouro de micro-vitórias)
    if (energyModeActive && isMicro) {
      gold *= 2.0;
      notes.add('Modo Energia: Ouro 2x em micro-vitória');
    } else if (isMicro &&
        microTasksCompletedTodayBeforeThis >=
            RpgProgression.softMicroTaskDailyLimit) {
      // Regra gentil: após a 10ª micro-tarefa no dia (fora do Modo Energia), XP cai para 50%.
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

    // 3. Habilidade Inspiração do Bardo (+25% XP em tarefa de outro atributo)
    if (bardInspirationActive && attribute != RpgAttribute.charisma) {
      xp *= 1.25;
      notes.add('Inspiração do Bardo: +25% XP');
    }

    // 4. Habilidade Golpe Constante do Guerreiro (a cada 3 tarefas no dia)
    if (heroClass == HeroClass.warrior &&
        (totalTasksCompletedTodayBeforeThis + 1) % 3 == 0) {
      gold += 25;
      notes.add('Golpe Constante: +25 Ouro');
    }

    // 5. Missão Relâmpago ativa
    if (flashMissionActive) {
      final flashGold = heroClass == HeroClass.rogue ? 42.0 : 35.0;
      gold += flashGold;
      notes.add('Missão Relâmpago: +${flashGold.round()} Ouro');
    }

    // 6. Acerto Crítico (Dopamina Variável)
    final desLevel = attributeLevels[RpgAttribute.dexterity] ?? 1;
    final critChance = criticalChance(
      heroClass: heroClass,
      dexterityLevel: desLevel,
    );
    final isCrit = _rng.nextDouble() < critChance;
    var critMult = 1.0;
    if (isCrit) {
      critMult = _rng.nextBool() ? 1.5 : 2.0;
      xp *= critMult;
      gold *= critMult;
    }

    // 7. Chance de Baú Misterioso (aumenta com Sabedoria e dificuldade)
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
  }) {
    var xp = raidEnemyBaseXp.toDouble();
    var gold = raidEnemyBaseGold.toDouble();
    final notes = <String>[];

    if (isFinalEnemy) {
      xp += raidClearBonusXp;
      gold += raidClearBonusGold;
      notes.add('Raid Concluída: +$raidClearBonusXp XP e +$raidClearBonusGold Ouro');
    }

    // Bônus de Intelecto (+2% XP em Raids por nível) e Mago (+15% XP em Raids)
    final intLevel = attributeLevels[RpgAttribute.intellect] ?? 1;
    final intMult = 1.0 + (intLevel - 1) * 0.02;
    xp *= intMult;

    if (heroClass == HeroClass.mage) {
      xp *= 1.15;
      notes.add('Mago: +15% XP em Raid');
    }

    // Crítico também pode acontecer em golpes de Raid!
    final desLevel = attributeLevels[RpgAttribute.dexterity] ?? 1;
    final isCrit = _rng.nextDouble() <
        criticalChance(heroClass: heroClass, dexterityLevel: desLevel);
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

