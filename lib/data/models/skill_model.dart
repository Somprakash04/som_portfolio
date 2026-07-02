import 'package:flutter/material.dart';

enum SkillCategory { mobile, backend, core, tools }

/// ─────────────────────────────────────────────────────────────
/// SkillModel — a single technology / skill entry.
/// ─────────────────────────────────────────────────────────────
class SkillModel {
  const SkillModel({
    required this.name,
    required this.category,
    required this.proficiency,
    this.color,
  });

  final String name;
  final SkillCategory category;

  /// Proficiency from 0.0 (none) to 1.0 (expert).
  final double proficiency;

  /// Optional accent colour; falls back to category colour.
  final Color? color;
}
