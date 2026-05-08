// ============================================================
// SentinelX — App Theme (Cybersecurity Dark Mode)
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Color Palette ──────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0A0E1A);
  static const Color backgroundCard = Color(0xFF111827);
  static const Color backgroundElevated = Color(0xFF1C2536);
  static const Color surfaceDark = Color(0xFF161D2F);

  static const Color primary = Color(0xFF00D4FF);      // Cyan — primary brand
  static const Color primaryDark = Color(0xFF0099CC);
  static const Color secondary = Color(0xFF7C3AED);    // Purple — accent
  static const Color secondaryLight = Color(0xFF9F67FF);

  static const Color danger = Color(0xFFEF4444);       // Red — critical/high
  static const Color dangerDark = Color(0xFFB91C1C);
  static const Color warning = Color(0xFFF59E0B);      // Amber — medium/warning
  static const Color success = Color(0xFF10B981);      // Green — safe/low
  static const Color successDark = Color(0xFF059669);
  static const Color info = Color(0xFF3B82F6);         // Blue — info

  static const Color textPrimary = Color(0xFFF9FAFB);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF4B5563);
  static const Color textHighlight = Color(0xFF00D4FF);

  static const Color borderColor = Color(0xFF1F2937);
  static const Color dividerColor = Color(0xFF1F2937);

  // ── Gradient Definitions ───────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00D4FF), Color(0xFF7C3AED)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient dangerGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF111827), Color(0xFF1C2536)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Risk Color Mapping ─────────────────────────────────────────────
  static Color riskColor(String level) {
    switch (level.toUpperCase()) {
      case 'CRITICAL':
        return danger;
      case 'HIGH':
        return const Color(0xFFF97316); // Orange
      case 'MEDIUM':
        return warning;
      case 'LOW':
        return success;
      default:
        return textSecondary;
    }
  }

  static Color riskColorFromScore(double score) {
    if (score >= 86) return danger;
    if (score >= 61) return const Color(0xFFF97316);
    if (score >= 31) return warning;
    return success;
  }

  // ── Dark Theme ─────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    final textTheme = GoogleFonts.interTextTheme(base.textTheme).apply(
      bodyColor: textPrimary,
      displayColor: textPrimary,
    );

    return base.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: backgroundCard,
        error: danger,
        onPrimary: backgroundDark,
        onSecondary: textPrimary,
        onSurface: textPrimary,
        onError: textPrimary,
        brightness: Brightness.dark,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: backgroundCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderColor, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: danger),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textMuted),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: backgroundDark,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundCard,
        selectedItemColor: primary,
        unselectedItemColor: textMuted,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: backgroundElevated,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: backgroundElevated,
        labelStyle: const TextStyle(color: textPrimary, fontSize: 12),
        side: const BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? primary : textMuted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? primary.withOpacity(0.3)
              : borderColor,
        ),
      ),
    );
  }
}
