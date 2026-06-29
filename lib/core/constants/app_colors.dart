import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────
/// AppColors — central color palette for the portfolio.
/// Edit ONLY this file to rebrand the entire app.
/// ─────────────────────────────────────────────────────────────
abstract class AppColors {
  // ── Brand ──────────────────────────────────────────────────
  static const Color violet      = Color(0xFF8B5CF6);
  static const Color violetDark  = Color(0xFF7C3AED);
  static const Color violetLight = Color(0xFFA78BFA);
  static const Color cyan        = Color(0xFF06B6D4);
  static const Color emerald     = Color(0xFF10B981);
  static const Color rose        = Color(0xFFF43F5E);
  static const Color amber       = Color(0xFFF59E0B);

  // ── Dark theme ─────────────────────────────────────────────
  static const Color darkBg          = Color(0xFF090912);
  static const Color darkSurface     = Color(0xFF10101A);
  static const Color darkCard        = Color(0xFF14141F);
  static const Color darkCardHover   = Color(0xFF1B1B2A);
  static const Color darkBorder      = Color(0xFF1E1E2E);

  static const Color darkTextPrimary   = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary  = Color(0xFF64748B);

  // ── Light theme ────────────────────────────────────────────
  static const Color lightBg        = Color(0xFFF8FAFC);
  static const Color lightSurface   = Color(0xFFFFFFFF);
  static const Color lightCard      = Color(0xFFF1F5F9);
  static const Color lightCardHover = Color(0xFFE2E8F0);
  static const Color lightBorder    = Color(0xFFE2E8F0);

  static const Color lightTextPrimary   = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF334155);
  static const Color lightTextTertiary  = Color(0xFF64748B);

  // ── Gradients ──────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [violet, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [violet, Color(0xFF7C3AED), cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Glassmorphism helpers ──────────────────────────────────
  static Color glassWhite(double opacity) => Colors.white.withOpacity(opacity);
  static Color glassBlack(double opacity) => Colors.black.withOpacity(opacity);
}
