import 'package:material_ui/material_ui.dart';

import '../rpg/rpg_models.dart';

/// Os 5 biomas de masmorras procedurais do LifeOS (Fase 6).
enum DungeonBiome {
  forest(
    key: 'forest',
    name: 'Bosque Sussurrante',
    subtitle: 'Trilhas úmidas, clareiras floridas e raízes vivas.',
    maxFloors: 5,
    bossId: 'boss_forest_elder_treant',
    bossName: 'Ente Ancião Corrompido',
    previewTileAsset: 'assets/images/dungeon/tiles/floor_grass.png',
    accentColor: Color(0xFF56C271),
    hazardDescription: 'Poças de água intransponíveis e armadilhas camufladas.',
  ),
  catacombs(
    key: 'catacombs',
    name: 'Catacumbas de Pedra',
    subtitle: 'Corredores antigos guardados por ossos e sombras.',
    maxFloors: 7,
    bossId: 'boss_catacombs_lich_warden',
    bossName: 'Lich Guardião das Tumbas',
    previewTileAsset: 'assets/images/dungeon/tiles/floor_stone.png',
    accentColor: Color(0xFF9C8CE0),
    hazardDescription: 'Colunas antigas, portas cerradas e armadilhas de espinhos.',
  ),
  swamp(
    key: 'swamp',
    name: 'Pântano Envenenado',
    subtitle: 'Lagoas borbulhantes onde cada passo exige cuidado.',
    maxFloors: 8,
    bossId: 'boss_swamp_hydra',
    bossName: 'Hidra do Brejo',
    previewTileAsset: 'assets/images/dungeon/tiles/tile_swamp.png',
    accentColor: Color(0xFF8FB83E),
    hazardDescription: 'Pântano tóxico que envenena e reduz a esquiva ao pisar.',
  ),
  desert(
    key: 'desert',
    name: 'Deserto das Dunas',
    subtitle: 'Templos soterrados, areia dourada e oásis escondidos.',
    maxFloors: 8,
    bossId: 'boss_desert_pharaoh',
    bossName: 'Faraó Escorpião',
    previewTileAsset: 'assets/images/dungeon/tiles/floor_sand.png',
    accentColor: Color(0xFFE8B44A),
    hazardDescription: 'Pilares de arenito, oásis de água e inimigos velozes.',
  ),
  volcano(
    key: 'volcano',
    name: 'Fornalha Vulcânica',
    subtitle: 'O coração incandescente onde dorme o dragão primordial.',
    maxFloors: 10,
    bossId: 'boss_volcano_ignis_lord',
    bossName: 'Ignis, Dragão da Fornalha',
    previewTileAsset: 'assets/images/dungeon/tiles/tile_lava.png',
    accentColor: Color(0xFFE45A38),
    hazardDescription: 'Fissuras de lava que causam dano térmico e queimadura.',
  );

  const DungeonBiome({
    required this.key,
    required this.name,
    required this.subtitle,
    required this.maxFloors,
    required this.bossId,
    required this.bossName,
    required this.previewTileAsset,
    required this.accentColor,
    required this.hazardDescription,
  });

  final String key;
  final String name;
  final String subtitle;
  final int maxFloors;
  final String bossId;
  final String bossName;
  final String previewTileAsset;
  final Color accentColor;
  final String hazardDescription;

  String get bossSpriteAsset => 'assets/images/dungeon/monsters/$bossId.png';

  static DungeonBiome fromKey(String key) {
    return DungeonBiome.values.firstWhere(
      (b) => b.key == key,
      orElse: () => DungeonBiome.forest,
    );
  }
}

/// Tipos de tiles no grid procedural (mapeados 1:1 para `assets/images/dungeon/tiles/`).
enum DungeonTileType {
  voidWall(walkable: false, blocksSight: true, asset: null),
  wallBrick(
    walkable: false,
    blocksSight: true,
    asset: 'assets/images/dungeon/tiles/wall_brick.png',
  ),
  pillar(
    walkable: false,
    blocksSight: true,
    asset: 'assets/images/dungeon/tiles/wall_pillar.png',
    overlayOnFloor: true,
  ),
  floorStone(
    walkable: true,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/floor_stone.png',
  ),
  floorGrass(
    walkable: true,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/floor_grass.png',
  ),
  floorDirt(
    walkable: true,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/floor_dirt.png',
  ),
  floorSand(
    walkable: true,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/floor_sand.png',
  ),
  water(
    walkable: false,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/tile_water.png',
  ),
  swamp(
    walkable: true,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/tile_swamp.png',
  ),
  lava(
    walkable: true,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/tile_lava.png',
  ),
  door(
    walkable: true,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/door_closed.png',
    overlayOnFloor: true,
  ),
  stairsDown(
    walkable: true,
    blocksSight: false,
    asset: 'assets/images/dungeon/tiles/stairs_down.png',
    overlayOnFloor: true,
  );

