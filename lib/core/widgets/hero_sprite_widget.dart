import 'package:material_ui/material_ui.dart';

import '../rpg/rpg_models.dart';

/// Exibe o sprite do herói a partir do sprite sheet horizontal de 2 frames.
/// Quando `armorTint` não é `original`, carrega a variante recolorida pixel-a-pixel
/// apenas na armadura/manto/roupa (`{classe}_{cor}.png`), mantendo pele, rosto e
/// contornos 100% preservados.
class HeroSpriteWidget extends StatefulWidget {
  const HeroSpriteWidget({
    super.key,
    required this.assetPath,
    this.size = 72,
    this.animate = true,
    this.frameCount = 2,
    this.armorTint = ArmorTint.original,
  });

  final String assetPath;
  final double size;
  final bool animate;
  final int frameCount;
  final ArmorTint armorTint;

  /// Resolve o caminho do asset conforme a tintura escolhida.
  static String resolveAssetPath(String basePath, ArmorTint tint) {
    if (tint == ArmorTint.original || !basePath.endsWith('.png')) {
      return basePath;
    }
    return basePath.replaceFirst('.png', '_${tint.key}.png');
  }

  @override
  State<HeroSpriteWidget> createState() => _HeroSpriteWidgetState();
}

class _HeroSpriteWidgetState extends State<HeroSpriteWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant HeroSpriteWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFrame(int frameIndex) {
    final totalWidth = widget.size * widget.frameCount;
    final resolvedPath = HeroSpriteWidget.resolveAssetPath(
      widget.assetPath,
      widget.armorTint,
    );

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topLeft,
          minWidth: totalWidth,
          maxWidth: totalWidth,
          minHeight: widget.size,
          maxHeight: widget.size,
          child: Transform.translate(
            offset: Offset(-frameIndex * widget.size, 0),
            child: Image.asset(
              resolvedPath,
              width: totalWidth,
              height: widget.size,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.none,
              errorBuilder: (_, _, _) => Image.asset(
                widget.assetPath,
                width: totalWidth,
                height: widget.size,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      return _buildFrame(0);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final step = (_controller.value * 4).floor() % 4;
        final frameIndex = (step == 1 || step == 2) ? 1 : 0;
        final offsetY = (step == 1 || step == 2) ? -1.5 : 0.0;

        return Transform.translate(
          offset: Offset(0, offsetY),
          child: _buildFrame(frameIndex % widget.frameCount),
        );
      },
    );
  }
}
