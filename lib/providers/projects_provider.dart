import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/models/project_model.dart';
import '../data/portfolio_data.dart';

// ═══════════════════════════════════════════════════════════════
//  Projects Filter Provider
// ═══════════════════════════════════════════════════════════════

class ProjectsFilter {
  const ProjectsFilter({
    this.query = '',
    this.category = 'All',
  });

  final String query;
  final String category;

  ProjectsFilter copyWith({String? query, String? category}) => ProjectsFilter(
        query: query ?? this.query,
        category: category ?? this.category,
      );
}

final projectsFilterProvider =
    StateNotifierProvider<ProjectsFilterNotifier, ProjectsFilter>(
  (ref) => ProjectsFilterNotifier(),
);

class ProjectsFilterNotifier extends StateNotifier<ProjectsFilter> {
  ProjectsFilterNotifier() : super(const ProjectsFilter());

  void setQuery(String q) => state = state.copyWith(query: q);
  void setCategory(String c) => state = state.copyWith(category: c);
  void reset() => state = const ProjectsFilter();
}

/// Derived list of projects after applying filter + search.
final filteredProjectsProvider = Provider<List<ProjectModel>>((ref) {
  final filter = ref.watch(projectsFilterProvider);
  return PortfolioData.projects.where((p) {
    final matchCat =
        filter.category == 'All' || p.category == filter.category;
    final q = filter.query.toLowerCase();
    final matchQuery = q.isEmpty ||
        p.title.toLowerCase().contains(q) ||
        p.description.toLowerCase().contains(q) ||
        p.technologies.any((t) => t.toLowerCase().contains(q));
    return matchCat && matchQuery;
  }).toList();
});

/// All unique project categories prefixed with "All".
final projectCategoriesProvider = Provider<List<String>>((ref) {
  final cats =
      PortfolioData.projects.map((p) => p.category).toSet().toList();
  return ['All', ...cats];
});
