import 'package:flutter/material.dart';

/// Central color and theme definitions for the Neuro Novice Nurse app.
class AppColors {
  AppColors._();

  static const Color primaryDark = Color(0xFF1E8058);
  static const Color primary = Color(0xFF2FA06D);
  static const Color primaryLight = Color(0xFF74DBA6);
  static const Color accent = Color(0xFFA3EBC5);
  static const Color danger = Color(0xFFE0483C);

  static const Color background = Colors.white;
  static const Color cardBackground = Colors.white;
  static const Color textDark = Color(0xFF1F3D33);
  static const Color textMuted = Color(0xFF3B4E45);

  /// Text placed directly on the page background image (outside any white
  /// card) needs a light color for contrast since the image is dark green.
  static const Color textOnBackground = Color(0xFFF5F9F7);

  static const Color fieldFill = Color(0xFFF2F8F5);
  static const Color fieldBorder = Color(0xFFE0EAE4);

  static const List<Color> headerGradient = [primaryDark, primary, primaryLight];

  /// Soft layered shadow used behind rounded cards for depth.
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: primaryDark.withValues(alpha: 0.22),
      blurRadius: 32,
      offset: const Offset(0, 16),
    ),
    BoxShadow(
      color: primaryDark.withValues(alpha: 0.12),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];

  static const double cardRadius = 18;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Kanit',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Kanit',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppColors.cardRadius)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.fieldFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        labelStyle: const TextStyle(color: AppColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.6),
        ),
      ),
    );
  }
}
