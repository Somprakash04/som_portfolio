import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/tech_badge.dart';
import '../../../data/models/project_model.dart';

/// ─────────────────────────────────────────────────────────────
/// ProjectCard — animated project card with hover lift.
/// ─────────────────────────────────────────────────────────────
class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.visible,
    required this.staggerIdx,
  });

  final ProjectModel project;
  final bool visible;
  final int staggerIdx;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = widget.project.accentColor ?? AppColors.violet;

    return AnimatedOpacity(
      opacity: widget.visible ? 1 : 0,
      duration: Duration(milliseconds: 350 + widget.staggerIdx * 90),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hov = true),
        onExit:  (_) => setState(() => _hov = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 230),
          transform: _hov
              ? (Matrix4.identity()..translate(0.0, -6.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(
              color: _hov
                  ? accent.withOpacity(0.45)
                  : (isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
            ),
            boxShadow: _hov
                ? [
                    BoxShadow(
                      color: accent.withOpacity(0.14),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Accent gradient stripe ─────────────────────
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accent, accent.withOpacity(0.25)],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Title row ──────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.project.title,
                              style: AppTypography.h4.copyWith(
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.project.isFeatured) ...[
                            const SizedBox(width: 8),
                            _FeaturedBadge(),
                          ],
                        ],
                      ),

                      const SizedBox(height: 6),

                      // ── Category ───────────────────────────
                      Text(
                        widget.project.category.toUpperCase(),
                        style: AppTypography.labelSm.copyWith(
                          color: accent,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── Short description ──────────────────
                      Text(
                        widget.project.description,
                        style: AppTypography.bodySm.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                          height: 1.65,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 16),

                      // ── Tech badges ────────────────────────
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.technologies
                            .take(5)
                            .map((t) => TechBadge(label: t, color: accent))
                            .toList(),
                      ),

                      const SizedBox(height: 20),

                      // ── Action buttons ─────────────────────
                      Row(
                        children: [
                          if (widget.project.githubUrl != null)
                            _ActionBtn(
                              icon: Icons.code_rounded,
                              label: 'Source',
                              url: widget.project.githubUrl!,
                              isDark: isDark,
                            ),
                          if (widget.project.githubUrl != null &&
                              widget.project.liveUrl != null)
                            const SizedBox(width: 8),
                          if (widget.project.liveUrl != null)
                            _ActionBtn(
                              icon: Icons.open_in_new_rounded,
                              label: 'Live Demo',
                              url: widget.project.liveUrl!,
                              isDark: isDark,
                              primary: true,
                              accent: accent,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Featured star badge ───────────────────────────────────────
class _FeaturedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.amber.withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: AppColors.amber.withOpacity(0.32)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 10, color: AppColors.amber),
          const SizedBox(width: 4),
          Text(
            'Featured',
            style: AppTypography.labelSm
                .copyWith(color: AppColors.amber, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}

// ── Source / Live button ──────────────────────────────────────
class _ActionBtn extends StatefulWidget {
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.url,
    required this.isDark,
    this.primary = false,
    this.accent,
  });

  final IconData icon;
  final String label;
  final String url;
  final bool isDark;
  final bool primary;
  final Color? accent;

  @override
  State<_ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<_ActionBtn> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.accent ?? AppColors.violet;

    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlLauncherUtils.open(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: widget.primary
                ? c.withOpacity(_hov ? 1.0 : 0.12)
                : (widget.isDark
                    ? Colors.white.withOpacity(_hov ? 0.1 : 0.06)
                    : Colors.black.withOpacity(_hov ? 0.08 : 0.04)),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
              color: widget.primary
                  ? c.withOpacity(_hov ? 0.0 : 0.3)
                  : (widget.isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.09)),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 14,
                color: widget.primary
                    ? (_hov ? Colors.white : c)
                    : (widget.isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: widget.primary
                      ? (_hov ? Colors.white : c)
                      : (widget.isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
