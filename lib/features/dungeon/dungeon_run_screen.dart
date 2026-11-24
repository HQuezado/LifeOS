import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/dungeon/dungeon_catalog.dart';
import '../../core/dungeon/dungeon_combat.dart';
import '../../core/dungeon/dungeon_generator.dart';
import '../../core/dungeon/dungeon_models.dart';
import '../../core/rpg/reward_engine.dart';
import '../../core/rpg/rpg_models.dart';
import '../../core/theme/lifeos_theme.dart';
import '../../core/widgets/hero_sprite_widget.dart';
import '../../core/widgets/pixel_panel.dart';
import '../../data/database/app_database.dart';
import '../../providers/app_providers.dart';

/// Tela jogável da Masmorra Procedural estilo Pixel Dungeon (turnos, névoa de guerra,
/// habilidades de classe, consumíveis, baús, armadilhas e Boss final).
class DungeonRunScreen extends ConsumerStatefulWidget {
  const DungeonRunScreen({
    super.key,
    required this.hero,
    required this.attributes,
    required this.equippedItems,
    required this.catalog,
    required this.biome,
    required this.seed,
  });

  final HeroProfile hero;
  final Map<RpgAttribute, int> attributes;
  final List<DungeonItem> equippedItems;
  final DungeonCatalog catalog;
  final DungeonBiome biome;
  final int seed;

  @override
  ConsumerState<DungeonRunScreen> createState() => _DungeonRunScreenState();
}

class _DungeonRunScreenState extends ConsumerState<DungeonRunScreen> {
  late HeroCombatStats _stats;
  late DungeonFloorMap _floor;
  late Random _combatRng;

  int _floorNumber = 1;
  int _heroX = 0;
  int _heroY = 0;
  int _hp = 0;
  int _mana = 0;

  // Status temporários no herói
  int _poisonTurns = 0;
  int _burnTurns = 0;
  int _bleedTurns = 0;
  int _slowTurns = 0;
  int _stunTurns = 0;
  int _attackBuffValue = 0;
  int _attackBuffTurns = 0;
  int _dodgeBuffTurns = 0;

  // Recompensas acumuladas durante a expedição
  int _earnedGold = 0;
  int _earnedXp = 0;
  int _monstersSlain = 0;
  final List<DungeonItem> _foundItems = [];
  final List<String> _log = [];

  bool _runEnded = false;
  bool _victory = false;
  bool _rewardClaimed = false;
  DungeonEnemy? _inspectedEnemy;

  HeroClass get _heroClass => HeroClass.fromKey(widget.hero.heroClass);
  ArmorTint get _armorTint => ArmorTint.fromKey(widget.hero.armorTint);

  @override
  void initState() {
    super.initState();
    _combatRng = Random(widget.seed ^ 0x55AA33);
    _stats = DungeonCombatEngine.computeHeroStats(
      heroLevel: widget.hero.level,
      heroClass: _heroClass,
      attributes: widget.attributes,
      equippedItems: widget.equippedItems,
    );
    _hp = _stats.maxHp;
    _mana = _stats.maxMana;
    _loadFloor(1);
    _pushLog(
      'Você entrou em ${widget.biome.name} (Seed #${widget.seed}). Boa caçada!',
    );
  }

  void _loadFloor(int floorNumber) {
    _floorNumber = floorNumber;
    _floor = DungeonGenerator.generateFloor(
      biome: widget.biome,
      seed: widget.seed,
      floorNumber: floorNumber,
      heroLevel: widget.hero.level,
      catalog: widget.catalog,
    );
    _heroX = _floor.startPos.x;
    _heroY = _floor.startPos.y;
    _inspectedEnemy = null;
    _floor.updateVisibility(
      _heroX,
      _heroY,
      _stats.visionRadius,
      _stats.wisdom,
    );
  }

  void _pushLog(String message) {
    _log.insert(0, message);
    if (_log.length > 30) {
      _log.removeLast();
    }
  }

