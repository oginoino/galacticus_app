import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppPalette {
  static const background = Color(0xFF050708);
  static const surface = Color(0xFF101315);
  static const surfaceAlt = Color(0xFF191D20);
  static const card = Color(0xFF14181B);
  static const border = Color(0xFF262C31);
  static const primary = Color(0xFFB7F36B);
  static const primaryStrong = Color(0xFFC8FF7A);
  static const secondary = Color(0xFF8EA4FF);
  static const textPrimary = Color(0xFFF5F7FA);
  static const textSecondary = Color(0xFFB2BAC3);
}

class AppTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppPalette.background,
      colorScheme: const ColorScheme.dark(
        primary: AppPalette.primary,
        secondary: AppPalette.secondary,
        surface: AppPalette.surface,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppPalette.textPrimary,
        displayColor: AppPalette.textPrimary,
      ),
      cardColor: AppPalette.card,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppPalette.surfaceAlt,
        contentTextStyle: GoogleFonts.inter(
          color: AppPalette.textPrimary,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.textPrimary,
        ),
      ),
    );
  }

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFFF6F8F3),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF7BCB31),
        secondary: AppPalette.secondary,
        surface: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black87,
        contentTextStyle: GoogleFonts.inter(
          color: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
