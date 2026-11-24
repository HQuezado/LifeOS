import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

/// Paleta RPG 16-bit aconchegante em tons de madeira escura e pergaminho
/// (harmonizada com as molduras de madeira/ouro e os cenários da Casa Viva).
class LifeOsColors {
  const LifeOsColors._();

  static const Color bgDark = Color(0xFF1B1412);
  static const Color surface = Color(0xFF2A1F1B);
  static const Color surfaceHighlight = Color(0xFF3A2B24);
  static const Color border = Color(0xFF6E4E3A);
  static const Color borderLight = Color(0xFFA87F5C);

  static const Color gold = Color(0xFFFFCD75);
  static const Color goldDark = Color(0xFFD68C45);
  static const Color xpBar = Color(0xFF73EFF7);
  static const Color success = Color(0xFF56C271);
  static const Color danger = Color(0xFFE4525A);

  static const Color textPrimary = Color(0xFFF7EFE6);
  static const Color textSecondary = Color(0xFFCDBAA8);
  static const Color textMuted = Color(0xFF947E6B);
}

class LifeOsTheme {
  const LifeOsTheme._();

  static TextStyle pixelTitle({
    double size = 14,
    Color color = LifeOsColors.textPrimary,
  }) {
    return GoogleFonts.pressStart2p(
      fontSize: size,
      color: color,
      height: 1.4,
    );
  }

  static ThemeData build() {
    final baseText = GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: LifeOsColors.bgDark,
      colorScheme: const ColorScheme.dark(
        primary: LifeOsColors.gold,
        secondary: LifeOsColors.xpBar,
        surface: LifeOsColors.surface,
        error: LifeOsColors.danger,
        onPrimary: LifeOsColors.bgDark,
        onSecondary: LifeOsColors.bgDark,
        onSurface: LifeOsColors.textPrimary,
      ),
      textTheme: baseText.apply(
        bodyColor: LifeOsColors.textPrimary,
        displayColor: LifeOsColors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: LifeOsColors.bgDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: pixelTitle(size: 13, color: LifeOsColors.gold),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LifeOsColors.bgDark,
        hintStyle: const TextStyle(color: LifeOsColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: LifeOsColors.border, width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: LifeOsColors.gold, width: 2),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: LifeOsColors.surface,
        selectedColor: LifeOsColors.gold.withValues(alpha: 0.25),
        side: const BorderSide(color: LifeOsColors.border),
        labelStyle: const TextStyle(
          color: LifeOsColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: LifeOsColors.surface,
        indicatorColor: LifeOsColors.gold.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
            color: selected ? LifeOsColors.gold : LifeOsColors.textMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? LifeOsColors.gold : LifeOsColors.textMuted,
            size: 22,
          );
        }),
      ),
    );
  }
}
