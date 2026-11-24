import 'package:material_ui/material_ui.dart';

import '../rpg/rpg_models.dart';

/// Exibe o sprite do herói a partir de um sprite sheet horizontal (2 frames)
/// com suporte a personalização de cor da armadura/manto (`armorTint`).
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
    Widget img = Image.asset(
      widget.assetPath,
      width: totalWidth,
      height: widget.size,
      fit: BoxFit.fill,
      filterQuality: FilterQuality.none,
    );

    final tint = widget.armorTint.tintColor;
    if (tint != null) {
      img = ColorFiltered(
        colorFilter: ColorFilter.mode(
          tint.withValues(alpha: 0.34),
          BlendMode.srcATop,
        ),
        child: img,
      );
    }

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
            child: img,
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
        // Frame 0 nos passos 0 e 3; Frame 1 (efeito/brilho) nos passos 1 e 2.
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
