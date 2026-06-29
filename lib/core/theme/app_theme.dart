import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// ─────────────────────────────────────────────────────────────
/// AppTheme — Material 3 theme configurations.
/// ─────────────────────────────────────────────────────────────
abstract class AppTheme {
  // ── Dark ───────────────────────────────────────────────────
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.violet,
          secondary: AppColors.cyan,
          tertiary: AppColors.emerald,
          surface: AppColors.darkSurface,
          error: AppColors.rose,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        cardTheme: CardThemeData(
          color: AppColors.darkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            side: const BorderSide(color: AppColors.darkBorder),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.darkBorder,
          thickness: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkCard,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: const BorderSide(color: AppColors.darkBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: const BorderSide(color: AppColors.darkBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide:
                const BorderSide(color: AppColors.violet, width: 1.5),
          ),
          hintStyle: GoogleFonts.inter(
              fontSize: 14, color: AppColors.darkTextTertiary),
          labelStyle: GoogleFonts.inter(
              fontSize: 14, color: AppColors.darkTextTertiary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.violet,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        extensions: const [PortfolioThemeExt.dark],
      );

  // ── Light ──────────────────────────────────────────────────
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBg,
        colorScheme: const ColorScheme.light(
          primary: AppColors.violetDark,
          secondary: AppColors.cyan,
          tertiary: AppColors.emerald,
          surface: AppColors.lightSurface,
          error: AppColors.rose,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        cardTheme: CardThemeData(
          color: AppColors.lightSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            side: const BorderSide(color: AppColors.lightBorder),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.lightBorder,
          thickness: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightCard,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: const BorderSide(color: AppColors.lightBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: const BorderSide(color: AppColors.lightBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide:
                const BorderSide(color: AppColors.violetDark, width: 1.5),
          ),
          hintStyle: GoogleFonts.inter(
              fontSize: 14, color: AppColors.lightTextTertiary),
          labelStyle: GoogleFonts.inter(
              fontSize: 14, color: AppColors.lightTextTertiary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.violetDark,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: GoogleFonts.inter(
                fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        extensions: const [PortfolioThemeExt.light],
      );
}

/// Custom ThemeExtension for portfolio-specific design tokens.
class PortfolioThemeExt extends ThemeExtension<PortfolioThemeExt> {
  const PortfolioThemeExt({
    required this.cardColor,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.glassBg,
    required this.glassBorder,
    required this.sectionAltBg,
  });

  final Color cardColor;
  final Color cardBorder;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color glassBg;
  final Color glassBorder;
  final Color sectionAltBg;

  static const dark = PortfolioThemeExt(
    cardColor: AppColors.darkCard,
    cardBorder: AppColors.darkBorder,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    glassBg: Color(0x0DFFFFFF),
    glassBorder: Color(0x1AFFFFFF),
    sectionAltBg: Color(0x0A8B5CF6),
  );

  static const light = PortfolioThemeExt(
    cardColor: AppColors.lightSurface,
    cardBorder: AppColors.lightBorder,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    glassBg: Color(0xEEFFFFFF),
    glassBorder: Color(0x14000000),
    sectionAltBg: Color(0x068B5CF6),
  );

  @override
  PortfolioThemeExt copyWith({
    Color? cardColor,
    Color? cardBorder,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? glassBg,
    Color? glassBorder,
    Color? sectionAltBg,
  }) =>
      PortfolioThemeExt(
        cardColor: cardColor ?? this.cardColor,
        cardBorder: cardBorder ?? this.cardBorder,
        textPrimary: textPrimary ?? this.textPrimary,
        textSecondary: textSecondary ?? this.textSecondary,
        textTertiary: textTertiary ?? this.textTertiary,
        glassBg: glassBg ?? this.glassBg,
        glassBorder: glassBorder ?? this.glassBorder,
        sectionAltBg: sectionAltBg ?? this.sectionAltBg,
      );

  @override
  PortfolioThemeExt lerp(PortfolioThemeExt? other, double t) {
    if (other == null) return this;
    return PortfolioThemeExt(
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      glassBg: Color.lerp(glassBg, other.glassBg, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      sectionAltBg: Color.lerp(sectionAltBg, other.sectionAltBg, t)!,
    );
  }
}

/// Convenience extension so callers can write `Theme.of(ctx).ext`
extension ThemeExt on ThemeData {
  PortfolioThemeExt get ext =>
      extension<PortfolioThemeExt>() ?? PortfolioThemeExt.dark;
}
