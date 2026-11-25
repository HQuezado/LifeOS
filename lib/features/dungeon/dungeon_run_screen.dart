import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/audio/sound_fx.dart';
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
import 'dungeon_map_painter.dart';

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

class _FloatingCombatText {
  _FloatingCombatText({
    required this.text,
    required this.gridX,
    required this.gridY,
    required this.color,
    this.isBig = false,
    this.verticalOffset = 0.0,
  });

  final String text;
  final int gridX;
  final int gridY;
  final Color color;
  final bool isBig;
  final double verticalOffset;
}

class _DungeonRunScreenState extends ConsumerState<DungeonRunScreen>
    with SingleTickerProviderStateMixin {
  late HeroCombatStats _stats;
  late DungeonFloorMap _floor;
  late Random _combatRng;
  late List<DungeonItem> _equippedItems;
  DungeonTileAtlas? _atlas;
  int _repaintVersion = 0;

  // "Juice": números flutuantes, screen shake e flash de dano (sem timers soltos!)
  late final AnimationController _fxController;
  final List<_FloatingCombatText> _floatingTexts = [];
  double _shakeIntensity = 0.0;
  bool _hurtFlash = false;

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
    _fxController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          setState(() {
            _floatingTexts.clear();
            _shakeIntensity = 0.0;
            _hurtFlash = false;
          });
        }
      });
    _combatRng = Random(widget.seed ^ 0x55AA33);
    _equippedItems = [...widget.equippedItems];
    _stats = DungeonCombatEngine.computeHeroStats(
      heroLevel: widget.hero.level,
      heroClass: _heroClass,
      attributes: widget.attributes,
      equippedItems: _equippedItems,
    );
    _hp = _stats.maxHp;
    _mana = _stats.maxMana;
    _loadFloor(1);
    _loadAtlas();
    _pushLog(
      'Você entrou em ${widget.biome.name} (Seed #${widget.seed}). Boa caçada!',
    );
  }

  Future<void> _loadAtlas() async {
    final monsterPaths = _floor.enemies.map((e) => e.template.spriteAsset);
    final loaded = await DungeonTileAtlas.load(extraAssets: monsterPaths);
    if (!mounted) return;
    setState(() {
      _atlas = loaded;
      _repaintVersion++;
    });
  }

  void _recomputeEquippedStats(List<DungeonItem> newEquipped) {
    final oldMaxHp = _stats.maxHp;
    final oldMaxMp = _stats.maxMana;
    _equippedItems = newEquipped;
    _stats = DungeonCombatEngine.computeHeroStats(
      heroLevel: widget.hero.level,
      heroClass: _heroClass,
      attributes: widget.attributes,
      equippedItems: _equippedItems,
    );
    final hpGain = _stats.maxHp - oldMaxHp;
    final mpGain = _stats.maxMana - oldMaxMp;
    if (hpGain > 0) _hp = min(_stats.maxHp, _hp + hpGain);
    if (mpGain > 0) _mana = min(_stats.maxMana, _mana + mpGain);
    _hp = _hp.clamp(1, _stats.maxHp);
    _mana = _mana.clamp(0, _stats.maxMana);
    _floor.updateVisibility(_heroX, _heroY, _stats.visionRadius, _stats.wisdom);
    _repaintVersion++;
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
    _repaintVersion++;
    final atlas = _atlas;
    if (atlas != null) {
      atlas.ensureAssets(_floor.enemies.map((e) => e.template.spriteAsset)).then((_) {
        if (mounted) setState(() => _repaintVersion++);
      });
    }
  }

  @override
  void dispose() {
    _fxController.dispose();
    super.dispose();
  }

  void _spawnFloat(
    String text,
    int gx,
    int gy,
    Color color, {
    bool isBig = false,
  }) {
    final stackCount = _floatingTexts
        .where((f) => f.gridX == gx && f.gridY == gy)
        .length;
    _floatingTexts.add(
      _FloatingCombatText(
        text: text,
        gridX: gx,
        gridY: gy,
        color: color,
        isBig: isBig,
        verticalOffset: stackCount * 16.0,
      ),
    );
    _fxController.forward(from: 0.0);
  }

  void _triggerShake({double intensity = 5.0, bool hurtFlash = false}) {
    _shakeIntensity = max(_shakeIntensity, intensity);
    if (hurtFlash) _hurtFlash = true;
    _fxController.forward(from: 0.0);
  }

  void _sfx(String effect, {bool haptic = false, bool heavyHaptic = false}) {
    LifeOsSfx.play(
      effect,
      soundEnabled: widget.hero.soundEnabled,
      haptic: haptic,
      heavyHaptic: heavyHaptic,
    );
  }

  void _pushLog(String message) {
    _repaintVersion++;
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
      _sfx('step');
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
        _spawnFloat('-$lavaDmg 🔥', _heroX, _heroY, const Color(0xFFE86A38));
        _triggerShake(intensity: 5.5, hurtFlash: true);
        _sfx('hurt', haptic: true);
        _pushLog('A lava queima seus pés! -$lavaDmg HP (Queimadura).');
      } else if (tile == DungeonTileType.swamp && _combatRng.nextDouble() < 0.35) {
        _poisonTurns = max(_poisonTurns, 2);
        _spawnFloat('VENENO!', _heroX, _heroY, const Color(0xFF6CC44A));
        _pushLog('Vapor do pântano envenena você!');
      }

      // Checa armadilha
      final trap = _floor.trapAt(_heroX, _heroY);
      if (trap != null) {
        trap.isRevealed = true;
        trap.isTriggered = true;
        final dodgeTrap = _combatRng.nextDouble() < (_stats.dodgeChance * 0.8);
        if (dodgeTrap) {
          _spawnFloat('ESQUIVOU!', _heroX, _heroY, LifeOsColors.xpBar);
          _sfx('dodge');
          _pushLog('Armadilha disparou, mas sua Destreza evitou o dano!');
        } else {
          final dmg = max(2, trap.damage - (_stats.defense * 0.4).round());
          _hp = max(0, _hp - dmg);
          _spawnFloat('-$dmg', _heroX, _heroY, LifeOsColors.danger, isBig: true);
          _triggerShake(intensity: 7.0, hurtFlash: true);
          _sfx('hurt', heavyHaptic: true);
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
      _spawnFloat('ESQUIVOU!', target.x, target.y, LifeOsColors.xpBar);
      _sfx('dodge');
      _pushLog('${target.template.name} esquivou do seu ataque!');
      return;
    }

    target.hp = max(0, target.hp - res.damage);
    if (res.isCritical) {
      _spawnFloat(
        'CRÍTICO! -${res.damage}',
        target.x,
        target.y,
        LifeOsColors.gold,
        isBig: true,
      );
      _triggerShake(intensity: 6.5);
      _sfx('crit', heavyHaptic: true);
    } else {
      _spawnFloat('-${res.damage}', target.x, target.y, Colors.white);
      _sfx('hit', haptic: true);
    }
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
          _sfx('skill', heavyHaptic: true);
          _triggerShake(intensity: 6.5);
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
            _spawnFloat('-${res.damage} ⚡', e.x, e.y, LifeOsColors.gold, isBig: true);
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
          _sfx('skill', haptic: true);
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
          _spawnFloat('-${res.damage} ✨', target.x, target.y, LifeOsColors.xpBar, isBig: true);
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
          _sfx('crit', heavyHaptic: true);
          _triggerShake(intensity: 6.0);
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
          _spawnFloat('CRÍTICO! -${res.damage}', target.x, target.y, LifeOsColors.gold, isBig: true);
          _pushLog(
            '${skill.name}! CRÍTICO de ${res.damage} em ${target.template.name} (+Esquiva).',
          );
          if (!target.isAlive) _onEnemyDefeated(target);

        case HeroClass.alchemist:
          _mana -= skill.manaCost;
          _sfx('potion', haptic: true);
          final heal = max(
            18,
            (_stats.maxHp * 0.35 * _stats.potionHealMultiplier).round(),
          );
          _hp = min(_stats.maxHp, _hp + heal);
          _spawnFloat('+$heal HP', _heroX, _heroY, LifeOsColors.success, isBig: true);
          _poisonTurns = 0;
          _burnTurns = 0;
          _bleedTurns = 0;
          _slowTurns = 0;
          var poisonedCount = 0;
          for (final e in _floor.enemies) {
            if (e.isAlive && GridPos(_heroX, _heroY).manhattanTo(e.pos) <= 2) {
              e.poisonTurns = max(e.poisonTurns, 3);
              _spawnFloat('VENENO!', e.x, e.y, const Color(0xFF6CC44A));
              poisonedCount++;
            }
          }
          _pushLog(
            '${skill.name}: +$heal HP, status limpos${poisonedCount > 0 ? ' e $poisonedCount inimigo(s) envenenado(s)' : ''}!',
          );

        case HeroClass.bard:
          _mana -= skill.manaCost;
          _sfx('skill', haptic: true);
          _attackBuffValue = max(_attackBuffValue, (_stats.attackPower * 0.25).round() + 3);
          _attackBuffTurns = 3;
          _spawnFloat('+$_attackBuffValue ATQ', _heroX, _heroY, LifeOsColors.gold);
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
            _spawnFloat('-${res.damage} ♪', e.x, e.y, const Color(0xFFC078F8));
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
          _spawnFloat('+$heal HP', _heroX, _heroY, LifeOsColors.success, isBig: true);
          _sfx('potion', haptic: true);
          _pushLog('${item.name}: recuperou +$heal HP!');
        case 'heal_mana':
          _mana = min(_stats.maxMana, _mana + eff.value);
          _spawnFloat('+${eff.value} MP', _heroX, _heroY, const Color(0xFF5DA9FF), isBig: true);
          _sfx('potion', haptic: true);
          _pushLog('${item.name}: recuperou +${eff.value} MP!');
        case 'cure_status':
          _poisonTurns = 0;
          _burnTurns = 0;
          _bleedTurns = 0;
          _slowTurns = 0;
          _stunTurns = 0;
          _spawnFloat('PURIFICADO!', _heroX, _heroY, LifeOsColors.xpBar);
          _sfx('potion', haptic: true);
          _pushLog('${item.name}: todos os efeitos negativos foram purificados!');
        case 'reveal_map':
          _floor.revealAll();
          _spawnFloat('MAPA REVELADO!', _heroX, _heroY, LifeOsColors.gold);
          _sfx('skill', haptic: true);
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
            _spawnFloat('TELEPORTE!', _heroX, _heroY, LifeOsColors.xpBar);
            _sfx('skill', haptic: true);
            _pushLog('${item.name}: teleportado para um ponto seguro!');
          }
        case 'aoe_damage':
          final targets = _floor.enemies
              .where((e) => e.isAlive && _floor.visible[e.y][e.x])
              .toList();
          _triggerShake(intensity: 8.5);
          _sfx('crit', heavyHaptic: true);
          for (final e in targets) {
            final dmg = max(
              eff.value,
              eff.value + (_stats.magicPower * 0.4).round(),
            );
            e.hp = max(0, e.hp - dmg);
            _spawnFloat('-$dmg 💥', e.x, e.y, const Color(0xFFE86A38), isBig: true);
            if (!e.isAlive) _onEnemyDefeated(e);
          }
          _pushLog(
            '${item.name}! Explosão causou dano em ${targets.length} inimigo(s) visível(is)!',
          );
        case 'buff_attack':
          _attackBuffValue = max(_attackBuffValue, eff.value);
          _attackBuffTurns = 5;
          _spawnFloat('+${eff.value} ATQ!', _heroX, _heroY, LifeOsColors.gold, isBig: true);
          _sfx('potion', haptic: true);
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
    _spawnFloat('BAÚ! +${gold}g', chest.x, chest.y, LifeOsColors.gold, isBig: true);
    _sfx('chest', haptic: true);
    _pushLog('Baú aberto! +$gold ouro e ${item.name} (${item.rarity.label})!');
  }

  void _onEnemyDefeated(DungeonEnemy enemy) {
    _monstersSlain++;
    final xp = (enemy.template.xpReward * (1 + (_floorNumber - 1) * 0.12)).round();
    final gold = (enemy.template.goldReward * (1 + (_floorNumber - 1) * 0.12)).round();
    _earnedXp += xp;
    _earnedGold += gold;
    _spawnFloat('+${gold}g', enemy.x, enemy.y, LifeOsColors.gold);

    // Registra no Bestiário Colecionável (e celebra 1ª descoberta!)
    ref
        .read(dungeonRepositoryProvider)
        .recordMonsterDefeat(enemy.template.id)
        .then((isFirst) {
      if (isFirst && mounted) {
        setState(() {
          _spawnFloat('📖 BESTIÁRIO!', enemy.x, enemy.y, LifeOsColors.xpBar, isBig: true);
          _pushLog('📖 Novo registro no Bestiário: ${enemy.template.name}!');
        });
      }
    });

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
    _sfx('stairs', haptic: true);
    _spawnFloat('+$healHp HP', _heroX, _heroY, LifeOsColors.success);
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
      _spawnFloat('ESQUIVOU!', _heroX, _heroY, LifeOsColors.xpBar);
      _sfx('dodge');
      _pushLog('Você esquivou de ${attack.name} (${enemy.template.name})!');
      return;
    }

    _hp = max(0, _hp - res.damage);
    _spawnFloat(
      res.isCritical ? 'CRÍTICO -${res.damage}' : '-${res.damage}',
      _heroX,
      _heroY,
      LifeOsColors.danger,
      isBig: res.isCritical,
    );
    _triggerShake(intensity: res.isCritical ? 8.0 : 4.5, hurtFlash: true);
    _sfx('hurt', haptic: !res.isCritical, heavyHaptic: res.isCritical);
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
    if (victory) {
      _sfx('victory', heavyHaptic: true);
    }

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
              IconButton(
                onPressed: _openInDungeonInventory,
                tooltip: 'Abrir Mochila / Inventário',
                style: IconButton.styleFrom(
                  backgroundColor: LifeOsColors.bgDark,
                  side: const BorderSide(color: LifeOsColors.gold, width: 1.4),
                  shape: const RoundedRectangleBorder(),
                  padding: const EdgeInsets.all(6),
                  minimumSize: const Size(34, 34),
                ),
                icon: const Icon(
                  Icons.backpack_rounded,
                  size: 18,
                  color: LifeOsColors.gold,
                ),
              ),
              const SizedBox(width: 4),
              TextButton.icon(
                onPressed: _confirmRetreat,
                style: TextButton.styleFrom(
                  foregroundColor: LifeOsColors.textSecondary,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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

  /// Viewport GPU-acelerado (CustomPainter) com Auto-Tiling de Paredes 45°,
  /// Mesclagem Orgânica entre Grama/Terra/Água/Pântano/Lava e Sombras de Profundidade.
  Widget _buildDungeonViewport() {
    const tileSize = 48.0;
    final atlas = _atlas;

    return LayoutBuilder(
      builder: (context, constraints) {
        final centerX = constraints.maxWidth / 2;
        final centerY = constraints.maxHeight / 2;

        return SizedBox.expand(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (details) {
              final local = details.localPosition;
              final tx = _heroX + ((local.dx - centerX) / tileSize).round();
              final ty = _heroY + ((local.dy - centerY) / tileSize).round();
              _onTileTap(tx, ty);
            },
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _fxController,
                builder: (context, child) {
                  final t = _fxController.value;
                  // Tremidinha da câmera nos primeiros 25% da animação (~210ms)
                  var shakeX = 0.0;
                  var shakeY = 0.0;
                  if (_shakeIntensity > 0 && t < 0.28) {
                    final decay = 1.0 - (t / 0.28);
                    shakeX = sin(t * 95) * _shakeIntensity * decay;
                    shakeY = cos(t * 110) * _shakeIntensity * 0.6 * decay;
                  }
                  final flashAlpha = (_hurtFlash && t < 0.30)
                      ? ((1.0 - t / 0.30) * 0.38)
                      : 0.0;

                  return Transform.translate(
                    offset: Offset(shakeX, shakeY),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        child!,
                        // Textos e números flutuantes de combate sobre os tiles
                        if (_floatingTexts.isNotEmpty)
                          IgnorePointer(
                            child: Stack(
                              children: _floatingTexts.map((ft) {
                                final fx = centerX + (ft.gridX - _heroX) * tileSize;
                                final fy = centerY +
                                    (ft.gridY - _heroY) * tileSize -
                                    20 -
                                    ft.verticalOffset -
                                    (t * 34);
                                final opacity = (1.0 - Curves.easeIn.transform(t))
                                    .clamp(0.0, 1.0);
                                return Positioned(
                                  left: fx - 64,
                                  top: fy,
                                  width: 128,
                                  child: Opacity(
                                    opacity: opacity,
                                    child: Text(
                                      ft.text,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: ft.isBig ? 14.5 : 12.5,
                                        fontWeight: FontWeight.w900,
                                        color: ft.color,
                                        shadows: const [
                                          Shadow(color: Colors.black, offset: Offset(1.5, 1.5), blurRadius: 1),
                                          Shadow(color: Colors.black, offset: Offset(-1, -1), blurRadius: 1),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        // Vinheta vermelha suave ao sofrer dano
                        if (flashAlpha > 0.01)
                          IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: LifeOsColors.danger.withValues(alpha: flashAlpha * 2),
                                  width: 6,
                                ),
                                color: LifeOsColors.danger.withValues(alpha: flashAlpha * 0.45),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                child: ColoredBox(
                  color: const Color(0xFF100B0A),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (atlas != null)
                        CustomPaint(
                          painter: DungeonMapPainter(
                            floor: _floor,
                            atlas: atlas,
                            heroX: _heroX,
                            heroY: _heroY,
                            tileSize: tileSize,
                            repaintVersion: _repaintVersion,
                          ),
                        ),
                      // Herói animado no centro da câmera com sombra suave no chão
                      IgnorePointer(
                        child: Center(
                          child: SizedBox(
                            width: tileSize,
                            height: tileSize,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  bottom: 3,
                                  child: Container(
                                    width: tileSize * 0.56,
                                    height: 7,
                                    decoration: BoxDecoration(
                                      color: const Color(0x700A0605),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                HeroSpriteWidget(
                                  assetPath: _heroClass.spriteAsset,
                                  armorTint: _armorTint,
                                  size: tileSize * 0.94,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Abre a Mochila / Inventário do personagem sem precisar sair da masmorra.
  Future<void> _openInDungeonInventory() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: LifeOsColors.surface,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: LifeOsColors.gold, width: 2),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.72,
          minChildSize: 0.45,
          maxChildSize: 0.9,
          builder: (_, scrollController) {
            return Consumer(
              builder: (context, sheetRef, _) {
                final rows =
                    sheetRef.watch(dungeonInventoryProvider).value ?? const [];
                final equipRows = rows
                    .where((r) => r.slot != DungeonItemSlot.consumable.key)
                    .toList();
                final consRows = rows
                    .where((r) => r.slot == DungeonItemSlot.consumable.key)
                    .toList();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 12, 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.backpack_rounded,
                            color: LifeOsColors.gold,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'MOCHILA DO AVENTUREIRO',
                              style: LifeOsTheme.pixelTitle(
                                size: 10,
                                color: LifeOsColors.gold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          _StatusChip('HP $_hp/${_stats.maxHp}', LifeOsColors.danger),
                          _StatusChip('ATQ ${_stats.attackPower}', LifeOsColors.gold),
                          _StatusChip('MAG ${_stats.magicPower}', const Color(0xFFC078F8)),
                          _StatusChip('DEF ${_stats.defense}', LifeOsColors.success),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: LifeOsColors.border, height: 1),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(14),
                        children: [
                          Text(
                            'EQUIPAMENTOS (${equipRows.length})',
                            style: LifeOsTheme.pixelTitle(
                              size: 9,
                              color: LifeOsColors.gold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          for (final row in equipRows)
                            if (widget.catalog.itemById(row.itemId) != null)
                              _buildInRunEquipRow(
                                widget.catalog.itemById(row.itemId)!,
                                row,
                                rows,
                              ),
                          const SizedBox(height: 12),
                          Text(
                            'CONSUMÍVEIS',
                            style: LifeOsTheme.pixelTitle(
                              size: 9,
                              color: LifeOsColors.gold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (consRows.isEmpty)
                            const Text(
                              'Nenhum consumível restante na mochila.',
                              style: TextStyle(
                                fontSize: 12,
                                color: LifeOsColors.textMuted,
                              ),
                            )
                          else
                            for (final row in consRows)
                              if (widget.catalog.itemById(row.itemId) != null)
                                _buildInRunConsumableRow(
                                  widget.catalog.itemById(row.itemId)!,
                                  row,
                                  ctx,
                                ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildInRunEquipRow(
    DungeonItem item,
    DungeonInventoryData row,
    List<DungeonInventoryData> allRows,
  ) {
    final chips = item.bonuses.summaryChips();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: LifeOsColors.bgDark,
        border: Border.all(
          color: row.isEquipped
              ? LifeOsColors.gold
              : item.rarity.color.withValues(alpha: 0.6),
          width: row.isEquipped ? 2 : 1.2,
        ),
      ),
      child: Row(
        children: [
          PixelIcon(item.iconAsset, size: 36),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: item.rarity.color,
                  ),
                ),
                Text(
                  chips.join(' • '),
                  style: const TextStyle(
                    fontSize: 11,
                    color: LifeOsColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: row.isEquipped
                  ? LifeOsColors.surfaceHighlight
                  : LifeOsColors.gold,
              foregroundColor:
                  row.isEquipped ? LifeOsColors.gold : LifeOsColors.bgDark,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: const RoundedRectangleBorder(),
            ),
            onPressed: () async {
              final repo = ref.read(dungeonRepositoryProvider);
              if (row.isEquipped) {
                await repo.unequipItem(item.id);
              } else {
                await repo.equipItem(item.id, item.slot);
              }
              final updatedRows = await repo.getInventory();
              final nextEquipped = <DungeonItem>[];
              for (final r in updatedRows) {
                if (r.isEquipped) {
                  final found = widget.catalog.itemById(r.itemId);
                  if (found != null) nextEquipped.add(found);
                }
              }
              if (!mounted) return;
              setState(() {
                _recomputeEquippedStats(nextEquipped);
                _pushLog(
                  row.isEquipped
                      ? 'Desequipou ${item.name}.'
                      : 'Equipou ${item.name} (${chips.join(', ')})!',
                );
              });
            },
            child: Text(
              row.isEquipped ? 'EQUIPADO' : 'EQUIPAR',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInRunConsumableRow(
    DungeonItem item,
    DungeonInventoryData row,
    BuildContext sheetContext,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: LifeOsColors.bgDark,
        border: Border.all(color: item.rarity.color.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          PixelIcon(item.iconAsset, size: 34),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.name} x${row.quantity}',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: item.rarity.color,
                  ),
                ),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: LifeOsColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: LifeOsColors.gold,
              foregroundColor: LifeOsColors.bgDark,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: const RoundedRectangleBorder(),
            ),
            onPressed: () async {
              Navigator.of(sheetContext).pop();
              await _useConsumable(item);
            },
            child: const Text(
              'USAR',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
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

  String _shortConsumableLabel(DungeonItem item) {
    final eff = item.consumableEffect;
    if (eff == null) return item.name;
    switch (eff.kind) {
      case 'heal_hp':
        return 'Vida +${eff.value}';
      case 'heal_mana':
        return 'Mana +${eff.value}';
      case 'cure_status':
        return 'Antídoto';
      case 'teleport':
        return 'Teleporte';
      case 'reveal_map':
        return 'Mapa';
      case 'aoe_damage':
        return 'Área ${eff.value}';
      case 'buff_attack':
        return '+${eff.value} ATQ';
      default:
        return item.name;
    }
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
                                _shortConsumableLabel(entry.item),
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

