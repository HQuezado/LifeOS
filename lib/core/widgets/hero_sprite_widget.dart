import 'package:material_ui/material_ui.dart';

/// Exibe o sprite do herói a partir de um sprite sheet horizontal (2 frames:
/// Frame 0 = pose neutra, Frame 1 = pose *idle* animada com brilho/notas/bolhas)
/// com renderização pixel-perfect (`FilterQuality.none`) e fundo transparente.
///
/// Preparado para expandir facilmente para mais frames (ataque/vitória no RPG por turnos).
class HeroSpriteWidget extends StatefulWidget {
  const HeroSpriteWidget({
    super.key,
    required this.assetPath,
    this.size = 72,
    this.animate = true,
    this.frameCount = 2,
  });

  final String assetPath;
  final double size;
  final bool animate;
  final int frameCount;

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
              widget.assetPath,
              width: totalWidth,
              height: widget.size,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.none,
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
