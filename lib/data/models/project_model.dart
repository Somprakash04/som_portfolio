import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────
/// ProjectModel — represents a portfolio project entry.
/// ─────────────────────────────────────────────────────────────
class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.longDescription,
    required this.technologies,
    required this.category,
    this.githubUrl,
    this.liveUrl,
    this.imageUrl,
    this.isFeatured = false,
    this.accentColor,
  });

  final String id;
  final String title;
  final String description;
  final String longDescription;
  final List<String> technologies;
  final String category; // e.g. "Mobile", "Full-Stack", "Web"
  final String? githubUrl;
  final String? liveUrl;
  final String? imageUrl;
  final bool isFeatured;
  final Color? accentColor;
}
