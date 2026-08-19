import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF1FA96C);
  static const Color primaryDark = Color(0xFF0D8A54);
  static const Color accent = Color.fromARGB(255, 255, 255, 255);
  static const Color background = Color(0xFFF7F9F7);
  static const Color surface = Color(0xFFEFF4EF);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFC0392B);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1FA96C), Color(0xFF0D8A54)],
  );

  // Rotating palette for conversation list rows
  static const List<LinearGradient> rowGradients = [
    LinearGradient(colors: [Color(0xFF2DBE91), Color(0xFF1B9E76)]), // teal-green
    LinearGradient(colors: [Color(0xFFFF8A5B), Color(0xFFFF6B35)]), // orange
    LinearGradient(colors: [Color(0xFF4E9FF5), Color(0xFF2E7CD6)]), // blue
    LinearGradient(colors: [Color(0xFF9B7EF0), Color(0xFF7A5AD8)]), // purple
  ];
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.background,
        error: AppColors.error,
      ),
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.fraunces(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleLarge: GoogleFonts.fraunces(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: AppColors.textDark),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: AppColors.textDark),
        bodySmall: GoogleFonts.inter(fontSize: 12, color: Colors.black54),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 6,
        shadowColor: AppColors.primary.withValues(alpha: 0.18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.surface),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.surface),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}