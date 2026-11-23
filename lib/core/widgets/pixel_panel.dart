import 'package:material_ui/material_ui.dart';

import '../theme/lifeos_theme.dart';

/// Painel com estética RPG 16-bit (bordas retas pixeladas e sombra sólida).
class PixelPanel extends StatelessWidget {
  const PixelPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.backgroundColor = LifeOsColors.surface,
    this.borderColor = LifeOsColors.border,
    this.borderWidth = 2,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: const [
          BoxShadow(
            color: Color(0x990D0E17),
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Botão 16-bit de alto contraste.
class PixelButton extends StatelessWidget {
  const PixelButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = LifeOsColors.gold,
    this.textColor = LifeOsColors.bgDark,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;
    return Material(
      color: disabled ? LifeOsColors.surfaceHighlight : backgroundColor,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: disabled ? LifeOsColors.border : LifeOsColors.textPrimary,
              width: 2,
            ),
            boxShadow: disabled
                ? null
                : const [
                    BoxShadow(
                      color: Color(0xAA0D0E17),
                      offset: Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: textColor,
                    ),
                  )
                : Text(
                    label,
                    style: LifeOsTheme.pixelTitle(
                      size: 11,
                      color: disabled ? LifeOsColors.textMuted : textColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// Barra de XP pixelada com borda retrô e alta legibilidade.
class PixelProgressBar extends StatelessWidget {
  const PixelProgressBar({
    super.key,
    required this.current,
    required this.max,
    required this.fillColor,
    this.height = 14,
  });

  final int current;
  final int max;
  final Color fillColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final ratio = max <= 0 ? 0.0 : (current / max).clamp(0.0, 1.0);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: LifeOsColors.bgDark,
        border: Border.all(color: LifeOsColors.border, width: 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: constraints.maxWidth * ratio,
                height: double.infinity,
                color: fillColor,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 3,
                child: Container(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