  /// Move 1 casa (dx, dy) ou ataca inimigo adjacente.
  void _stepHero(int dx, int dy) {
    if (_runEnded) return;
    if (_stunTurns > 0) {
      setState(() {
        _stunTurns--;
        _pushLog('Você está atordoado e perde o turno!');
        _processTurnEnd();
      });
      return;
    }

    final nx = _heroX + dx;
    final ny = _heroY + dy;
    if (!_floor.inBounds(nx, ny)) return;

    final enemy = _floor.enemyAt(nx, ny);
    if (enemy != null) {
      setState(() {
        _inspectedEnemy = enemy;
        _heroMeleeAttack(enemy);
        _processTurnEnd();
      });
      return;
    }

    final tile = _floor.tileAt(nx, ny);
    if (!tile.walkable) {
      setState(() {
        _pushLog(
          tile == DungeonTileType.water
              ? 'Água profunda bloqueia a passagem.'
              : 'Caminho bloqueado.',
        );
      });
      return;
    }

    setState(() {
      _heroX = nx;
      _heroY = ny;
      _floor.updateVisibility(
        _heroX,
        _heroY,
        _stats.visionRadius,
        _stats.wisdom,
      );

      // Checa terreno perigoso
      if (tile == DungeonTileType.lava) {
        final lavaDmg = max(4, (_stats.maxHp * 0.08).round());
        _hp = max(0, _hp - lavaDmg);
        _burnTurns = max(_burnTurns, 2);
        _pushLog('A lava queima seus pés! -$lavaDmg HP (Queimadura).');
      } else if (tile == DungeonTileType.swamp && _combatRng.nextDouble() < 0.35) {
        _poisonTurns = max(_poisonTurns, 2);
        _pushLog('Vapor do pântano envenena você!');
      }

      // Checa armadilha
      final trap = _floor.trapAt(_heroX, _heroY);
      if (trap != null) {
        trap.isRevealed = true;
        trap.isTriggered = true;
        final dodgeTrap = _combatRng.nextDouble() < (_stats.dodgeChance * 0.8);
        if (dodgeTrap) {
          _pushLog('Armadilha disparou, mas sua Destreza evitou o dano!');
        } else {
          final dmg = max(2, trap.damage - (_stats.defense * 0.4).round());
          _hp = max(0, _hp - dmg);
          _pushLog('Armadilha de espinhos! Você sofreu $dmg de dano.');
        }
      }

      // Checa baú
      final chest = _floor.chestAt(_heroX, _heroY);
      if (chest != null) {
        _openDungeonChest(chest);
      }

      // Checa escada para o próximo andar
      if (_heroX == _floor.stairsPos.x && _heroY == _floor.stairsPos.y) {
        if (_floor.isBossFloor) {
          if (_floor.isBossDefeated) {
            _finishRun(victory: true);
            return;
          } else {
            _pushLog('O portal só abre depois de derrotar ${widget.biome.bossName}!');
          }
        } else {
          _descendNextFloor();
          return;
        }
      }

      _processTurnEnd();
    });
  }

  /// Espera 1 turno e recupera um pouco de fôlego (+2 HP / +3 MP).
  void _waitTurn() {
    if (_runEnded) return;
    setState(() {
      _hp = min(_stats.maxHp, _hp + 2);
      _mana = min(_stats.maxMana, _mana + 3);
      _pushLog('Você recupera o fôlego (+2 HP, +3 MP).');
      _processTurnEnd();
    });
  }

  void _heroMeleeAttack(DungeonEnemy target) {
    final totalAtk = _stats.attackPower + _attackBuffValue;
    final res = DungeonCombatEngine.resolveAttack(
      rng: _combatRng,
      attackerPower: totalAtk,
      multiplier: 1.0,
      defenderDefense: target.defense,
      attackerCritChance: _stats.critChance,
      defenderDodgeChance: target.dodgeChance,
    );

    if (res.dodged) {
      _pushLog('${target.template.name} esquivou do seu ataque!');
      return;
    }

    target.hp = max(0, target.hp - res.damage);
    final critTag = res.isCritical ? ' (CRÍTICO!)' : '';
    _pushLog('Você causou ${res.damage}$critTag em ${target.template.name}.');

    if (!target.isAlive) {
      _onEnemyDefeated(target);
    }
  }

