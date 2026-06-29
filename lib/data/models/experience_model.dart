/// Type of timeline entry.
enum ExperienceType { education, internship, work, project }

/// ─────────────────────────────────────────────────────────────
/// ExperienceModel — a timeline entry (education / work / etc.)
/// ─────────────────────────────────────────────────────────────
class ExperienceModel {
  const ExperienceModel({
    required this.title,
    required this.organization,
    required this.startDate,
    this.endDate,
    required this.description,
    this.technologies = const [],
    required this.type,
    this.url,
    this.isCurrent = false,
  });

  final String title;
  final String organization;
  final String startDate;

  /// null when [isCurrent] is true
  final String? endDate;
  final String description;
  final List<String> technologies;
  final ExperienceType type;
  final String? url;
  final bool isCurrent;
}