  const DungeonTileType({
    required this.walkable,
    required this.blocksSight,
    required this.asset,
    this.overlayOnFloor = false,
  });

  final bool walkable;
  final bool blocksSight;
  final String? asset;
  final bool overlayOnFloor;
}

/// Raridades de equipamentos e consumíveis.
enum ItemRarity {
  common(key: 'common', label: 'Comum', color: Color(0xFFB8A99A), rank: 0),
  uncommon(key: 'uncommon', label: 'Incomum', color: Color(0xFF56C271), rank: 1),
  rare(key: 'rare', label: 'Raro', color: Color(0xFF5DA9FF), rank: 2),
  epic(key: 'epic', label: 'Épico', color: Color(0xFFC078F8), rank: 3),
  legendary(
    key: 'legendary',
    label: 'Lendário',
    color: Color(0xFFFFCD75),
    rank: 4,
  );

  const ItemRarity({
    required this.key,
    required this.label,
    required this.color,
    required this.rank,
  });

  final String key;
  final String label;
  final Color color;
  final int rank;

  static ItemRarity fromKey(String key) {
    return ItemRarity.values.firstWhere(
      (r) => r.key == key,
      orElse: () => ItemRarity.common,
    );
  }
}

/// Slot de inventário.
enum DungeonItemSlot {
  weapon(key: 'weapon', label: 'Arma'),
  armor(key: 'armor', label: 'Armadura'),
  ring(key: 'ring', label: 'Anel / Amuleto'),
  consumable(key: 'consumable', label: 'Consumível');

  const DungeonItemSlot({required this.key, required this.label});

  final String key;
  final String label;

  static DungeonItemSlot fromKey(String key) {
    return DungeonItemSlot.values.firstWhere(
      (s) => s.key == key,
      orElse: () => DungeonItemSlot.consumable,
    );
  }
}

/// Ataque de um monstro do bestiário.
class MonsterAttack {
  const MonsterAttack({
    required this.name,
    required this.type,
    required this.multiplier,
    required this.range,
    this.effect,
  });

  final String name;
  final String type; // physical | magic
  final double multiplier;
  final int range;
  final String? effect; // poison, burn, slow, stun, bleed, drain, null

  bool get isMagic => type == 'magic';

  factory MonsterAttack.fromJson(Map<String, dynamic> json) {
    return MonsterAttack(
      name: json['name'] as String,
      type: json['type'] as String? ?? 'physical',
      multiplier: (json['multiplier'] as num?)?.toDouble() ?? 1.0,
      range: (json['range'] as num?)?.toInt() ?? 1,
      effect: json['effect'] as String?,
    );
  }
}

/// Ficha base de um monstro em `assets/data/bestiary.json`.
class MonsterTemplate {
  const MonsterTemplate({
    required this.id,
    required this.name,
    required this.biome,
    required this.isBoss,
    required this.minFloor,
    required this.description,
    required this.stats,
    required this.xpReward,
    required this.goldReward,
    required this.attacks,
  });

  final String id;
  final String name;
  final DungeonBiome biome;
  final bool isBoss;
  final int minFloor;
  final String description;
  final Map<RpgAttribute, int> stats;
  final int xpReward;
  final int goldReward;
  final List<MonsterAttack> attacks;

  String get spriteAsset => 'assets/images/dungeon/monsters/$id.png';

