import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import 'dungeon_models.dart';

/// Catálogo em memória do Bestiário (30 monstros) e Itens da Masmorra (40 equips + 15 consumíveis).
class DungeonCatalog {
  DungeonCatalog({
    required this.monsters,
    required this.equipment,
    required this.consumables,
  }) : _itemsById = {
          for (final item in [...equipment, ...consumables]) item.id: item,
        },
        _monstersById = {
          for (final m in monsters) m.id: m,
        };

  final List<MonsterTemplate> monsters;
  final List<DungeonItem> equipment;
  final List<DungeonItem> consumables;
  final Map<String, DungeonItem> _itemsById;
  final Map<String, MonsterTemplate> _monstersById;

  List<DungeonItem> get allItems => [...equipment, ...consumables];

  DungeonItem? itemById(String id) => _itemsById[id];
  MonsterTemplate? monsterById(String id) => _monstersById[id];

  /// Retorna os monstros comuns de um bioma apropriados para o andar atual.
  List<MonsterTemplate> monstersForBiomeAndFloor(
    DungeonBiome biome,
    int floorNumber,
  ) {
    final biomeMobs =
        monsters.where((m) => m.biome == biome && !m.isBoss).toList();
    if (biomeMobs.isEmpty) return const [];

    // Normaliza o minFloor relativo ao primeiro mob do bioma para que todo bioma
    // tenha progressão gradual desde o andar 1 até o penúltimo andar!
    final minBaseFloor = biomeMobs
        .map((m) => m.minFloor)
        .reduce((a, b) => a < b ? a : b);
    final eligible = biomeMobs
        .where((m) => (m.minFloor - minBaseFloor + 1) <= floorNumber + 1)
        .toList();
    return eligible.isNotEmpty ? eligible : [biomeMobs.first];
  }

  /// Retorna o Boss oficial de um bioma.
  MonsterTemplate bossForBiome(DungeonBiome biome) {
    return monsters.firstWhere(
      (m) => m.biome == biome && m.isBoss,
      orElse: () => monsters.first,
    );
  }

  /// Sorteia um equipamento ou consumível de acordo com a raridade desejada.
  DungeonItem rollLootItem(
    Random rng, {
    required ItemRarity targetRarity,
    bool preferEquipment = true,
  }) {
    final pool = preferEquipment ? equipment : consumables;
    var matching = pool.where((i) => i.rarity == targetRarity).toList();
    if (matching.isEmpty) {
      matching = pool.where((i) => i.rarity.rank <= targetRarity.rank).toList();
    }
    if (matching.isEmpty) matching = pool;
    return matching[rng.nextInt(matching.length)];
  }

  static DungeonCatalog? _cached;

  /// Carrega do bundle de assets Flutter com cache em memória.
  static Future<DungeonCatalog> loadFromAssets() async {
    if (_cached != null) return _cached!;
    final bestiaryRaw = await rootBundle.loadString('assets/data/bestiary.json');
    final itemsRaw =
        await rootBundle.loadString('assets/data/dungeon_items.json');
    _cached = DungeonCatalog.fromRawJson(
      bestiaryJson: bestiaryRaw,
      itemsJson: itemsRaw,
    );
    return _cached!;
  }

  /// Parse direto de strings JSON (usado por `loadFromAssets` e testes unitários).
  factory DungeonCatalog.fromRawJson({
    required String bestiaryJson,
    required String itemsJson,
  }) {
    final bestiaryList = jsonDecode(bestiaryJson) as List<dynamic>;
    final monsters = bestiaryList
        .map((e) => MonsterTemplate.fromJson(e as Map<String, dynamic>))
        .toList();

    final itemsMap = jsonDecode(itemsJson) as Map<String, dynamic>;
    final equipmentList = (itemsMap['equipment'] as List<dynamic>? ?? const [])
        .map((e) => DungeonItem.fromJson(e as Map<String, dynamic>))
        .toList();
    final consumablesList =
        (itemsMap['consumables'] as List<dynamic>? ?? const [])
            .map((e) => DungeonItem.fromJson(e as Map<String, dynamic>))
            .toList();

    return DungeonCatalog(
      monsters: monsters,
      equipment: equipmentList,
      consumables: consumablesList,
    );
  }
}

