import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ─────────────────────────────────────────────────────────────
/// AppTypography — type scale built on Inter + JetBrains Mono.
/// Uses an 8pt baseline grid; line-heights tuned for web reading.
/// ─────────────────────────────────────────────────────────────
abstract class AppTypography {
  // ── Display ────────────────────────────────────────────────
  static TextStyle get displayXl => GoogleFonts.inter(
        fontSize: 96,
        fontWeight: FontWeight.w900,
        height: 0.95,
        letterSpacing: -3.5,
      );

  static TextStyle get display => GoogleFonts.inter(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        height: 1.0,
        letterSpacing: -2.5,
      );

  // ── Headings ───────────────────────────────────────────────
  static TextStyle get h1 => GoogleFonts.inter(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -1.5,
      );

  static TextStyle get h2 => GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -1.0,
      );

  static TextStyle get h3 => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get h4 => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.3,
      );

  static TextStyle get h5 => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.1,
      );

  // ── Body ───────────────────────────────────────────────────
  static TextStyle get bodyLg => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.75,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.65,
      );

  static TextStyle get bodySm => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  // ── UI Labels ──────────────────────────────────────────────
  static TextStyle get label => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get labelSm => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.8,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  // ── Navigation ─────────────────────────────────────────────
  static TextStyle get navLink => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );

  // ── Button ─────────────────────────────────────────────────
  static TextStyle get button => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      );

  // ── Mono / Code ────────────────────────────────────────────
  static TextStyle get mono => GoogleFonts.jetBrainsMono(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.6,
        letterSpacing: 0.2,
      );
}