  factory MonsterTemplate.fromJson(Map<String, dynamic> json) {
    final rawStats = (json['stats'] as Map<String, dynamic>?) ?? const {};
    final parsedStats = <RpgAttribute, int>{
      for (final attr in RpgAttribute.values)
        attr: (rawStats[attr.key] as num?)?.toInt() ?? 2,
    };
    final rawAttacks = (json['attacks'] as List<dynamic>?) ?? const [];
    return MonsterTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      biome: DungeonBiome.fromKey(json['biome'] as String? ?? 'forest'),
      isBoss: json['isBoss'] as bool? ?? false,
      minFloor: (json['minFloor'] as num?)?.toInt() ?? 1,
      description: json['description'] as String? ?? '',
      stats: parsedStats,
      xpReward: (json['xpReward'] as num?)?.toInt() ?? 20,
      goldReward: (json['goldReward'] as num?)?.toInt() ?? 15,
      attacks: rawAttacks
          .map((e) => MonsterAttack.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Bônus passivos de um equipamento.
class ItemBonuses {
  const ItemBonuses({
    this.attack = 0,
    this.magic = 0,
    this.defense = 0,
    this.maxHp = 0,
    this.maxMana = 0,
    this.critChance = 0.0,
    this.dodgeChance = 0.0,
  });

  final int attack;
  final int magic;
  final int defense;
  final int maxHp;
  final int maxMana;
  final double critChance;
  final double dodgeChance;

  static const ItemBonuses zero = ItemBonuses();

  factory ItemBonuses.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ItemBonuses.zero;
    return ItemBonuses(
      attack: (json['attack'] as num?)?.toInt() ?? 0,
      magic: (json['magic'] as num?)?.toInt() ?? 0,
      defense: (json['defense'] as num?)?.toInt() ?? 0,
      maxHp: (json['maxHp'] as num?)?.toInt() ?? 0,
      maxMana: (json['maxMana'] as num?)?.toInt() ?? 0,
      critChance: (json['critChance'] as num?)?.toDouble() ?? 0.0,
      dodgeChance: (json['dodgeChance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  ItemBonuses operator +(ItemBonuses other) {
    return ItemBonuses(
      attack: attack + other.attack,
      magic: magic + other.magic,
      defense: defense + other.defense,
      maxHp: maxHp + other.maxHp,
      maxMana: maxMana + other.maxMana,
      critChance: critChance + other.critChance,
      dodgeChance: dodgeChance + other.dodgeChance,
    );
  }

  List<String> summaryChips() {
    final chips = <String>[];
    if (attack > 0) chips.add('+$attack ATQ');
    if (magic > 0) chips.add('+$magic MAG');
    if (defense > 0) chips.add('+$defense DEF');
    if (maxHp > 0) chips.add('+$maxHp HP');
    if (maxMana > 0) chips.add('+$maxMana MP');
    if (critChance > 0) chips.add('+${(critChance * 100).round()}% CRIT');
    if (dodgeChance > 0) chips.add('+${(dodgeChance * 100).round()}% ESQ');
    return chips;
  }
}

/// Efeito de um consumível dentro da masmorra.
class ConsumableEffect {
  const ConsumableEffect({required this.kind, required this.value});

  final String kind; // heal_hp, heal_mana, cure_status, teleport, reveal_map, aoe_damage, buff_attack
  final int value;

  factory ConsumableEffect.fromJson(Map<String, dynamic> json) {
    return ConsumableEffect(
      kind: json['kind'] as String? ?? 'heal_hp',
      value: (json['value'] as num?)?.toInt() ?? 30,
    );
  }
}

/// Definição de um item (equipamento ou consumível) em `assets/data/dungeon_items.json`.
class DungeonItem {
  const DungeonItem({
    required this.id,
    required this.name,
    required this.slot,
    required this.material,
    required this.rarity,
    required this.price,
    required this.description,
    this.bonuses = ItemBonuses.zero,
    this.consumableEffect,
  });

  final String id;
  final String name;
  final DungeonItemSlot slot;
  final String material;
  final ItemRarity rarity;
  final int price;
  final String description;
  final ItemBonuses bonuses;
  final ConsumableEffect? consumableEffect;

  bool get isConsumable => slot == DungeonItemSlot.consumable;
  int get sellPrice => (price * 0.5).round().clamp(5, 9999);

  /// Mapeia o item para o ícone pixel art correspondente em `assets/images/dungeon/items/`.
  String get iconAsset {
    final lower = '$id ${name.toLowerCase()}';
    switch (slot) {
      case DungeonItemSlot.weapon:
        if (lower.contains('staff') ||
            lower.contains('wand') ||
            lower.contains('scepter') ||
            lower.contains('cajado') ||
            lower.contains('varinha') ||
            lower.contains('cetro')) {
          return 'assets/images/dungeon/items/icon_weapon_staff.png';
        }
        if (lower.contains('dagger') ||
            lower.contains('rapier') ||
            lower.contains('katana') ||
            lower.contains('scimitar')) {
          return 'assets/images/dungeon/items/icon_weapon_daggers.png';
        }
        if (lower.contains('wood') || lower.contains('bone')) {
          return 'assets/images/dungeon/items/icon_weapon_wood.png';
        }
        return 'assets/images/dungeon/items/icon_weapon_steel.png';
      case DungeonItemSlot.armor:
        if (lower.contains('robe') ||
            lower.contains('vestment') ||
            lower.contains('mantle') ||
            lower.contains('manto')) {
          return 'assets/images/dungeon/items/icon_armor_robe.png';
        }
        if (lower.contains('leather') || lower.contains('wood')) {
          return 'assets/images/dungeon/items/icon_armor_leather.png';
        }
        if (lower.contains('aegis') ||
            lower.contains('silver') ||
            lower.contains('copper')) {
          return 'assets/images/dungeon/items/icon_armor_shield.png';
        }
        return 'assets/images/dungeon/items/icon_armor_plate.png';
      case DungeonItemSlot.ring:
        if (lower.contains('amulet') ||
            lower.contains('pendant') ||
            lower.contains('talisman')) {
          return 'assets/images/dungeon/items/icon_amulet.png';
        }
        return 'assets/images/dungeon/items/icon_ring.png';
      case DungeonItemSlot.consumable:
        final kind = consumableEffect?.kind ?? '';
        if (kind == 'heal_hp') {
          return 'assets/images/dungeon/items/icon_potion_hp.png';
        }
        if (kind == 'heal_mana') {
          return 'assets/images/dungeon/items/icon_potion_mana.png';
        }
        if (kind == 'cure_status' || kind == 'buff_attack') {
          return 'assets/images/dungeon/items/icon_potion_antidote.png';
        }
        return 'assets/images/dungeon/items/icon_scroll.png';
    }
  }

  factory DungeonItem.fromJson(Map<String, dynamic> json) {
    final slot = DungeonItemSlot.fromKey(json['slot'] as String? ?? 'consumable');
    return DungeonItem(
      id: json['id'] as String,
      name: json['name'] as String,
      slot: slot,
      material: json['material'] as String? ?? 'Comum',
      rarity: ItemRarity.fromKey(json['rarity'] as String? ?? 'common'),
      price: (json['price'] as num?)?.toInt() ?? 40,
      description: json['description'] as String? ?? '',
      bonuses: ItemBonuses.fromJson(json['bonuses'] as Map<String, dynamic>?),
      consumableEffect: json['consumableEffect'] != null
          ? ConsumableEffect.fromJson(
              json['consumableEffect'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

/// Coordenada inteira no grid da masmorra.
class GridPos {
  const GridPos(this.x, this.y);

  final int x;
  final int y;

  int manhattanTo(GridPos other) => (x - other.x).abs() + (y - other.y).abs();

  int chebyshevTo(GridPos other) {
    final dx = (x - other.x).abs();
    final dy = (y - other.y).abs();
    return dx > dy ? dx : dy;
  }

  @override
  bool operator ==(Object other) =>
      other is GridPos && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => '($x,$y)';
}

/// Sala retangular gerada no andar.
class DungeonRoom {
  const DungeonRoom({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });

  final int x;
  final int y;
  final int w;
  final int h;

  int get centerX => x + w ~/ 2;
  int get centerY => y + h ~/ 2;
  GridPos get center => GridPos(centerX, centerY);

  bool intersects(DungeonRoom other, {int padding = 1}) {
    return x - padding < other.x + other.w &&
        x + w + padding > other.x &&
        y - padding < other.y + other.h &&
        y + h + padding > other.y;
  }
}

/// Instância viva de um monstro no andar.
class DungeonEnemy {
  DungeonEnemy({
    required this.uid,
    required this.template,
    required this.x,
    required this.y,
    required this.scaledStats,
    required this.maxHp,
    required this.hp,
    required this.attackPower,
    required this.magicPower,
    required this.defense,
    required this.dodgeChance,
    required this.critChance,
    this.isAlerted = false,
    this.stunTurns = 0,
    this.slowTurns = 0,
    this.poisonTurns = 0,
  });

  final int uid;
  final MonsterTemplate template;
  int x;
  int y;
  final Map<RpgAttribute, int> scaledStats;
  final int maxHp;
  int hp;
  final int attackPower;
  final int magicPower;
  final int defense;
  final double dodgeChance;
  final double critChance;
  bool isAlerted;
  int stunTurns;
  int slowTurns;
  int poisonTurns;

  bool get isAlive => hp > 0;
  bool get isBoss => template.isBoss;
  GridPos get pos => GridPos(x, y);
}

/// Baú encontrado dentro de uma sala da masmorra.
class DungeonChest {
  DungeonChest({
    required this.x,
    required this.y,
    required this.rarity,
    this.isOpened = false,
  });

  final int x;
  final int y;
  final ItemRarity rarity;
  bool isOpened;
}

/// Armadilha oculta ou revelada no piso.
class DungeonTrap {
  DungeonTrap({
    required this.x,
    required this.y,
    required this.damage,
    this.isRevealed = false,
    this.isTriggered = false,
  });

  final int x;
  final int y;
  final int damage;
  bool isRevealed;
  bool isTriggered;
}

/// Estado completo de um andar gerado proceduralmente.
class DungeonFloorMap {
  DungeonFloorMap({
    required this.biome,
    required this.seed,
    required this.floorSeed,
    required this.floorNumber,
    required this.maxFloors,
    required this.width,
    required this.height,
    required this.tiles,
    required this.baseFloorTile,
    required this.rooms,
    required this.startPos,
    required this.stairsPos,
    required this.enemies,
    required this.chests,
    required this.traps,
  })  : explored = List.generate(height, (_) => List.filled(width, false)),
        visible = List.generate(height, (_) => List.filled(width, false));

  final DungeonBiome biome;
  final int seed;
  final int floorSeed;
  final int floorNumber;
  final int maxFloors;
  final int width;
  final int height;
  final List<List<DungeonTileType>> tiles;
  final DungeonTileType baseFloorTile;
  final List<DungeonRoom> rooms;
  final GridPos startPos;
  final GridPos stairsPos;
  final List<DungeonEnemy> enemies;
  final List<DungeonChest> chests;
  final List<DungeonTrap> traps;
  final List<List<bool>> explored;
  final List<List<bool>> visible;

  bool get isBossFloor => floorNumber >= maxFloors;

  bool get isBossDefeated {
    if (!isBossFloor) return true;
    return !enemies.any((e) => e.isBoss && e.isAlive);
  }

  bool inBounds(int x, int y) => x >= 0 && y >= 0 && x < width && y < height;

  DungeonTileType tileAt(int x, int y) {
    if (!inBounds(x, y)) return DungeonTileType.voidWall;
    return tiles[y][x];
  }

  DungeonEnemy? enemyAt(int x, int y) {
    for (final e in enemies) {
      if (e.isAlive && e.x == x && e.y == y) return e;
    }
    return null;
  }

  DungeonChest? chestAt(int x, int y) {
    for (final c in chests) {
      if (!c.isOpened && c.x == x && c.y == y) return c;
    }
    return null;
  }

  DungeonTrap? trapAt(int x, int y) {
    for (final t in traps) {
      if (!t.isTriggered && t.x == x && t.y == y) return t;
    }
    return null;
  }

  /// Atualiza a névoa de guerra ao redor do herói e revela armadilhas próximas com SAB.
  void updateVisibility(int heroX, int heroY, int radius, int wisdomLevel) {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        visible[y][x] = false;
      }
    }

    for (var dy = -radius; dy <= radius; dy++) {
      for (var dx = -radius; dx <= radius; dx++) {
        final tx = heroX + dx;
        final ty = heroY + dy;
        if (!inBounds(tx, ty)) continue;
        if (dx * dx + dy * dy > radius * radius + 1) continue;
        if (_hasLineOfSight(heroX, heroY, tx, ty)) {
          visible[ty][tx] = true;
          explored[ty][tx] = true;
        }
      }
    }

    // Sabedoria revela armadilhas a até 2 tiles de distância automaticamente
    final detectRange = wisdomLevel >= 6 ? 2 : 1;
    for (final trap in traps) {
      if (trap.isRevealed || trap.isTriggered) continue;
      final dist = (trap.x - heroX).abs() + (trap.y - heroY).abs();
      if (dist <= detectRange && visible[trap.y][trap.x]) {
        trap.isRevealed = true;
      }
    }

    // Acorda inimigos que entram na visão do herói
    for (final enemy in enemies) {
      if (enemy.isAlive && visible[enemy.y][enemy.x]) {
        enemy.isAlerted = true;
      }
    }
  }

  /// Revela o andar inteiro (Pergaminho de Cartografia).
  void revealAll() {
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (tiles[y][x] != DungeonTileType.voidWall) {
          explored[y][x] = true;
        }
      }
    }
    for (final trap in traps) {
      trap.isRevealed = true;
    }
  }

  bool _hasLineOfSight(int x0, int y0, int x1, int y1) {
    var x = x0;
    var y = y0;
    final dx = (x1 - x0).abs();
    final dy = (y1 - y0).abs();
    final sx = x0 < x1 ? 1 : -1;
    final sy = y0 < y1 ? 1 : -1;
    var err = dx - dy;

    while (true) {
      if (x == x1 && y == y1) return true;
      if (!(x == x0 && y == y0) && tiles[y][x].blocksSight) {
        return false;
      }
      final e2 = 2 * err;
      if (e2 > -dy) {
        err -= dy;
        x += sx;
      }
      if (e2 < dx) {
        err += dx;
        y += sy;
      }
    }
  }
}