  /// Dispara a Habilidade Ativa da Classe do herói.
  void _useClassSkill() {
    if (_runEnded) return;
    final skill = DungeonCombatEngine.skillForClass(_heroClass);
    if (_mana < skill.manaCost) {
      setState(() {
        _pushLog('Mana insuficiente para ${skill.name} (${skill.manaCost} MP).');
      });
      return;
    }

    setState(() {
      switch (_heroClass) {
        case HeroClass.warrior:
          final adjacent = _floor.enemies
              .where((e) =>
                  e.isAlive &&
                  GridPos(_heroX, _heroY).chebyshevTo(e.pos) <= 1)
              .toList();
          if (adjacent.isEmpty) {
            _pushLog('Nenhum inimigo ao alcance para ${skill.name}.');
            return;
          }
          _mana -= skill.manaCost;
          for (final e in adjacent) {
            final res = DungeonCombatEngine.resolveAttack(
              rng: _combatRng,
              attackerPower: _stats.attackPower + _attackBuffValue,
              multiplier: 1.6,
              defenderDefense: e.defense,
              attackerCritChance: _stats.critChance,
              defenderDodgeChance: 0,
              cannotDodge: true,
            );
            e.hp = max(0, e.hp - res.damage);
            e.stunTurns = max(e.stunTurns, 1);
            _pushLog('${skill.name}! ${res.damage} em ${e.template.name} (Atordoado).');
            if (!e.isAlive) _onEnemyDefeated(e);
          }

        case HeroClass.mage:
          final target = _findNearestVisibleEnemy(maxRange: 4);
          if (target == null) {
            _pushLog('Nenhum inimigo visível a até 4 casas para ${skill.name}.');
            return;
          }
          _mana -= skill.manaCost;
          _inspectedEnemy = target;
          final res = DungeonCombatEngine.resolveAttack(
            rng: _combatRng,
            attackerPower: _stats.magicPower + _attackBuffValue,
            multiplier: 1.85,
            defenderDefense: (target.defense * 0.5).round(),
            attackerCritChance: _stats.critChance,
            defenderDodgeChance: 0,
            cannotDodge: true,
          );
          target.hp = max(0, target.hp - res.damage);
          final critTag = res.isCritical ? ' (CRÍTICO!)' : '';
          _pushLog(
            '${skill.name}! ${res.damage}$critTag de dano arcano em ${target.template.name}.',
          );
          if (!target.isAlive) _onEnemyDefeated(target);

        case HeroClass.rogue:
          final target = _findNearestVisibleEnemy(maxRange: 2);
          if (target == null) {
            _pushLog('Aproxime-se a até 2 casas de um inimigo para ${skill.name}.');
            return;
          }
          _mana -= skill.manaCost;
          _dodgeBuffTurns = 2;
          _inspectedEnemy = target;
          final res = DungeonCombatEngine.resolveAttack(
            rng: _combatRng,
            attackerPower: _stats.attackPower + _attackBuffValue,
            multiplier: 1.15,
            defenderDefense: (target.defense * 0.4).round(),
            attackerCritChance: 1.0,
            defenderDodgeChance: 0,
            guaranteedCrit: true,
            cannotDodge: true,
          );
          target.hp = max(0, target.hp - res.damage);
          _pushLog(
            '${skill.name}! CRÍTICO de ${res.damage} em ${target.template.name} (+Esquiva).',
          );
          if (!target.isAlive) _onEnemyDefeated(target);

        case HeroClass.alchemist:
          _mana -= skill.manaCost;
          final heal = max(
            18,
            (_stats.maxHp * 0.35 * _stats.potionHealMultiplier).round(),
          );
          _hp = min(_stats.maxHp, _hp + heal);
          _poisonTurns = 0;
          _burnTurns = 0;
          _bleedTurns = 0;
          _slowTurns = 0;
          var poisonedCount = 0;
          for (final e in _floor.enemies) {
            if (e.isAlive && GridPos(_heroX, _heroY).manhattanTo(e.pos) <= 2) {
              e.poisonTurns = max(e.poisonTurns, 3);
              poisonedCount++;
            }
          }
          _pushLog(
            '${skill.name}: +$heal HP, status limpos${poisonedCount > 0 ? ' e $poisonedCount inimigo(s) envenenado(s)' : ''}!',
          );

        case HeroClass.bard:
          _mana -= skill.manaCost;
          _attackBuffValue = max(_attackBuffValue, (_stats.attackPower * 0.25).round() + 3);
          _attackBuffTurns = 3;
          final nearby = _floor.enemies
              .where((e) =>
                  e.isAlive && GridPos(_heroX, _heroY).manhattanTo(e.pos) <= 2)
              .toList();
          for (final e in nearby) {
            final res = DungeonCombatEngine.resolveAttack(
              rng: _combatRng,
              attackerPower: _stats.magicPower,
              multiplier: 1.25,
              defenderDefense: (e.defense * 0.5).round(),
              attackerCritChance: _stats.critChance,
              defenderDodgeChance: 0,
              cannotDodge: true,
            );
            e.hp = max(0, e.hp - res.damage);
            e.slowTurns = max(e.slowTurns, 2);
            if (!e.isAlive) _onEnemyDefeated(e);
          }
          _pushLog(
            '${skill.name}! +$_attackBuffValue ATQ por 3 turnos${nearby.isNotEmpty ? ' e ${nearby.length} inimigo(s) atingido(s)' : ''}!',
          );
      }

      _processTurnEnd();
    });
  }

  DungeonEnemy? _findNearestVisibleEnemy({required int maxRange}) {
    DungeonEnemy? best;
    var bestDist = 999;
    final heroPos = GridPos(_heroX, _heroY);
    for (final e in _floor.enemies) {
      if (!e.isAlive || !_floor.visible[e.y][e.x]) continue;
      final d = heroPos.manhattanTo(e.pos);
      if (d <= maxRange && d < bestDist) {
        bestDist = d;
        best = e;
      }
    }
    return best;
  }

  /// Usa um consumível da mochila durante a expedição.
  Future<void> _useConsumable(DungeonItem item) async {
    if (_runEnded || item.consumableEffect == null) return;
    final consumed =
        await ref.read(dungeonRepositoryProvider).consumeItem(item.id);
    if (!consumed || !mounted) return;

    final eff = item.consumableEffect!;
    setState(() {
      switch (eff.kind) {
        case 'heal_hp':
          final heal = (eff.value * _stats.potionHealMultiplier).round();
          _hp = min(_stats.maxHp, _hp + heal);
          _pushLog('${item.name}: recuperou +$heal HP!');
        case 'heal_mana':
          _mana = min(_stats.maxMana, _mana + eff.value);
          _pushLog('${item.name}: recuperou +${eff.value} MP!');
        case 'cure_status':
          _poisonTurns = 0;
          _burnTurns = 0;
          _bleedTurns = 0;
          _slowTurns = 0;
          _stunTurns = 0;
          _pushLog('${item.name}: todos os efeitos negativos foram purificados!');
        case 'reveal_map':
          _floor.revealAll();
          _pushLog('${item.name}: todo o andar e suas armadilhas foram revelados!');
        case 'teleport':
          final safeTiles = <GridPos>[];
          for (var y = 1; y < _floor.height - 1; y++) {
            for (var x = 1; x < _floor.width - 1; x++) {
              final t = _floor.tileAt(x, y);
              if (t.walkable &&
                  t != DungeonTileType.lava &&
                  _floor.enemyAt(x, y) == null) {
                safeTiles.add(GridPos(x, y));
              }
            }
          }
          if (safeTiles.isNotEmpty) {
            final dest = safeTiles[_combatRng.nextInt(safeTiles.length)];
            _heroX = dest.x;
            _heroY = dest.y;
            _floor.updateVisibility(
              _heroX,
              _heroY,
              _stats.visionRadius,
              _stats.wisdom,
            );
            _pushLog('${item.name}: teleportado para um ponto seguro!');
          }
        case 'aoe_damage':
          final targets = _floor.enemies
              .where((e) => e.isAlive && _floor.visible[e.y][e.x])
              .toList();
          for (final e in targets) {
            final dmg = max(
              eff.value,
              eff.value + (_stats.magicPower * 0.4).round(),
            );
            e.hp = max(0, e.hp - dmg);
            if (!e.isAlive) _onEnemyDefeated(e);
          }
          _pushLog(
            '${item.name}! Explosão causou dano em ${targets.length} inimigo(s) visível(is)!',
          );
        case 'buff_attack':
          _attackBuffValue = max(_attackBuffValue, eff.value);
          _attackBuffTurns = 5;
          _pushLog('${item.name}: +${eff.value} ATQ pelos próximos 5 turnos!');
      }
      _processTurnEnd();
    });
  }

