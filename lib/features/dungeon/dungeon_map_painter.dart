import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/dungeon/dungeon_models.dart';

/// Cache de `ui.Image` dos tiles, paredes direcionais 45° e monstros para renderizar
/// o mapa da masmorra direto na GPU via `CustomPainter` a 60 FPS com `FilterQuality.none`.
class DungeonTileAtlas {
  DungeonTileAtlas._(this._images);

  final Map<String, ui.Image> _images;

  ui.Image? operator [](String assetPath) => _images[assetPath];

  static const List<String> _coreAssets = [
    'assets/images/dungeon/tiles/floor_stone.png',
    'assets/images/dungeon/tiles/floor_grass.png',
    'assets/images/dungeon/tiles/floor_dirt.png',
    'assets/images/dungeon/tiles/floor_sand.png',
    'assets/images/dungeon/tiles/tile_water.png',
    'assets/images/dungeon/tiles/tile_swamp.png',
    'assets/images/dungeon/tiles/tile_lava.png',
    'assets/images/dungeon/tiles/stairs_down.png',
    'assets/images/dungeon/tiles/wall_brick.png',
    'assets/images/dungeon/tiles/wall_pillar.png',
    'assets/images/dungeon/tiles/door_closed.png',
    'assets/images/dungeon/tiles/prop_chest.png',
    'assets/images/dungeon/tiles/prop_trap.png',
    // Auto-tiles direcionais e cantos 45°
    'assets/images/dungeon/tiles/wall_n.png',
    'assets/images/dungeon/tiles/wall_s.png',
    'assets/images/dungeon/tiles/wall_e.png',
    'assets/images/dungeon/tiles/wall_w.png',
    'assets/images/dungeon/tiles/wall_top.png',
    'assets/images/dungeon/tiles/wall_corner_nw.png',
    'assets/images/dungeon/tiles/wall_corner_ne.png',
    'assets/images/dungeon/tiles/wall_corner_sw.png',
    'assets/images/dungeon/tiles/wall_corner_se.png',
    'assets/images/dungeon/tiles/wall_outer_nw.png',
    'assets/images/dungeon/tiles/wall_outer_ne.png',
    'assets/images/dungeon/tiles/wall_outer_sw.png',
    'assets/images/dungeon/tiles/wall_outer_se.png',
  ];

  static Future<DungeonTileAtlas> load({
    Iterable<String> extraAssets = const [],
  }) async {
    final allPaths = {..._coreAssets, ...extraAssets};
    final result = <String, ui.Image>{};

    await Future.wait(
      allPaths.map((path) async {
        try {
          final data = await rootBundle.load(path);
          final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
          final frame = await codec.getNextFrame();
          result[path] = frame.image;
        } catch (_) {}
      }),
    );

    return DungeonTileAtlas._(result);
  }

  /// Garante que sprites extras (ex.: novos monstros em outro andar) estejam carregados.
  Future<void> ensureAssets(Iterable<String> paths) async {
    final missing = paths.where((p) => !_images.containsKey(p)).toSet();
    if (missing.isEmpty) return;
    await Future.wait(
      missing.map((path) async {
        try {
          final data = await rootBundle.load(path);
          final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
          final frame = await codec.getNextFrame();
          _images[path] = frame.image;
        } catch (_) {}
      }),
    );
  }
}

/// Renderizador 16-bit de alta performance para a Masmorra Procedural:
/// - **Auto-tiling de paredes 45°** estilo Top-Down RPG (N, S, E, W, 4 cantos côncavos, 4 quinas externas e topo).
/// - **Mesclagem orgânica pixelada** entre terrenos (grama ↔ terra ↔ água ↔ pântano ↔ pedra ↔ lava).
/// - **Sombras de ambiente (Ambient Occlusion)** projetadas pelas paredes nos pisos.
/// - **Névoa de Guerra** suave e sprites dos monstros + barras de vida.
class DungeonMapPainter extends CustomPainter {
  DungeonMapPainter({
    required this.floor,
    required this.atlas,
    required this.heroX,
    required this.heroY,
    required this.tileSize,
    required this.repaintVersion,
  });

