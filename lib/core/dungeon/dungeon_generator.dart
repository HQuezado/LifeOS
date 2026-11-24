import 'dart:collection';
import 'dart:math';

import 'dungeon_catalog.dart';
import 'dungeon_combat.dart';
import 'dungeon_models.dart';

/// Gerador Procedural Determinístico (baseado em Seed) de andares 17x21.
class DungeonGenerator {
  const DungeonGenerator._();

  static const int defaultWidth = 17;
  static const int defaultHeight = 21;

  /// Deriva a seed determinística de um andar específico a partir da seed da expedição.
  static int seedForFloor(int baseSeed, int floorNumber) {
    return (baseSeed ^ (floorNumber * 0x9E3779B9)) & 0x7FFFFFFF;
  }

  static DungeonTileType _baseFloorForBiome(DungeonBiome biome) {
    switch (biome) {
      case DungeonBiome.forest:
        return DungeonTileType.floorGrass;
      case DungeonBiome.catacombs:
        return DungeonTileType.floorStone;
      case DungeonBiome.swamp:
        return DungeonTileType.floorDirt;
      case DungeonBiome.desert:
        return DungeonTileType.floorSand;
      case DungeonBiome.volcano:
        return DungeonTileType.floorStone;
    }
  }

  /// Gera um andar completo (salas, corredores, portas, hazards, monstros/Boss, baús e armadilhas).
  static DungeonFloorMap generateFloor({
    required DungeonBiome biome,
    required int seed,
    required int floorNumber,
    required int heroLevel,
    required DungeonCatalog catalog,
    int width = defaultWidth,
    int height = defaultHeight,
  }) {
    final floorSeed = seedForFloor(seed, floorNumber);
    final rng = Random(floorSeed);
    final baseFloor = _baseFloorForBiome(biome);
    final isBossFloor = floorNumber >= biome.maxFloors;

    final tiles = List.generate(
      height,
      (_) => List<DungeonTileType>.filled(width, DungeonTileType.voidWall),
    );

    // 1. Geração de salas retangulares sem sobreposição (5..8 salas)
    final rooms = <DungeonRoom>[];
    final targetRooms = isBossFloor ? 5 : (5 + rng.nextInt(4));

    for (var attempt = 0; attempt < 90 && rooms.length < targetRooms; attempt++) {
      final isFirstBossArena = isBossFloor && rooms.isEmpty;
      final rw = isFirstBossArena ? 7 : (3 + rng.nextInt(4)); // 3..6
      final rh = isFirstBossArena ? 6 : (3 + rng.nextInt(4)); // 3..6
      final rx = 1 + rng.nextInt(max(1, width - rw - 2));
      final ry = 1 + rng.nextInt(max(1, height - rh - 2));
      final candidate = DungeonRoom(x: rx, y: ry, w: rw, h: rh);

      final overlaps = rooms.any((r) => r.intersects(candidate, padding: 1));
      if (!overlaps) {
        rooms.add(candidate);
      }
    }

    // Fallback de segurança caso a seed gere menos de 2 salas
    if (rooms.length < 2) {
      rooms
        ..clear()
        ..add(const DungeonRoom(x: 2, y: 2, w: 5, h: 5))
        ..add(DungeonRoom(x: width - 7, y: height - 7, w: 5, h: 5));
    }

    // Se for andar do Boss, coloca a sala maior por último para ser a Arena do Boss
    if (isBossFloor && rooms.length >= 2) {
      rooms.sort((a, b) => (a.w * a.h).compareTo(b.w * b.h));
    }

    // Escava salas com o piso base do bioma
    for (final room in rooms) {
      for (var y = room.y; y < room.y + room.h; y++) {
        for (var x = room.x; x < room.x + room.w; x++) {
          tiles[y][x] = baseFloor;
        }
      }
    }

    // 2. Conecta salas sequencialmente com corredores em "L"
    final corridorFloor = biome == DungeonBiome.forest
        ? DungeonTileType.floorDirt
        : baseFloor;
    for (var i = 1; i < rooms.length; i++) {
      final prev = rooms[i - 1].center;
      final curr = rooms[i].center;
      if (rng.nextBool()) {
        _carveHorizontal(tiles, prev.x, curr.x, prev.y, corridorFloor);
        _carveVertical(tiles, prev.y, curr.y, curr.x, corridorFloor);
      } else {
        _carveVertical(tiles, prev.y, curr.y, prev.x, corridorFloor);
        _carveHorizontal(tiles, prev.x, curr.x, curr.y, corridorFloor);
      }
    }

    // 3. Constrói paredes de tijolo ao redor de todo piso escavado
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (tiles[y][x] != DungeonTileType.voidWall) continue;
        if (_hasAdjacentFloor(tiles, x, y, width, height)) {
          tiles[y][x] = DungeonTileType.wallBrick;
        }
      }
    }

    // 4. Define posição inicial do Herói (Sala 0) e Escada / Arena do Boss (sala mais distante)
    final startRoom = rooms.first;
    final startPos = startRoom.center;

    DungeonRoom exitRoom = rooms.last;
    if (!isBossFloor) {
      var bestDist = -1;
      for (var i = 1; i < rooms.length; i++) {
        final d = startPos.manhattanTo(rooms[i].center);
        if (d > bestDist) {
          bestDist = d;
          exitRoom = rooms[i];
        }
      }
    }
    final stairsPos = exitRoom.center;
    tiles[stairsPos.y][stairsPos.x] = DungeonTileType.stairsDown;

    // 5. Terreno temático, pilares, hazards (água/pântano/lava) e portas
    _decorateBiomeTerrain(
      tiles: tiles,
      rooms: rooms,
      biome: biome,
      rng: rng,
      startPos: startPos,
      stairsPos: stairsPos,
      width: width,
      height: height,
    );

    // 6. Garante acessibilidade 100% (BFS) da entrada até todas as salas e escada
    _ensureFullConnectivity(
      tiles: tiles,
      rooms: rooms,
      startPos: startPos,
      stairsPos: stairsPos,
      fallbackFloor: baseFloor,
      width: width,
      height: height,
    );

    // 7. Spawna monstros / Boss, baús e armadilhas
    final occupied = <GridPos>{startPos, stairsPos};
    final enemies = <DungeonEnemy>[];
    var nextUid = 1;

    if (isBossFloor) {
      // Boss Final no centro/próximo à escada da Arena
      final bossTemplate = catalog.bossForBiome(biome);
      final bossSpot = _findFreeTileInRoom(
            exitRoom,
            tiles,
            occupied,
            preferNear: stairsPos,
          ) ??
          GridPos(
            (stairsPos.x - 1).clamp(1, width - 2),
            stairsPos.y,
          );
      occupied.add(bossSpot);
      enemies.add(
        DungeonCombatEngine.instantiateEnemy(
          uid: nextUid++,
          template: bossTemplate,
          x: bossSpot.x,
          y: bossSpot.y,
          heroLevel: heroLevel,
          floorNumber: floorNumber,
        ),
      );
    }

    // Monstros comuns distribuídos nas salas intermediárias (3 a 6 por andar)
    final mobPool = catalog.monstersForBiomeAndFloor(biome, floorNumber);
    final mobCount = isBossFloor ? 3 : (3 + rng.nextInt(4));
    final nonStartRooms = rooms.where((r) => r != startRoom).toList();

    for (var i = 0; i < mobCount && mobPool.isNotEmpty && nonStartRooms.isNotEmpty; i++) {
      final room = nonStartRooms[rng.nextInt(nonStartRooms.length)];
      final spot = _findFreeTileInRoom(room, tiles, occupied, rng: rng);
      if (spot == null) continue;
      occupied.add(spot);
      final template = mobPool[rng.nextInt(mobPool.length)];
      enemies.add(
        DungeonCombatEngine.instantiateEnemy(
          uid: nextUid++,
          template: template,
          x: spot.x,
          y: spot.y,
          heroLevel: heroLevel,
          floorNumber: floorNumber,
        ),
      );
    }

    // Baús (1 a 2 por andar)
    final chests = <DungeonChest>[];
    final chestCount = isBossFloor ? 2 : (1 + rng.nextInt(2));
    for (var i = 0; i < chestCount && nonStartRooms.isNotEmpty; i++) {
      final room = nonStartRooms[rng.nextInt(nonStartRooms.length)];
      final spot = _findFreeTileInRoom(room, tiles, occupied, rng: rng);
      if (spot == null) continue;
      occupied.add(spot);
      final rarity = DungeonCombatEngine.rollDropRarity(
        rng,
        lootLuckBonus: 0.0,
        floorNumber: floorNumber,
        fromBoss: isBossFloor && i == 0,
      );
      chests.add(DungeonChest(x: spot.x, y: spot.y, rarity: rarity));
    }

    // Armadilhas (2 a 4 por andar)
    final traps = <DungeonTrap>[];
    final trapCount = 2 + rng.nextInt(3);
    for (var i = 0; i < trapCount && nonStartRooms.isNotEmpty; i++) {
      final room = nonStartRooms[rng.nextInt(nonStartRooms.length)];
      final spot = _findFreeTileInRoom(room, tiles, occupied, rng: rng);
      if (spot == null) continue;
      occupied.add(spot);
      final dmg = 6 + (heroLevel * 2) + (floorNumber * 3);
      traps.add(DungeonTrap(x: spot.x, y: spot.y, damage: dmg));
    }

    return DungeonFloorMap(
      biome: biome,
      seed: seed,
      floorSeed: floorSeed,
      floorNumber: floorNumber,
      maxFloors: biome.maxFloors,
      width: width,
      height: height,
      tiles: tiles,
      baseFloorTile: baseFloor,
      rooms: rooms,
      startPos: startPos,
      stairsPos: stairsPos,
      enemies: enemies,
      chests: chests,
      traps: traps,
    );
  }

  static void _carveHorizontal(
    List<List<DungeonTileType>> tiles,
    int x1,
    int x2,
    int y,
    DungeonTileType floorTile,
  ) {
    final start = min(x1, x2);
    final end = max(x1, x2);
    for (var x = start; x <= end; x++) {
      if (tiles[y][x] == DungeonTileType.voidWall) {
        tiles[y][x] = floorTile;
      }
    }
  }

  static void _carveVertical(
    List<List<DungeonTileType>> tiles,
    int y1,
    int y2,
    int x,
    DungeonTileType floorTile,
  ) {
    final start = min(y1, y2);
    final end = max(y1, y2);
    for (var y = start; y <= end; y++) {
      if (tiles[y][x] == DungeonTileType.voidWall) {
        tiles[y][x] = floorTile;
      }
    }
  }

  static bool _hasAdjacentFloor(
    List<List<DungeonTileType>> tiles,
    int x,
    int y,
    int w,
    int h,
  ) {
    for (var dy = -1; dy <= 1; dy++) {
      for (var dx = -1; dx <= 1; dx++) {
        if (dx == 0 && dy == 0) continue;
        final nx = x + dx;
        final ny = y + dy;
        if (nx >= 0 && ny >= 0 && nx < w && ny < h) {
          final t = tiles[ny][nx];
          if (t != DungeonTileType.voidWall && t != DungeonTileType.wallBrick) {
            return true;
          }
        }
      }
    }
    return false;
  }

  static void _decorateBiomeTerrain({
    required List<List<DungeonTileType>> tiles,
    required List<DungeonRoom> rooms,
    required DungeonBiome biome,
    required Random rng,
    required GridPos startPos,
    required GridPos stairsPos,
    required int width,
    required int height,
  }) {
    // Portas em entradas estreitas de corredor (1 tile entre duas paredes opostas)
    for (var y = 1; y < height - 1; y++) {
      for (var x = 1; x < width - 1; x++) {
        if (!tiles[y][x].walkable ||
            (x == startPos.x && y == startPos.y) ||
            (x == stairsPos.x && y == stairsPos.y)) {
          continue;
        }
        final leftWall = tiles[y][x - 1] == DungeonTileType.wallBrick;
        final rightWall = tiles[y][x + 1] == DungeonTileType.wallBrick;
        final topWall = tiles[y - 1][x] == DungeonTileType.wallBrick;
        final bottomWall = tiles[y + 1][x] == DungeonTileType.wallBrick;

        final isVerticalDoorway =
            leftWall && rightWall && tiles[y - 1][x].walkable && tiles[y + 1][x].walkable;
        final isHorizontalDoorway =
            topWall && bottomWall && tiles[y][x - 1].walkable && tiles[y][x + 1].walkable;

        if ((isVerticalDoorway || isHorizontalDoorway) && rng.nextDouble() < 0.22) {
          // Evita portas coladas uma na outra
          final hasAdjDoor = tiles[y - 1][x] == DungeonTileType.door ||
              tiles[y + 1][x] == DungeonTileType.door ||
              tiles[y][x - 1] == DungeonTileType.door ||
              tiles[y][x + 1] == DungeonTileType.door;
          if (!hasAdjDoor) {
            tiles[y][x] = DungeonTileType.door;
          }
        }
      }
    }

    // Decora interior de cada sala com terreno temático + colunas + hazards
    for (var i = 0; i < rooms.length; i++) {
      final r = rooms[i];
      for (var y = r.y; y < r.y + r.h; y++) {
        for (var x = r.x; x < r.x + r.w; x++) {
          if ((x == startPos.x && y == startPos.y) ||
              (x == stairsPos.x && y == stairsPos.y)) {
            continue;
          }
          final isCorner = (x == r.x || x == r.x + r.w - 1) &&
              (y == r.y || y == r.y + r.h - 1);

          switch (biome) {
            case DungeonBiome.forest:
              if (isCorner && r.w >= 4 && r.h >= 4 && rng.nextDouble() < 0.30) {
                tiles[y][x] = DungeonTileType.water;
              } else if (rng.nextDouble() < 0.16) {
                tiles[y][x] = DungeonTileType.floorDirt;
              }
            case DungeonBiome.catacombs:
              if (isCorner && r.w >= 5 && r.h >= 5 && rng.nextDouble() < 0.45) {
                tiles[y][x] = DungeonTileType.pillar;
              }
            case DungeonBiome.swamp:
              if (isCorner && r.w >= 4 && r.h >= 4 && rng.nextDouble() < 0.25) {
                tiles[y][x] = DungeonTileType.water;
              } else if (rng.nextDouble() < 0.32) {
                tiles[y][x] = DungeonTileType.swamp;
              }
            case DungeonBiome.desert:
              if (isCorner && r.w >= 4 && r.h >= 4 && rng.nextDouble() < 0.28) {
                tiles[y][x] = rng.nextBool()
                    ? DungeonTileType.pillar
                    : DungeonTileType.water;
              }
            case DungeonBiome.volcano:
              if (isCorner && r.w >= 4 && r.h >= 4 && rng.nextDouble() < 0.25) {
                tiles[y][x] = DungeonTileType.pillar;
              } else if (rng.nextDouble() < 0.18) {
                tiles[y][x] = DungeonTileType.lava;
              }
          }
        }
      }
    }
  }

  /// Garante via BFS que a escada e o centro de todas as salas sejam alcançáveis a partir de `startPos`.
  static void _ensureFullConnectivity({
    required List<List<DungeonTileType>> tiles,
    required List<DungeonRoom> rooms,
    required GridPos startPos,
    required GridPos stairsPos,
    required DungeonTileType fallbackFloor,
    required int width,
    required int height,
  }) {
    Set<GridPos> reachable() {
      final visited = <GridPos>{startPos};
      final q = Queue<GridPos>()..add(startPos);
      const dirs = [
        GridPos(1, 0),
        GridPos(-1, 0),
        GridPos(0, 1),
        GridPos(0, -1),
      ];
      while (q.isNotEmpty) {
        final cur = q.removeFirst();
        for (final d in dirs) {
          final nx = cur.x + d.x;
          final ny = cur.y + d.y;
          if (nx < 0 || ny < 0 || nx >= width || ny >= height) continue;
          final next = GridPos(nx, ny);
          if (visited.contains(next)) continue;
          if (tiles[ny][nx].walkable) {
            visited.add(next);
            q.add(next);
          }
        }
      }
      return visited;
    }

    var reach = reachable();
    if (!reach.contains(stairsPos)) {
      _carveWalkablePath(tiles, startPos, stairsPos, fallbackFloor);
      tiles[stairsPos.y][stairsPos.x] = DungeonTileType.stairsDown;
      reach = reachable();
    }

    for (final room in rooms) {
      if (!reach.contains(room.center)) {
        _carveWalkablePath(tiles, startPos, room.center, fallbackFloor);
        reach = reachable();
      }
    }
  }

  static void _carveWalkablePath(
    List<List<DungeonTileType>> tiles,
    GridPos from,
    GridPos to,
    DungeonTileType floorTile,
  ) {
    var x = from.x;
    var y = from.y;
    while (x != to.x) {
      if (!tiles[y][x].walkable) tiles[y][x] = floorTile;
      x += x < to.x ? 1 : -1;
    }
    while (y != to.y) {
      if (!tiles[y][x].walkable) tiles[y][x] = floorTile;
      y += y < to.y ? 1 : -1;
    }
    if (!tiles[y][x].walkable) tiles[y][x] = floorTile;
  }

  static GridPos? _findFreeTileInRoom(
    DungeonRoom room,
    List<List<DungeonTileType>> tiles,
    Set<GridPos> occupied, {
    Random? rng,
    GridPos? preferNear,
  }) {
    final candidates = <GridPos>[];
    for (var y = room.y; y < room.y + room.h; y++) {
      for (var x = room.x; x < room.x + room.w; x++) {
        final pos = GridPos(x, y);
        if (occupied.contains(pos)) continue;
        final t = tiles[y][x];
        if (t.walkable && t != DungeonTileType.lava && t != DungeonTileType.door) {
          candidates.add(pos);
        }
      }
    }
    if (candidates.isEmpty) return null;
    if (preferNear != null) {
      candidates.sort(
        (a, b) => a.manhattanTo(preferNear).compareTo(b.manhattanTo(preferNear)),
      );
      return candidates.first;
    }
    if (rng != null) {
      return candidates[rng.nextInt(candidates.length)];
    }
    return candidates.first;
  }
}

