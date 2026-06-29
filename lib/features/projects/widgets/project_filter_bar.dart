import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../providers/projects_provider.dart';

/// ─────────────────────────────────────────────────────────────
/// ProjectFilterBar — search field + category chip row.
/// ─────────────────────────────────────────────────────────────
class ProjectFilterBar extends ConsumerWidget {
  const ProjectFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark      = Theme.of(context).brightness == Brightness.dark;
    final filter      = ref.watch(projectsFilterProvider);
    final categories  = ref.watch(projectCategoriesProvider);
    final notifier    = ref.read(projectsFilterProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Search field ────────────────────────────────────
        TextField(
          onChanged: notifier.setQuery,
          style: AppTypography.body.copyWith(
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Search by name, stack, or keyword…',
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 20,
              color: isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.lightTextTertiary,
            ),
            suffixIcon: filter.query.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
                    ),
                    onPressed: notifier.reset,
                  )
                : null,
          ),
        ),

        const SizedBox(height: 16),

        // ── Category chips ───────────────────────────────────
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((cat) {
              final selected = filter.category == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => notifier.setCategory(cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.violet
                            : (isDark
                                ? AppColors.darkCard
                                : AppColors.lightCard),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusFull),
                        border: Border.all(
                          color: selected
                              ? AppColors.violet
                              : (isDark
                                  ? AppColors.darkBorder
                                  : AppColors.lightBorder),
                        ),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: AppColors.violet.withOpacity(0.28),
                                  blurRadius: 12,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : [],
                      ),
                      child: Text(
                        cat,
                        style: AppTypography.label.copyWith(
                          color: selected
                              ? Colors.white
                              : (isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary),
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