  final DungeonFloorMap floor;
  final DungeonTileAtlas atlas;
  final int heroX;
  final int heroY;
  final double tileSize;
  final int repaintVersion;

  static const _pixelPaint = FilterQuality.none;

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF100B0A);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final colsVisible = (size.width / tileSize).ceil() + 3;
    final rowsVisible = (size.height / tileSize).ceil() + 3;
    final halfCols = colsVisible ~/ 2;
    final halfRows = rowsVisible ~/ 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final imgPaint = Paint()..filterQuality = _pixelPaint;
    final wallPaint = _wallBiomePaint(floor.biome);
    final fogPaint = Paint()..color = const Color(0x9C0E0A09);

    for (var y = heroY - halfRows; y <= heroY + halfRows; y++) {
      for (var x = heroX - halfCols; x <= heroX + halfCols; x++) {
        if (!floor.inBounds(x, y)) continue;
        if (!floor.explored[y][x]) continue;

        final tile = floor.tileAt(x, y);
        if (tile == DungeonTileType.voidWall) continue;

        final left = (centerX + (x - heroX) * tileSize - tileSize / 2).floorToDouble();
        final top = (centerY + (y - heroY) * tileSize - tileSize / 2).floorToDouble();
        // +0.5 evita micro-linhas de subpixel entre tiles vizinhos
        final dst = Rect.fromLTWH(left, top, tileSize + 0.5, tileSize + 0.5);

        if (tile == DungeonTileType.wallBrick) {
          final wallPath = _selectWallAutoTile(x, y);
          final wallImg = atlas[wallPath] ?? atlas['assets/images/dungeon/tiles/wall_brick.png'];
          if (wallImg != null) {
            _drawImg(canvas, wallImg, dst, wallPaint);
          }
        } else {
          // 1. Desenha piso base (ou o próprio terreno)
          final baseType = tile.overlayOnFloor ? floor.baseFloorTile : tile;
          final baseImg = baseType.asset != null ? atlas[baseType.asset!] : null;
          if (baseImg != null) {
            _drawImg(canvas, baseImg, dst, imgPaint);
          }

          // 2. Mesclagem orgânica pixelada com terrenos vizinhos de maior prioridade!
          _drawOrganicTerrainBlending(canvas, x, y, baseType, dst, imgPaint);

          // 3. Sombra suave projetada pelas paredes adjacentes (Ambient Occlusion)
          _drawWallShadows(canvas, x, y, dst);

          // 4. Overlays (escada, pilar, porta com orientação automática)
          if (tile.overlayOnFloor && tile.asset != null) {
            final ovImg = atlas[tile.asset!];
            if (ovImg != null) {
              if (tile == DungeonTileType.door && _isHorizontalCorridorDoor(x, y)) {
                canvas.save();
                canvas.translate(dst.center.dx, dst.center.dy);
                canvas.rotate(pi / 2);
                final rotDst = Rect.fromCenter(
                  center: Offset.zero,
                  width: dst.width,
                  height: dst.height,
                );
                _drawImg(canvas, ovImg, rotDst, imgPaint);
                canvas.restore();
              } else {
                _drawImg(canvas, ovImg, dst, imgPaint);
              }
            }
          }

          // 5. Armadilha revelada
          final trap = floor.trapAt(x, y);
          if (trap != null && trap.isRevealed) {
            final trapImg = atlas['assets/images/dungeon/tiles/prop_trap.png'];
            if (trapImg != null) _drawImg(canvas, trapImg, dst, imgPaint);
          }

          // 6. Baú
          final chest = floor.chestAt(x, y);
          if (chest != null) {
            final chestImg = atlas['assets/images/dungeon/tiles/prop_chest.png'];
            if (chestImg != null) _drawImg(canvas, chestImg, dst, imgPaint);
          }
        }

        final isVisible = floor.visible[y][x];
        if (!isVisible) {
          canvas.drawRect(dst, fogPaint);
          continue;
        }

        // 7. Monstro visível + barra de vida
        final enemy = floor.enemyAt(x, y);
        if (enemy != null) {
          _drawEnemy(canvas, enemy, dst, imgPaint);
        }
      }
    }
  }

  /// Tintura sutil das paredes para combinar com a atmosfera de cada bioma.
  Paint _wallBiomePaint(DungeonBiome biome) {
    final p = Paint()..filterQuality = _pixelPaint;
    switch (biome) {
      case DungeonBiome.forest:
        // Pedra terrosa levemente musgosa
        p.colorFilter = const ColorFilter.mode(Color(0xFFE3EAD2), BlendMode.modulate);
      case DungeonBiome.catacombs:
        // Pedra fria acinzentada de cripta
        p.colorFilter = const ColorFilter.mode(Color(0xFFC8CEDC), BlendMode.modulate);
      case DungeonBiome.swamp:
        // Pedra úmida esverdeada
        p.colorFilter = const ColorFilter.mode(Color(0xFFBBD1A5), BlendMode.modulate);
      case DungeonBiome.desert:
        // Arenito dourado quente
        p.colorFilter = const ColorFilter.mode(Color(0xFFFFE5AF), BlendMode.modulate);
      case DungeonBiome.volcano:
        // Basalto vulcânico escuro com brasa
        p.colorFilter = const ColorFilter.mode(Color(0xFFB3877F), BlendMode.modulate);
    }
    return p;
  }

  bool _isOpenSpace(int x, int y) {
    if (!floor.inBounds(x, y)) return false;
    final t = floor.tileAt(x, y);
    return t != DungeonTileType.voidWall && t != DungeonTileType.wallBrick;
  }

  /// Seleciona o tile de parede direcional / canto 45° correto olhando os 8 vizinhos!
  String _selectWallAutoTile(int x, int y) {
    final openN = _isOpenSpace(x, y - 1);
    final openS = _isOpenSpace(x, y + 1);
    final openW = _isOpenSpace(x - 1, y);
    final openE = _isOpenSpace(x + 1, y);

    final openNW = _isOpenSpace(x - 1, y - 1);
    final openNE = _isOpenSpace(x + 1, y - 1);
    final openSW = _isOpenSpace(x - 1, y + 1);
    final openSE = _isOpenSpace(x + 1, y + 1);

    // 1. Quinas externas (2 lados adjacentes voltados para o piso, ex.: entrada de corredor)
    if (openN && openW && !openS && !openE) {
      return 'assets/images/dungeon/tiles/wall_outer_nw.png';
    }
    if (openN && openE && !openS && !openW) {
      return 'assets/images/dungeon/tiles/wall_outer_ne.png';
    }
    if (openS && openW && !openN && !openE) {
      return 'assets/images/dungeon/tiles/wall_outer_sw.png';
    }
    if (openS && openE && !openN && !openW) {
      return 'assets/images/dungeon/tiles/wall_outer_se.png';
    }

    // 2. Paredes retas (Norte, Sul, Oeste, Leste)
    if (openS && !openN) return 'assets/images/dungeon/tiles/wall_n.png';
    if (openN && !openS) return 'assets/images/dungeon/tiles/wall_s.png';
    if (openE && !openW) return 'assets/images/dungeon/tiles/wall_w.png';
    if (openW && !openE) return 'assets/images/dungeon/tiles/wall_e.png';

    // Se há piso em lados opostos (parede fina divisória entre duas salas/corredores)
    if (openS && openN) return 'assets/images/dungeon/tiles/wall_n.png';
    if (openE && openW) return 'assets/images/dungeon/tiles/wall_top.png';

    // 3. Cantos côncavos internos 45° da sala (exatamente como o Zelda Top-Down Tileset!)
    if (openSE && !openNW) return 'assets/images/dungeon/tiles/wall_corner_nw.png';
    if (openSW && !openNE) return 'assets/images/dungeon/tiles/wall_corner_ne.png';
    if (openNE && !openSW) return 'assets/images/dungeon/tiles/wall_corner_sw.png';
    if (openNW && !openSE) return 'assets/images/dungeon/tiles/wall_corner_se.png';

    // 4. Miolo sólido de parede
    return 'assets/images/dungeon/tiles/wall_top.png';
  }

  bool _isHorizontalCorridorDoor(int x, int y) {
    final topWall = floor.tileAt(x, y - 1) == DungeonTileType.wallBrick;
    final bottomWall = floor.tileAt(x, y + 1) == DungeonTileType.wallBrick;
    return topWall && bottomWall;
  }

  /// Prioridade visual para mesclagem orgânica: quem tem prioridade MAIOR invade suavemente
  /// as bordas do terreno de prioridade MENOR (ex.: grama invade terra; terra/grama invadem água/pântano).
  int _terrainPriority(DungeonTileType t) {
    switch (t) {
      case DungeonTileType.floorGrass:
        return 5;
      case DungeonTileType.floorSand:
        return 4;
      case DungeonTileType.floorDirt:
        return 3;
      case DungeonTileType.floorStone:
        return 2;
      case DungeonTileType.swamp:
      case DungeonTileType.water:
      case DungeonTileType.lava:
        return 1;
      default:
        return 0;
    }
  }

  DungeonTileType _effectiveFloor(int x, int y) {
    if (!floor.inBounds(x, y)) return DungeonTileType.voidWall;
    final t = floor.tileAt(x, y);
    if (t.overlayOnFloor) return floor.baseFloorTile;
    return t;
  }

  /// Desenha transições orgânicas pixeladas (tufos de grama, margens de terra/pedra) sobre as bordas
  /// do tile atual sempre que um vizinho tem terreno de maior prioridade visual!
  void _drawOrganicTerrainBlending(
    Canvas canvas,
    int x,
    int y,
    DungeonTileType selfType,
    Rect dst,
    Paint imgPaint,
  ) {
    final selfPrio = _terrainPriority(selfType);
    if (selfPrio <= 0) return;

    final nType = _effectiveFloor(x, y - 1);
    final sType = _effectiveFloor(x, y + 1);
    final wType = _effectiveFloor(x - 1, y);
    final eType = _effectiveFloor(x + 1, y);

    final neighbors = <(int side, DungeonTileType type)>[
      (0, nType), // top
      (1, sType), // bottom
      (2, wType), // left
      (3, eType), // right
    ];

    // Ordena por prioridade crescente para camadas mais altas ficarem por cima
    neighbors.sort((a, b) => _terrainPriority(a.$2).compareTo(_terrainPriority(b.$2)));

    final edgeShade = Paint()
      ..color = const Color(0x38120B08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    for (final (side, nType) in neighbors) {
      if (_terrainPriority(nType) <= selfPrio) continue;
      final nAsset = nType.asset;
      if (nAsset == null) continue;
      final nImg = atlas[nAsset];
      if (nImg == null) continue;

      final clipPath = _buildPixelOrganicEdgePath(dst, side, x, y);
      canvas.save();
      canvas.clipPath(clipPath);
      _drawImg(canvas, nImg, dst, imgPaint);
      canvas.restore();
      canvas.drawPath(clipPath, edgeShade);
    }

    // Cantinhos diagonais suaves quando 2 lados adjacentes têm o mesmo terreno superior
    _drawCornerTuftIfNeeded(canvas, dst, nType, wType, selfPrio, 0, imgPaint);
    _drawCornerTuftIfNeeded(canvas, dst, nType, eType, selfPrio, 1, imgPaint);
    _drawCornerTuftIfNeeded(canvas, dst, sType, wType, selfPrio, 2, imgPaint);
    _drawCornerTuftIfNeeded(canvas, dst, sType, eType, selfPrio, 3, imgPaint);
  }

  /// Gera uma borda irregular em degraus pixelados (estilo 16-bit) determinística por `(x, y, side)`.
  Path _buildPixelOrganicEdgePath(Rect dst, int side, int x, int y) {
    const segments = 6;
    final path = Path();
    final hashBase = (x * 73856093) ^ (y * 19349663) ^ (side * 83492791);

    double depthFor(int i) {
      final h = ((hashBase ^ (i * 2654435761)) & 0xFFFF) / 0xFFFF;
      // Profundidade orgânica entre 14% e 28% do tile (em passos nítidos de pixel art)
      final raw = tileSize * (0.14 + h * 0.14);
      return (raw / 3.0).round() * 3.0;
    }

    if (side == 0) {
      // Top edge invadindo para baixo
      path.moveTo(dst.left, dst.top);
      path.lineTo(dst.right, dst.top);
      final segW = dst.width / segments;
      for (var i = segments - 1; i >= 0; i--) {
        final d = depthFor(i);
        path.lineTo(dst.left + (i + 1) * segW, dst.top + d);
        path.lineTo(dst.left + i * segW, dst.top + d);
      }
      path.close();
    } else if (side == 1) {
      // Bottom edge invadindo para cima
      path.moveTo(dst.left, dst.bottom);
      path.lineTo(dst.right, dst.bottom);
      final segW = dst.width / segments;
      for (var i = segments - 1; i >= 0; i--) {
        final d = depthFor(i);
        path.lineTo(dst.left + (i + 1) * segW, dst.bottom - d);
        path.lineTo(dst.left + i * segW, dst.bottom - d);
      }
      path.close();
    } else if (side == 2) {
      // Left edge invadindo para a direita
      path.moveTo(dst.left, dst.top);
      path.lineTo(dst.left, dst.bottom);
      final segH = dst.height / segments;
      for (var i = segments - 1; i >= 0; i--) {
        final d = depthFor(i);
        path.lineTo(dst.left + d, dst.top + (i + 1) * segH);
        path.lineTo(dst.left + d, dst.top + i * segH);
      }
      path.close();
    } else {
      // Right edge invadindo para a esquerda
      path.moveTo(dst.right, dst.top);
      path.lineTo(dst.right, dst.bottom);
      final segH = dst.height / segments;
      for (var i = segments - 1; i >= 0; i--) {
        final d = depthFor(i);
        path.lineTo(dst.right - d, dst.top + (i + 1) * segH);
        path.lineTo(dst.right - d, dst.top + i * segH);
      }
      path.close();
    }
    return path;
  }

  void _drawCornerTuftIfNeeded(
    Canvas canvas,
    Rect dst,
    DungeonTileType a,
    DungeonTileType b,
    int selfPrio,
    int cornerIdx, // 0=NW, 1=NE, 2=SW, 3=SE
    Paint imgPaint,
  ) {
    if (a != b || _terrainPriority(a) <= selfPrio || a.asset == null) return;
    final img = atlas[a.asset!];
    if (img == null) return;

    final r = tileSize * 0.34;
    final p = Path();
    switch (cornerIdx) {
      case 0: // NW
        p.moveTo(dst.left, dst.top);
        p.lineTo(dst.left + r, dst.top);
        p.lineTo(dst.left + r * 0.65, dst.top + r * 0.65);
        p.lineTo(dst.left, dst.top + r);
      case 1: // NE
        p.moveTo(dst.right, dst.top);
        p.lineTo(dst.right - r, dst.top);
        p.lineTo(dst.right - r * 0.65, dst.top + r * 0.65);
        p.lineTo(dst.right, dst.top + r);
      case 2: // SW
        p.moveTo(dst.left, dst.bottom);
        p.lineTo(dst.left + r, dst.bottom);
        p.lineTo(dst.left + r * 0.65, dst.bottom - r * 0.65);
        p.lineTo(dst.left, dst.bottom - r);
      case 3: // SE
        p.moveTo(dst.right, dst.bottom);
        p.lineTo(dst.right - r, dst.bottom);
        p.lineTo(dst.right - r * 0.65, dst.bottom - r * 0.65);
        p.lineTo(dst.right, dst.bottom - r);
    }
    p.close();
    canvas.save();
    canvas.clipPath(p);
    _drawImg(canvas, img, dst, imgPaint);
    canvas.restore();
  }

  /// Sombras sutis projetadas pelas paredes no chão para dar profundidade 3D estilo RPG 16-bit.
  void _drawWallShadows(Canvas canvas, int x, int y, Rect dst) {
    final wallN = floor.tileAt(x, y - 1) == DungeonTileType.wallBrick;
    final wallW = floor.tileAt(x - 1, y) == DungeonTileType.wallBrick;
    final wallE = floor.tileAt(x + 1, y) == DungeonTileType.wallBrick;
    final wallS = floor.tileAt(x, y + 1) == DungeonTileType.wallBrick;

    if (wallN) {
      final r = Rect.fromLTWH(dst.left, dst.top, dst.width, tileSize * 0.28);
      final p = Paint()
        ..shader = ui.Gradient.linear(
          r.topCenter,
          r.bottomCenter,
          [const Color(0x880B0706), const Color(0x000B0706)],
        );
      canvas.drawRect(r, p);
    }
    if (wallW) {
      final r = Rect.fromLTWH(dst.left, dst.top, tileSize * 0.18, dst.height);
      final p = Paint()
        ..shader = ui.Gradient.linear(
          r.centerLeft,
          r.centerRight,
          [const Color(0x660B0706), const Color(0x000B0706)],
        );
      canvas.drawRect(r, p);
    }
    if (wallE) {
      final r = Rect.fromLTWH(
        dst.right - tileSize * 0.18,
        dst.top,
        tileSize * 0.18,
        dst.height,
      );
      final p = Paint()
        ..shader = ui.Gradient.linear(
          r.centerRight,
          r.centerLeft,
          [const Color(0x660B0706), const Color(0x000B0706)],
        );
      canvas.drawRect(r, p);
    }
    if (wallS) {
      final r = Rect.fromLTWH(
        dst.left,
        dst.bottom - tileSize * 0.14,
        dst.width,
        tileSize * 0.14,
      );
      final p = Paint()
        ..shader = ui.Gradient.linear(
          r.bottomCenter,
          r.topCenter,
          [const Color(0x550B0706), const Color(0x000B0706)],
        );
      canvas.drawRect(r, p);
    }
  }

  void _drawEnemy(Canvas canvas, DungeonEnemy enemy, Rect dst, Paint imgPaint) {
    if (enemy.isBoss) {
      final aura = Paint()..color = const Color(0x33E4525A);
      final border = Paint()
        ..color = const Color(0xFFE4525A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6;
      canvas.drawRect(dst.deflate(1), aura);
      canvas.drawRect(dst.deflate(1), border);
    }

    // Sombra oval suave no pé do monstro
    final shadowRect = Rect.fromCenter(
      center: Offset(dst.center.dx, dst.bottom - 5),
      width: dst.width * 0.62,
      height: 7,
    );
    canvas.drawOval(shadowRect, Paint()..color = const Color(0x660A0605));

    final sprite = atlas[enemy.template.spriteAsset];
    if (sprite != null) {
      final pad = enemy.isBoss ? -1.5 : 2.5;
      _drawImg(canvas, sprite, dst.deflate(pad), imgPaint);
    }

    // Mini barra de HP acima do inimigo
    final ratio = enemy.maxHp > 0 ? (enemy.hp / enemy.maxHp).clamp(0.0, 1.0) : 0.0;
    final barBg = Rect.fromLTWH(dst.left + 4, dst.top + 1, dst.width - 8, 4.5);
    canvas.drawRect(barBg, Paint()..color = const Color(0xCC0E0A09));
    final barFill = Rect.fromLTWH(
      barBg.left,
      barBg.top,
      barBg.width * ratio,
      barBg.height,
    );
    canvas.drawRect(
      barFill,
      Paint()
        ..color = enemy.isBoss ? const Color(0xFFFFCD75) : const Color(0xFFE4525A),
    );
  }

  void _drawImg(Canvas canvas, ui.Image img, Rect dst, Paint paint) {
    final src = Rect.fromLTWH(0, 0, img.width.toDouble(), img.height.toDouble());
    canvas.drawImageRect(img, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant DungeonMapPainter oldDelegate) {
    return oldDelegate.repaintVersion != repaintVersion ||
        oldDelegate.heroX != heroX ||
        oldDelegate.heroY != heroY ||
        oldDelegate.floor != floor ||
        oldDelegate.atlas != atlas;
  }
}

