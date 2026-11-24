import 'dart:math';

import '../rpg/rpg_models.dart';
import 'dungeon_models.dart';

/// Status calculados do Herói dentro da Masmorra (atributos reais + equipamentos).
class HeroCombatStats {
  const HeroCombatStats({
    required this.heroLevel,
    required this.heroClass,
    required this.attributes,
    required this.maxHp,
    required this.maxMana,
    required this.attackPower,
    required this.magicPower,
    required this.defense,
    required this.dodgeChance,
    required this.critChance,
    required this.visionRadius,
    required this.potionHealMultiplier,
    required this.lootLuckBonus,
  });

  final int heroLevel;
  final HeroClass heroClass;
  final Map<RpgAttribute, int> attributes;
  final int maxHp;
  final int maxMana;
  final int attackPower;
  final int magicPower;
  final int defense;
  final double dodgeChance;
  final double critChance;
  final int visionRadius;
  final double potionHealMultiplier;
  final double lootLuckBonus;

  int get vigor => attributes[RpgAttribute.vigor] ?? 1;
  int get intellect => attributes[RpgAttribute.intellect] ?? 1;
  int get dexterity => attributes[RpgAttribute.dexterity] ?? 1;
  int get wisdom => attributes[RpgAttribute.wisdom] ?? 1;
  int get charisma => attributes[RpgAttribute.charisma] ?? 1;
}

/// Descrição da Habilidade Ativa da Classe dentro da masmorra.
class ClassDungeonSkill {
  const ClassDungeonSkill({
    required this.name,
    required this.description,
    required this.manaCost,
  });

  final String name;
  final String description;
  final int manaCost;
}

/// Resultado de um golpe (do herói ou de um monstro).
class StrikeResult {
  const StrikeResult({
    required this.dodged,
    required this.isCritical,
    required this.damage,
    this.lifesteal = 0,
    this.appliedEffect,
  });

  final bool dodged;
  final bool isCritical;
  final int damage;
  final int lifesteal;
  final String? appliedEffect;
}

/// Motor de fórmulas de combate por turnos da Fase 6 (DUNGEON_DESIGN.md).
class DungeonCombatEngine {
  const DungeonCombatEngine._();

  /// Habilidade ativa de cada classe dentro da masmorra.
  static ClassDungeonSkill skillForClass(HeroClass heroClass) {
    switch (heroClass) {
      case HeroClass.warrior:
        return const ClassDungeonSkill(
          name: 'Golpe Sísmico',
          description: '1.6x dano físico em todos os inimigos adjacentes + atordoa.',
          manaCost: 12,
        );
      case HeroClass.mage:
        return const ClassDungeonSkill(
          name: 'Rajada Arcana',
          description: 'Dispara 1.85x poder mágico no inimigo visível até 4 casas.',
          manaCost: 14,
        );
      case HeroClass.rogue:
        return const ClassDungeonSkill(
          name: 'Passo Sombrio',
          description: 'Acerto crítico garantido (1.75x) até 2 casas + foco de esquiva.',
          manaCost: 10,
        );
      case HeroClass.alchemist:
        return const ClassDungeonSkill(
          name: 'Elixir Místico',
          description: 'Cura 35% HP, purifica status e envenena inimigos próximos.',
          manaCost: 12,
        );
      case HeroClass.bard:
        return const ClassDungeonSkill(
          name: 'Acorde Inspirador',
          description: 'Dano mágico em raio 2, lentidão nos inimigos e +20% ataque.',
          manaCost: 12,
        );
    }
  }

  /// Calcula todos os status derivados do herói a partir de nível, 5 atributos e equipamentos.
  static HeroCombatStats computeHeroStats({
    required int heroLevel,
    required HeroClass heroClass,
    required Map<RpgAttribute, int> attributes,
    required List<DungeonItem> equippedItems,
  }) {
    var bonuses = ItemBonuses.zero;
    for (final item in equippedItems) {
      bonuses = bonuses + item.bonuses;
    }

    final vig = attributes[RpgAttribute.vigor] ?? 1;
    final intl = attributes[RpgAttribute.intellect] ?? 1;
    final des = attributes[RpgAttribute.dexterity] ?? 1;
    final sab = attributes[RpgAttribute.wisdom] ?? 1;
    final car = attributes[RpgAttribute.charisma] ?? 1;

    final classCritBonus = heroClass == HeroClass.rogue ? 0.08 : 0.0;

    final maxHp = 50 + (vig * 12) + (heroLevel * 5) + bonuses.maxHp;
    final maxMana = 20 + (intl * 6) + bonuses.maxMana;
    final attackPower = (6 + (vig * 1.6) + (des * 0.8)).round() + bonuses.attack;
    final magicPower = (8 + (intl * 2.2)).round() + bonuses.magic;
    final defense = (2 + (vig * 0.9)).round() + bonuses.defense;

    final dodgeChance =
        (0.05 + des * 0.011 + bonuses.dodgeChance).clamp(0.05, 0.42);
    final critChance =
        (0.08 + des * 0.012 + classCritBonus + bonuses.critChance)
            .clamp(0.08, 0.55);

    final visionRadius = (3 + (sab ~/ 5)).clamp(3, 6);
    final potionHealMultiplier = 1.0 + (sab * 0.04);
    final lootLuckBonus = car * 0.02;

    return HeroCombatStats(
      heroLevel: heroLevel,
      heroClass: heroClass,
      attributes: attributes,
      maxHp: maxHp,
      maxMana: maxMana,
      attackPower: attackPower,
      magicPower: magicPower,
      defense: defense,
      dodgeChance: dodgeChance,
      critChance: critChance,
      visionRadius: visionRadius,
      potionHealMultiplier: potionHealMultiplier,
      lootLuckBonus: lootLuckBonus,
    );
  }

