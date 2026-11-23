import 'package:material_ui/material_ui.dart';

/// Exibe o sprite do herói com renderização pixel-perfect (`FilterQuality.none`)
/// e animação *idle* estilo RPG 16-bit (respiração/flutuação em passos discretos).
///
/// Já preparado para futuramente suportar sprite sheets horizontais multi-frame
/// (idle, ataque e vitória para o modo RPG por turnos).
class HeroSpriteWidget extends StatefulWidget {
  const HeroSpriteWidget({
    super.key,
    required this.assetPath,
    this.size = 72,
    this.animate = true,
  });

  final String assetPath;
  final double size;
  final bool animate;

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
      duration: const Duration(milliseconds: 900),
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

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      return Image.asset(
        widget.assetPath,
        width: widget.size,
        height: widget.size,
        filterQuality: FilterQuality.none,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Animação idle em 4 passos discretos (estilo 16-bit retro).
        final step = (_controller.value * 4).floor() % 4;
        final offsetY = switch (step) {
          1 => -2.0,
          2 => -3.0,
          3 => -1.0,
          _ => 0.0,
        };
        final scaleY = (step == 1 || step == 2) ? 1.03 : 1.0;

        return Transform.translate(
          offset: Offset(0, offsetY),
          child: Transform.scale(
            scaleX: 1.0,
            scaleY: scaleY,
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        );
      },
      child: Image.asset(
        widget.assetPath,
        width: widget.size,
        height: widget.size,
        filterQuality: FilterQuality.none,
      ),
    );
  }
}

