import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/widgets/section_header.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/projects_provider.dart';
import 'widgets/project_card.dart';
import 'widgets/project_filter_bar.dart';

/// ─────────────────────────────────────────────────────────────
/// ProjectsSection — filterable, searchable project grid.
/// ─────────────────────────────────────────────────────────────
class ProjectsSection extends ConsumerStatefulWidget {
  const ProjectsSection({super.key});

  @override
  ConsumerState<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends ConsumerState<ProjectsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final key      = ref.watch(sectionKeysProvider)['projects'];
    final projects = ref.watch(filteredProjectsProvider);
    final cols     = R.gridColumns(context, mobile: 1, tablet: 2, desktop: 3);

    return VisibilityDetector(
      key: const Key('projects-vis'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        key: key,
        padding: R.sectionPadding(context),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurface.withOpacity(0.5)
              : AppColors.lightCard.withOpacity(0.5),
        ),
        child: R.constrained(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                label: '03  PROJECTS',
                title: 'What I\'ve Built',
                subtitle:
                    'Production-grade apps shipping real value — from mobile to IoT.',
              ),

              // ── Filter bar ──────────────────────────────────
              const ProjectFilterBar(),
              const SizedBox(height: AppSpacing.xl),

              // ── Project grid ────────────────────────────────
              projects.isEmpty
                  ? _EmptyState(isDark: isDark)
                  : _ProjectGrid(
                      projects: projects,
                      visible: _visible,
                      cols: cols,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Responsive masonry-style grid built with LayoutBuilder.
class _ProjectGrid extends StatelessWidget {
  const _ProjectGrid({
    required this.projects,
    required this.visible,
    required this.cols,
  });

  final List projects;
  final bool visible;
  final int cols;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final gap = 20.0;
      final cardW =
          (constraints.maxWidth - gap * (cols - 1)) / cols;

      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: projects.asMap().entries.map((e) {
          return SizedBox(
            width: cardW,
            child: ProjectCard(
              project: e.value,
              visible: visible,
              staggerIdx: e.key,
            ),
          );
        }).toList(),
      );
    });
  }
}

/// Shown when search / filter returns no results.
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 52,
              color: isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.lightTextTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No projects match your search.',
              style: AppTypography.bodyLg.copyWith(
                color: isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