  void _openDungeonChest(DungeonChest chest) {
    chest.isOpened = true;
    final rarity = DungeonCombatEngine.rollDropRarity(
      _combatRng,
      lootLuckBonus: _stats.lootLuckBonus,
      floorNumber: _floorNumber,
      fromBoss: _floor.isBossFloor,
    );
    final preferEquip = _combatRng.nextDouble() < 0.60;
    final item = widget.catalog.rollLootItem(
      _combatRng,
      targetRarity: rarity,
      preferEquipment: preferEquip,
    );
    final gold = 15 + _floorNumber * 8 + _combatRng.nextInt(15);
    _earnedGold += gold;
    _foundItems.add(item);
    ref.read(dungeonRepositoryProvider).addItem(item);
    _pushLog('Baú aberto! +$gold ouro e ${item.name} (${item.rarity.label})!');
  }

  void _onEnemyDefeated(DungeonEnemy enemy) {
    _monstersSlain++;
    final xp = (enemy.template.xpReward * (1 + (_floorNumber - 1) * 0.12)).round();
    final gold = (enemy.template.goldReward * (1 + (_floorNumber - 1) * 0.12)).round();
    _earnedXp += xp;
    _earnedGold += gold;

    if (_inspectedEnemy?.uid == enemy.uid) {
      _inspectedEnemy = null;
    }

    // Chance de dropar item (100% no Boss, 28% em mobs comuns)
    final dropChance = enemy.isBoss ? 1.0 : (0.28 + _stats.lootLuckBonus * 0.5);
    if (_combatRng.nextDouble() < dropChance) {
      final rarity = DungeonCombatEngine.rollDropRarity(
        _combatRng,
        lootLuckBonus: _stats.lootLuckBonus,
        floorNumber: _floorNumber,
        fromBoss: enemy.isBoss,
      );
      final drop = widget.catalog.rollLootItem(
        _combatRng,
        targetRarity: rarity,
        preferEquipment: enemy.isBoss || _combatRng.nextDouble() < 0.45,
      );
      _foundItems.add(drop);
      ref.read(dungeonRepositoryProvider).addItem(drop);
      _pushLog(
        '${enemy.template.name} derrotado! +$xp XP, +$gold ouro e drop: ${drop.name}!',
      );
    } else {
      _pushLog('${enemy.template.name} derrotado! +$xp XP e +$gold ouro.');
    }

    if (enemy.isBoss) {
      _pushLog('🏆 ${enemy.template.name} caiu! Pise na escada para concluir a expedição!');
    }
  }

  void _descendNextFloor() {
    final nextFloor = _floorNumber + 1;
    // Descanso entre andares: recupera 25% HP e 30% Mana
    final healHp = (_stats.maxHp * 0.25).round();
    final healMp = (_stats.maxMana * 0.30).round();
    _hp = min(_stats.maxHp, _hp + healHp);
    _mana = min(_stats.maxMana, _mana + healMp);

    _loadFloor(nextFloor);
    _pushLog(
      _floor.isBossFloor
          ? '🔥 Andar $nextFloor/${widget.biome.maxFloors} — ARENA DO BOSS (${widget.biome.bossName})!'
          : '⬇️ Você desceu ao Andar $nextFloor/${widget.biome.maxFloors} (+$healHp HP, +$healMp MP).',
    );
  }

