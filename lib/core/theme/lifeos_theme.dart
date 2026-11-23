import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta RPG 16-bit aconchegante (Stardew Valley / Chrono Trigger em modo escuro).
class LifeOsColors {
  const LifeOsColors._();

  static const Color bgDark = Color(0xFF1A1C2C);
  static const Color surface = Color(0xFF262B44);
  static const Color surfaceHighlight = Color(0xFF333C57);
  static const Color border = Color(0xFF566C86);
  static const Color borderLight = Color(0xFF94B0C2);

  static const Color gold = Color(0xFFFFCD75);
  static const Color goldDark = Color(0xFFD68C45);
  static const Color xpBar = Color(0xFF73EFF7);
  static const Color success = Color(0xFF38B764);
  static const Color danger = Color(0xFFE43B44);

  static const Color textPrimary = Color(0xFFF4F4F4);
  static const Color textSecondary = Color(0xFFB8C4D4);
  static const Color textMuted = Color(0xFF7F90A6);
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