  /// Escala os 5 atributos do monstro conforme o nível do herói e o andar atual.
  static Map<RpgAttribute, int> scaleMonsterAttributes({
    required MonsterTemplate template,
    required int heroLevel,
    required int floorNumber,
  }) {
    final levelFactor = 1.0 + (heroLevel - 1) * 0.14;
    final floorFactor = 1.0 + (floorNumber - 1) * 0.18;
    final bossFactor = template.isBoss ? 1.45 : 1.0;
    final total = levelFactor * floorFactor * bossFactor;

    return {
      for (final attr in RpgAttribute.values)
        attr: max(1, ((template.stats[attr] ?? 2) * total).round()),
    };
  }

  /// Constrói uma instância viva de monstro com HP, ATQ, MAG, DEF, ESQ e CRIT escalados.
  static DungeonEnemy instantiateEnemy({
    required int uid,
    required MonsterTemplate template,
    required int x,
    required int y,
    required int heroLevel,
    required int floorNumber,
  }) {
    final stats = scaleMonsterAttributes(
      template: template,
      heroLevel: heroLevel,
      floorNumber: floorNumber,
    );
    final vig = stats[RpgAttribute.vigor] ?? 2;
    final intl = stats[RpgAttribute.intellect] ?? 1;
    final des = stats[RpgAttribute.dexterity] ?? 2;

    // Curva equilibrada: mobs comuns são vencíveis em 2-4 golpes, Bosses duram uma batalha épica!
    final baseHp = template.isBoss
        ? (68 + vig * 13 + floorNumber * 8)
        : (20 + vig * 7 + floorNumber * 3);
    final attackPower = (4 + vig * 1.15 + des * 0.65).round();
    final magicPower = (5 + intl * 1.45).round();
    final defense = (1 + vig * 0.55).round();
    final dodge = (0.03 + des * 0.008).clamp(0.03, 0.25);
    final crit = (0.05 + des * 0.008).clamp(0.05, 0.30);

    return DungeonEnemy(
      uid: uid,
      template: template,
      x: x,
      y: y,
      scaledStats: stats,
      maxHp: baseHp,
      hp: baseHp,
      attackPower: attackPower,
      magicPower: magicPower,
      defense: defense,
      dodgeChance: dodge,
      critChance: crit,
    );
  }

  /// Resolve um ataque (físico ou mágico) entre duas entidades.
  static StrikeResult resolveAttack({
    required Random rng,
    required int attackerPower,
    required double multiplier,
    required int defenderDefense,
    required double attackerCritChance,
    required double defenderDodgeChance,
    bool guaranteedCrit = false,
    bool cannotDodge = false,
    String? effect,
  }) {
    if (!cannotDodge && rng.nextDouble() < defenderDodgeChance) {
      return const StrikeResult(dodged: true, isCritical: false, damage: 0);
    }

    final isCrit = guaranteedCrit || rng.nextDouble() < attackerCritChance;
    final raw = attackerPower * multiplier;
    final reduction = defenderDefense * 0.65;
    final variance = 0.90 + rng.nextDouble() * 0.20;
    final critMult = isCrit ? 1.75 : 1.0;

    final damage = max(1, ((raw - reduction) * variance * critMult).round());

    String? appliedEffect;
    var lifesteal = 0;
    if (effect != null) {
      if (effect == 'drain') {
        lifesteal = max(2, (damage * 0.35).round());
        appliedEffect = 'drain';
      } else if (rng.nextDouble() < 0.40) {
        appliedEffect = effect;
      }
    }

    return StrikeResult(
      dodged: false,
      isCritical: isCrit,
      damage: damage,
      lifesteal: lifesteal,
      appliedEffect: appliedEffect,
    );
  }

  /// Sorteia a raridade de um drop considerando Carisma (`lootLuckBonus`) e andar.
  static ItemRarity rollDropRarity(
    Random rng, {
    required double lootLuckBonus,
    required int floorNumber,
    bool fromBoss = false,
  }) {
    final bonus = lootLuckBonus + (floorNumber - 1) * 0.03 + (fromBoss ? 0.35 : 0.0);
    final roll = rng.nextDouble() + bonus;
    if (roll >= 1.28) return ItemRarity.legendary;
    if (roll >= 0.98) return ItemRarity.epic;
    if (roll >= 0.68) return ItemRarity.rare;
    if (roll >= 0.38) return ItemRarity.uncommon;
    return ItemRarity.common;
  }
}