  /// Processa efeitos por turno do herói e turnos de todos os monstros despertos.
  void _processTurnEnd() {
    if (_runEnded) return;

    // Regeneração suave de mana (1 MP/turno)
    if (_mana < _stats.maxMana) {
      _mana = min(_stats.maxMana, _mana + 1);
    }

    // Dano de status no herói
    if (_poisonTurns > 0) {
      _poisonTurns--;
      final d = max(2, (_stats.maxHp * 0.04).round());
      _hp = max(0, _hp - d);
      _pushLog('Veneno causa $d de dano.');
    }
    if (_burnTurns > 0) {
      _burnTurns--;
      final d = max(3, (_stats.maxHp * 0.05).round());
      _hp = max(0, _hp - d);
      _pushLog('Queimadura causa $d de dano.');
    }
    if (_bleedTurns > 0) {
      _bleedTurns--;
      final d = max(2, (_stats.maxHp * 0.04).round());
      _hp = max(0, _hp - d);
      _pushLog('Sangramento causa $d de dano.');
    }
    if (_slowTurns > 0) _slowTurns--;
    if (_dodgeBuffTurns > 0) _dodgeBuffTurns--;
    if (_attackBuffTurns > 0) {
      _attackBuffTurns--;
      if (_attackBuffTurns == 0) _attackBuffValue = 0;
    }

    if (_hp <= 0) {
      _finishRun(victory: false);
      return;
    }

    // Turno dos monstros despertos
    final heroPos = GridPos(_heroX, _heroY);
    for (final enemy in _floor.enemies) {
      if (!enemy.isAlive || !enemy.isAlerted) continue;

      if (enemy.poisonTurns > 0) {
        enemy.poisonTurns--;
        final pDmg = max(3, (enemy.maxHp * 0.08).round());
        enemy.hp = max(0, enemy.hp - pDmg);
        if (!enemy.isAlive) {
          _onEnemyDefeated(enemy);
          continue;
        }
      }

      if (enemy.stunTurns > 0) {
        enemy.stunTurns--;
        continue;
      }

      if (enemy.slowTurns > 0) {
        enemy.slowTurns--;
        if (_combatRng.nextBool()) continue; // 50% chance de pular ação quando lento
      }

      final dist = heroPos.manhattanTo(enemy.pos);
      final usableAttacks = enemy.template.attacks
          .where((a) => a.range >= dist)
          .toList();

      if (usableAttacks.isNotEmpty && _floor.visible[enemy.y][enemy.x]) {
        final atk = usableAttacks[_combatRng.nextInt(usableAttacks.length)];
        _enemyPerformAttack(enemy, atk);
        if (_hp <= 0) {
          _finishRun(victory: false);
          return;
        }
      } else {
        _moveEnemyTowardHero(enemy);
      }
    }
  }

  void _enemyPerformAttack(DungeonEnemy enemy, MonsterAttack attack) {
    final heroTile = _floor.tileAt(_heroX, _heroY);
    var heroDodge = _stats.dodgeChance + (_dodgeBuffTurns > 0 ? 0.20 : 0.0);
    if (heroTile == DungeonTileType.swamp || _slowTurns > 0) {
      heroDodge *= 0.5;
    }

    final atkPower = attack.isMagic ? enemy.magicPower : enemy.attackPower;
    final def = attack.isMagic ? (_stats.defense * 0.7).round() : _stats.defense;

    final res = DungeonCombatEngine.resolveAttack(
      rng: _combatRng,
      attackerPower: atkPower,
      multiplier: attack.multiplier,
      defenderDefense: def,
      attackerCritChance: enemy.critChance,
      defenderDodgeChance: heroDodge.clamp(0.02, 0.55),
      effect: attack.effect,
    );

    if (res.dodged) {
      _pushLog('Você esquivou de ${attack.name} (${enemy.template.name})!');
      return;
    }

    _hp = max(0, _hp - res.damage);
    if (res.lifesteal > 0) {
      enemy.hp = min(enemy.maxHp, enemy.hp + res.lifesteal);
    }

    var effNote = '';
    switch (res.appliedEffect) {
      case 'poison':
        _poisonTurns = max(_poisonTurns, 3);
        effNote = ' [Veneno]';
      case 'burn':
        _burnTurns = max(_burnTurns, 2);
        effNote = ' [Queimadura]';
      case 'bleed':
        _bleedTurns = max(_bleedTurns, 2);
        effNote = ' [Sangramento]';
      case 'slow':
        _slowTurns = max(_slowTurns, 2);
        effNote = ' [Lento]';
      case 'stun':
        _stunTurns = max(_stunTurns, 1);
        effNote = ' [Atordoado]';
      case 'drain':
        effNote = ' [Drenou +${res.lifesteal} HP]';
    }

    final critTag = res.isCritical ? ' CRÍTICO!' : '';
    _pushLog(
      '${enemy.template.name} usou ${attack.name}: -${res.damage} HP$critTag$effNote',
    );
  }

  void _moveEnemyTowardHero(DungeonEnemy enemy) {
    final dx = (_heroX - enemy.x).sign;
    final dy = (_heroY - enemy.y).sign;
    final candidates = <GridPos>[
      if (dx != 0) GridPos(enemy.x + dx, enemy.y),
      if (dy != 0) GridPos(enemy.x, enemy.y + dy),
    ];

    for (final c in candidates) {
      if (c.x == _heroX && c.y == _heroY) continue;
      if (!_floor.inBounds(c.x, c.y)) continue;
      final t = _floor.tileAt(c.x, c.y);
      if (t.walkable &&
          t != DungeonTileType.lava &&
          _floor.enemyAt(c.x, c.y) == null) {
        enemy.x = c.x;
        enemy.y = c.y;
        return;
      }
    }
  }

