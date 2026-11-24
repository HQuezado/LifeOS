import 'package:material_ui/material_ui.dart';

import '../theme/lifeos_theme.dart';

/// Painel com moldura RPG 16-bit em 9-slice (`panel_frame.png`, 96x96)
/// preservando cantos dourados sem distorção e interior escuro legível (#262B44).
class PixelPanel extends StatelessWidget {
  const PixelPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.backgroundColor = LifeOsColors.surface,
    this.borderColor = LifeOsColors.border,
    this.borderWidth = 2,
    this.useFrame = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final bool useFrame;

  @override
  Widget build(BuildContext context) {
    if (!useFrame) {
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

    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ui/panel_frame.png'),
          centerSlice: Rect.fromLTWH(28, 28, 40, 40),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.none,
        ),
      ),
      child: child,
    );
  }
}

/// Botão RPG 16-bit usando moldura 9-slice (`button_gold.png` ou `button_slate.png`).
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
    final useGoldSprite = !disabled && backgroundColor == LifeOsColors.gold;
    final spriteAsset = useGoldSprite
        ? 'assets/images/ui/button_gold.png'
        : 'assets/images/ui/button_slate.png';

    final resolvedTextColor = disabled
        ? LifeOsColors.textMuted
        : (useGoldSprite ? LifeOsColors.bgDark : LifeOsColors.textPrimary);

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Opacity(
        opacity: disabled ? 0.6 : 1.0,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(spriteAsset),
              centerSlice: const Rect.fromLTWH(16, 12, 64, 16),
              fit: BoxFit.fill,
              filterQuality: FilterQuality.none,
            ),
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: resolvedTextColor,
                    ),
                  )
                : Text(
                    label,
                    textAlign: TextAlign.center,
                    style: LifeOsTheme.pixelTitle(
                      size: 10.5,
                      color: resolvedTextColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// Barra de XP pixelada com moldura metálica 9-slice (`xp_bar_frame.png`, 128x28).
class PixelProgressBar extends StatelessWidget {
  const PixelProgressBar({
    super.key,
    required this.current,
    required this.max,
    required this.fillColor,
    this.height = 22,
  });

  final int current;
  final int max;
  final Color fillColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final ratio = max <= 0 ? 0.0 : (current / max).clamp(0.0, 1.0);
    // Garante altura mínima >= 20px para que a moldura 9-slice (28px) nunca colapse.
    final effectiveHeight = height < 20 ? 20.0 : height;
    return SizedBox(
      height: effectiveHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Preenchimento colorido interno
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            child: Container(
              color: LifeOsColors.bgDark,
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
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          // Moldura metálica 9-slice por cima
          IgnorePointer(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ui/xp_bar_frame.png'),
                  centerSlice: Rect.fromLTWH(20, 8, 88, 12),
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper para ícones Pixel Art nítidos (`FilterQuality.none`).
class PixelIcon extends StatelessWidget {
  const PixelIcon(
    this.assetPath, {
    super.key,
    this.size = 24,
    this.opacity = 1.0,
  });

  final String assetPath;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final img = Image.asset(
      assetPath,
      width: size,
      height: size,
      filterQuality: FilterQuality.none,
    );
    if (opacity >= 1.0) return img;
    return Opacity(opacity: opacity, child: img);
  }
}
