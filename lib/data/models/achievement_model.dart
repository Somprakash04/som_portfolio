import 'package:flutter/material.dart';

enum AchievementType { certification, coding, award, recognition }

/// ─────────────────────────────────────────────────────────────
/// AchievementModel — certifications, coding profiles, awards.
/// ─────────────────────────────────────────────────────────────
class AchievementModel {
  const AchievementModel({
    required this.title,
    required this.issuer,
    required this.date,
    required this.type,
    this.description,
    this.url,
    this.icon,
    this.color,
  });

  final String title;
  final String issuer;
  final String date;
  final AchievementType type;
  final String? description;
  final String? url;
  final IconData? icon;
  final Color? color;
}