  Future<void> _finishRun({required bool victory, bool voluntaryExit = false}) async {
    if (_runEnded) return;
    _runEnded = true;
    _victory = victory;

    if (!_rewardClaimed) {
      _rewardClaimed = true;
      final factor = (victory || voluntaryExit) ? 1.0 : 0.6;
      final clearBonusXp = victory ? (90 + widget.biome.maxFloors * 20) : 0;
      final clearBonusGold = victory ? (75 + widget.biome.maxFloors * 18) : 0;
      final totalXp = (_earnedXp * factor).round() + clearBonusXp;
      final totalGold = (_earnedGold * factor).round() + clearBonusGold;

      final ChestRarity? rewardChest = victory
          ? (widget.biome.maxFloors >= 8 ? ChestRarity.epic : ChestRarity.rare)
          : null;

      await ref.read(dungeonRepositoryProvider).recordProgress(
            biome: widget.biome,
            reachedFloor: _floorNumber,
            seed: widget.seed,
            defeatedBoss: victory,
          );

      if (totalXp > 0 || totalGold > 0 || rewardChest != null) {
        await ref.read(heroRepositoryProvider).awardProgress(
              attribute: _heroClass.primaryAttribute,
              xpGained: totalXp,
              goldGained: totalGold,
              droppedChest: rewardChest,
              chestSource: 'Masmorra: ${widget.biome.name}',
            );
      }
    }
    if (mounted) setState(() {});
  }

  void _onTileTap(int tx, int ty) {
    if (_runEnded) return;
    final enemy = _floor.enemyAt(tx, ty);
    if (enemy != null && _floor.visible[ty][tx]) {
      final dist = GridPos(_heroX, _heroY).manhattanTo(enemy.pos);
      if (dist == 1) {
        _stepHero(tx - _heroX, ty - _heroY);
        return;
      }
      setState(() => _inspectedEnemy = enemy);
      return;
    }

    final dx = tx - _heroX;
    final dy = ty - _heroY;
    if (dx == 0 && dy == 0) {
      _waitTurn();
      return;
    }
    if (dx.abs() >= dy.abs()) {
      _stepHero(dx.sign, 0);
    } else {
      _stepHero(0, dy.sign);
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventoryRows = ref.watch(dungeonInventoryProvider).value ?? const [];
    final consumables = <({DungeonItem item, int qty})>[];
    for (final row in inventoryRows) {
      if (row.slot == DungeonItemSlot.consumable.key && row.quantity > 0) {
        final item = widget.catalog.itemById(row.itemId);
        if (item != null) {
          consumables.add((item: item, qty: row.quantity));
        }
      }
    }

    final skill = DungeonCombatEngine.skillForClass(_heroClass);

    return Scaffold(
      backgroundColor: LifeOsColors.bgDark,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildTopHud(),
                Expanded(
                  child: Stack(
                    children: [
                      _buildDungeonViewport(),
                      if (_inspectedEnemy != null && _inspectedEnemy!.isAlive)
                        Positioned(
                          top: 8,
                          left: 10,
                          right: 10,
                          child: _buildEnemyInspector(_inspectedEnemy!),
                        ),
                    ],
                  ),
                ),
                _buildCombatLogStrip(),
                _buildBottomControls(skill, consumables),
              ],
            ),
            if (_runEnded) _buildEndOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHud() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
      decoration: const BoxDecoration(
        color: LifeOsColors.surface,
        border: Border(
          bottom: BorderSide(color: LifeOsColors.border, width: 2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.biome.name.toUpperCase()} • $_floorNumber/${widget.biome.maxFloors}',
                      style: LifeOsTheme.pixelTitle(
                        size: 9,
                        color: widget.biome.accentColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Seed #${widget.seed} • 💰 +$_earnedGold • ⭐ +$_earnedXp XP',
                      style: const TextStyle(
                        fontSize: 11,
                        color: LifeOsColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: _confirmRetreat,
                style: TextButton.styleFrom(
                  foregroundColor: LifeOsColors.textSecondary,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                icon: const Icon(Icons.exit_to_app_rounded, size: 16),
                label: const Text('Sair', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _CompactStatBar(
                  label: 'HP $_hp/${_stats.maxHp}',
                  ratio: _stats.maxHp > 0 ? _hp / _stats.maxHp : 0,
                  color: LifeOsColors.danger,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CompactStatBar(
                  label: 'MP $_mana/${_stats.maxMana}',
                  ratio: _stats.maxMana > 0 ? _mana / _stats.maxMana : 0,
                  color: const Color(0xFF5DA9FF),
                ),
              ),
            ],
          ),
          if (_poisonTurns > 0 ||
              _burnTurns > 0 ||
              _bleedTurns > 0 ||
              _slowTurns > 0 ||
              _attackBuffTurns > 0) ...[
            const SizedBox(height: 5),
            Wrap(
              spacing: 6,
              children: [
                if (_poisonTurns > 0)
                  _StatusChip('Veneno (${_poisonTurns}t)', const Color(0xFF6CC44A)),
                if (_burnTurns > 0)
                  _StatusChip('Queimadura (${_burnTurns}t)', const Color(0xFFE86A38)),
                if (_bleedTurns > 0)
                  _StatusChip('Sangrando (${_bleedTurns}t)', LifeOsColors.danger),
                if (_slowTurns > 0)
                  _StatusChip('Lento (${_slowTurns}t)', const Color(0xFF9C8CE0)),
                if (_attackBuffTurns > 0)
                  _StatusChip('+$_attackBuffValue ATQ (${_attackBuffTurns}t)', LifeOsColors.gold),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// Viewport de câmera centrada no herói renderizando os tiles 16-bit + Névoa + Monstros.
  Widget _buildDungeonViewport() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const tileSize = 46.0;
        final colsVisible = (constraints.maxWidth / tileSize).ceil() + 2;
        final rowsVisible = (constraints.maxHeight / tileSize).ceil() + 2;

        final halfCols = colsVisible ~/ 2;
        final halfRows = rowsVisible ~/ 2;

        final mapWidgets = <Widget>[];
        final centerX = constraints.maxWidth / 2;
        final centerY = constraints.maxHeight / 2;

        for (var y = _heroY - halfRows; y <= _heroY + halfRows; y++) {
          for (var x = _heroX - halfCols; x <= _heroX + halfCols; x++) {
            if (!_floor.inBounds(x, y)) continue;
            final explored = _floor.explored[y][x];
            if (!explored) continue;

            final visible = _floor.visible[y][x];
            final tile = _floor.tileAt(x, y);
            if (tile == DungeonTileType.voidWall) continue;

            final left = centerX + (x - _heroX) * tileSize - tileSize / 2;
            final top = centerY + (y - _heroY) * tileSize - tileSize / 2;

            final enemy = visible ? _floor.enemyAt(x, y) : null;
            final chest = _floor.chestAt(x, y);
            final trap = _floor.trapAt(x, y);
            final isHero = x == _heroX && y == _heroY;

            mapWidgets.add(
              Positioned(
                left: left,
                top: top,
                width: tileSize,
                height: tileSize,
                child: GestureDetector(
                  onTap: () => _onTileTap(x, y),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Base floor underneath overlays (stairs, pillar, door)
                      if (tile.overlayOnFloor && _floor.baseFloorTile.asset != null)
                        Image.asset(
                          _floor.baseFloorTile.asset!,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.none,
                        ),
                      if (tile.asset != null)
                        Image.asset(
                          tile.asset!,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.none,
                        ),
                      // Armadilha revelada
                      if (trap != null && trap.isRevealed)
                        Image.asset(
                          'assets/images/dungeon/tiles/prop_trap.png',
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.none,
                        ),
                      // Baú
                      if (chest != null)
                        Image.asset(
                          'assets/images/dungeon/tiles/prop_chest.png',
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.none,
                        ),
                      // Escurecimento de Névoa de Guerra fora do campo de visão
                      if (!visible)
                        Container(color: const Color(0x9E0E0A09)),
                      // Inimigo visível
                      if (enemy != null) _buildEnemyTileSprite(enemy, tileSize),
                      // Herói no centro
                      if (isHero)
                        Center(
                          child: HeroSpriteWidget(
                            assetPath: _heroClass.spriteAsset,
                            armorTint: _armorTint,
                            size: tileSize * 0.94,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
        }

        return Container(
          color: const Color(0xFF100B0A),
          clipBehavior: Clip.hardEdge,
          child: Stack(children: mapWidgets),
        );
      },
    );
  }

  Widget _buildEnemyTileSprite(DungeonEnemy enemy, double tileSize) {
    final hpRatio = enemy.maxHp > 0 ? (enemy.hp / enemy.maxHp).clamp(0.0, 1.0) : 0.0;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (enemy.isBoss)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: LifeOsColors.danger, width: 1.5),
                color: LifeOsColors.danger.withValues(alpha: 0.16),
              ),
            ),
          ),
        Center(
          child: Image.asset(
            enemy.template.spriteAsset,
            width: enemy.isBoss ? tileSize * 1.04 : tileSize * 0.9,
            height: enemy.isBoss ? tileSize * 1.04 : tileSize * 0.9,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.none,
          ),
        ),
        Positioned(
          left: 4,
          right: 4,
          top: 1,
          child: Container(
            height: 4,
            color: const Color(0xCC0E0A09),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: hpRatio,
              child: Container(
                color: enemy.isBoss ? LifeOsColors.gold : LifeOsColors.danger,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnemyInspector(DungeonEnemy enemy) {
    final s = enemy.scaledStats;
    return GestureDetector(
      onTap: () => setState(() => _inspectedEnemy = null),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: LifeOsColors.surface.withValues(alpha: 0.95),
          border: Border.all(
            color: enemy.isBoss ? LifeOsColors.gold : LifeOsColors.danger,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              enemy.template.spriteAsset,
              width: 44,
              height: 44,
              filterQuality: FilterQuality.none,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${enemy.isBoss ? '👑 ' : ''}${enemy.template.name}  (${enemy.hp}/${enemy.maxHp} HP)',
                    style: LifeOsTheme.pixelTitle(
                      size: 8.5,
                      color: enemy.isBoss ? LifeOsColors.gold : LifeOsColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'VIG ${s[RpgAttribute.vigor]} • INT ${s[RpgAttribute.intellect]} • DES ${s[RpgAttribute.dexterity]} • ATQ ${enemy.attackPower} • DEF ${enemy.defense}',
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: LifeOsColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.close_rounded, size: 16, color: LifeOsColors.textMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildCombatLogStrip() {
    final recent = _log.take(2).toList();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: const BoxDecoration(
        color: Color(0xFF140E0C),
        border: Border(
          top: BorderSide(color: LifeOsColors.border, width: 1.5),
          bottom: BorderSide(color: LifeOsColors.border, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < recent.length; i++)
            Text(
              recent[i],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: i == 0 ? FontWeight.w700 : FontWeight.w500,
                color: i == 0 ? LifeOsColors.textPrimary : LifeOsColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(
    ClassDungeonSkill skill,
    List<({DungeonItem item, int qty})> consumables,
  ) {
    final canCast = _mana >= skill.manaCost;
    return Container(
      color: LifeOsColors.surface,
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barra rápida de consumíveis
          if (consumables.isNotEmpty) ...[
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: consumables.length,
                separatorBuilder: (_, _) => const SizedBox(width: 6),
                itemBuilder: (_, i) {
                  final entry = consumables[i];
                  return GestureDetector(
                    onTap: () => _useConsumable(entry.item),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: LifeOsColors.bgDark,
                        border: Border.all(
                          color: entry.item.rarity.color.withValues(alpha: 0.7),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PixelIcon(entry.item.iconAsset, size: 26),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.item.name.split(' ').take(2).join(' '),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: LifeOsColors.textPrimary,
                                ),
                              ),
                              Text(
                                'x${entry.qty}',
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  color: LifeOsColors.gold,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              // D-Pad compacto 3x3
              SizedBox(
                width: 132,
                height: 112,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _DpadBtn(icon: Icons.keyboard_arrow_up_rounded, onTap: () => _stepHero(0, -1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _DpadBtn(icon: Icons.keyboard_arrow_left_rounded, onTap: () => _stepHero(-1, 0)),
                        _DpadBtn(
                          icon: Icons.hourglass_bottom_rounded,
                          onTap: _waitTurn,
                          highlight: true,
                        ),
                        _DpadBtn(icon: Icons.keyboard_arrow_right_rounded, onTap: () => _stepHero(1, 0)),
                      ],
                    ),
                    _DpadBtn(icon: Icons.keyboard_arrow_down_rounded, onTap: () => _stepHero(0, 1)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Habilidade da Classe + Dica de toque no mapa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: canCast ? _useClassSkill : null,
                      child: Opacity(
                        opacity: canCast ? 1.0 : 0.45,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _heroClass.accentColor.withValues(alpha: 0.2),
                            border: Border.all(
                              color: canCast ? _heroClass.accentColor : LifeOsColors.border,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      skill.name.toUpperCase(),
                                      style: LifeOsTheme.pixelTitle(
                                        size: 8.5,
                                        color: LifeOsColors.gold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${skill.manaCost} MP',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF73EFF7),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                skill.description,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: LifeOsColors.textSecondary,
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Toque no mapa ou use as setas. Toque num monstro distante para ver a ficha.',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: LifeOsColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEndOverlay() {
    return Container(
      color: const Color(0xCC120D0C),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: PixelPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _victory ? 'MASMORRA CONQUISTADA!' : 'EXPEDIÇÃO ENCERRADA',
                textAlign: TextAlign.center,
                style: LifeOsTheme.pixelTitle(
                  size: 12,
                  color: _victory ? LifeOsColors.gold : LifeOsColors.danger,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _victory
                    ? 'Você derrotou ${widget.biome.bossName} e conquistou ${widget.biome.name}!'
                    : 'Você caiu no andar $_floorNumber/${widget.biome.maxFloors}, mas voltou para casa com seus itens intactos e parte do tesouro!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: LifeOsColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: LifeOsColors.bgDark,
                  border: Border.all(color: LifeOsColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Andar alcançado: $_floorNumber / ${widget.biome.maxFloors} (Seed #${widget.seed})',
                      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Inimigos vencidos: $_monstersSlain',
                      style: const TextStyle(fontSize: 12.5, color: LifeOsColors.textSecondary),
                    ),
                    Text(
                      'Tesouro coletado: +$_earnedGold ouro • +$_earnedXp XP${_victory ? ' + Bônus de Boss & Baú!' : ''}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: LifeOsColors.gold,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (_foundItems.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Itens na mochila (${_foundItems.length}): ${_foundItems.map((i) => i.name).join(', ')}',
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: LifeOsColors.success,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              PixelButton(
                label: 'VOLTAR AO ACAMPAMENTO',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmRetreat() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: LifeOsColors.surface,
        title: Text(
          'SAIR DA MASMORRA?',
          style: LifeOsTheme.pixelTitle(size: 10.5, color: LifeOsColors.gold),
        ),
        content: const Text(
          'Você volta seguro para casa mantendo 100% dos itens, ouro e XP conquistados até agora.',
          style: TextStyle(color: LifeOsColors.textSecondary, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Continuar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Retornar com Loot',
              style: TextStyle(color: LifeOsColors.gold, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      await _finishRun(victory: false, voluntaryExit: true);
      if (mounted) Navigator.of(context).pop();
    }
  }
}

class _CompactStatBar extends StatelessWidget {
  const _CompactStatBar({
    required this.label,
    required this.ratio,
    required this.color,
  });

  final String label;
  final double ratio;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      decoration: BoxDecoration(
        color: LifeOsColors.bgDark,
        border: Border.all(color: LifeOsColors.border),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: ratio.clamp(0.0, 1.0),
            child: Container(color: color.withValues(alpha: 0.78)),
          ),
          Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black, blurRadius: 2)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: color),
      ),
    );
  }
}

class _DpadBtn extends StatelessWidget {
  const _DpadBtn({
    required this.icon,
    required this.onTap,
    this.highlight = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 34,
        decoration: BoxDecoration(
          color: highlight ? LifeOsColors.surfaceHighlight : LifeOsColors.bgDark,
          border: Border.all(
            color: highlight ? LifeOsColors.gold : LifeOsColors.border,
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: 22,
          color: highlight ? LifeOsColors.gold : LifeOsColors.textPrimary,
        ),
      ),
    );
  }
}

