import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/tech_badge.dart';
import '../../../data/models/experience_model.dart';

/// ─────────────────────────────────────────────────────────────
/// TimelineItem — a single entry in the vertical timeline.
/// ─────────────────────────────────────────────────────────────
class TimelineItem extends StatefulWidget {
  const TimelineItem({
    super.key,
    required this.experience,
    required this.isLast,
    required this.isDark,
    required this.visible,
    required this.index,
  });

  final ExperienceModel experience;
  final bool isLast;
  final bool isDark;
  final bool visible;
  final int index;

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _hov = false;

  // ── Colour per experience type ───────────────────────────
  Color get _accent {
    switch (widget.experience.type) {
      case ExperienceType.education:   return AppColors.emerald;
      case ExperienceType.internship:  return AppColors.violet;
      case ExperienceType.work:        return AppColors.cyan;
      case ExperienceType.project:     return AppColors.amber;
    }
  }

  // ── Icon per experience type ─────────────────────────────
  IconData get _icon {
    switch (widget.experience.type) {
      case ExperienceType.education:   return Icons.school_outlined;
      case ExperienceType.internship:  return Icons.business_center_outlined;
      case ExperienceType.work:        return Icons.work_outline_rounded;
      case ExperienceType.project:     return Icons.rocket_launch_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.visible ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: AnimatedSlide(
        offset: widget.visible
            ? Offset.zero
            : const Offset(0.06, 0),
        duration: Duration(
            milliseconds: 450 + widget.index * 60),
        curve: Curves.easeOut,
        // ── Stack-based timeline (deliberately NOT IntrinsicHeight) ──
        // IntrinsicHeight *pre-estimates* the content card's height and
        // forces the spine to match that estimate. Text layout during
        // that estimation pass can disagree with the real layout pass
        // (e.g. Google Fonts loading async, multi-line wrapping), which
        // caused the "RenderFlex overflowed on the bottom" crash.
        //
        // A Stack has no such estimation step: the content Row lays out
        // FIRST with its natural, unconstrained height, the Stack then
        // sizes itself to fit that exactly, and the connecting line
        // (Positioned with top+bottom) derives its height as simple
        // subtraction — stackHeight - top - bottom. This is exact by
        // construction and can never overflow, regardless of how long
        // the title/description/tech-chip list grows.
        child: Stack(
          children: [
            // ── Connecting line (drawn behind the row) ──────────
            if (!widget.isLast)
              Positioned(
                left: 23, // centers the 2px line under the 38px dot
                top: 38,  // starts right below the dot
                bottom: 0,
                child: Container(
                  width: 2,
                  color: widget.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder,
                ),
              ),

            // ── Foreground: dot + content card ──────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dot — horizontally centred in a 48-wide column,
                // top-aligned (no Expanded line nested here anymore).
                SizedBox(
                  width: 48,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: _hov
                            ? _accent.withValues(alpha: 0.18)
                            : (widget.isDark
                            ? AppColors.darkCard
                            : AppColors.lightSurface),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _accent,
                          width: 1.8,
                        ),
                        boxShadow: _hov
                            ? [
                          BoxShadow(
                            color: _accent.withValues(alpha: 0.25),
                            blurRadius: 12,
                          )
                        ]
                            : [],
                      ),
                      child: Icon(_icon, size: 17, color: _accent),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // ── Content card ───────────────────────────────
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: widget.isLast ? 0 : 28),
                    child: MouseRegion(
                      onEnter: (_) => setState(() => _hov = true),
                      onExit:  (_) => setState(() => _hov = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: widget.isDark
                              ? (_hov
                              ? AppColors.darkCardHover
                              : AppColors.darkCard)
                              : (_hov
                              ? AppColors.lightCardHover
                              : AppColors.lightSurface),
                          borderRadius: BorderRadius.circular(
                              AppSpacing.radiusLg),
                          border: Border.all(
                            color: _hov
                                ? _accent.withValues(alpha: 0.4)
                                : (widget.isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                          ),
                          boxShadow: _hov
                              ? [
                            BoxShadow(
                              color: _accent.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            )
                          ]
                              : [],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title row — Expanded prevents horizontal overflow
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.experience.title,
                                    style: AppTypography.h5.copyWith(
                                      color: widget.isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.lightTextPrimary,
                                    ),
                                    // Allow wrapping on very narrow screens
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (widget.experience.isCurrent) ...[
                                  const SizedBox(width: 8),
                                  _CurrentBadge(accent: _accent),
                                ],
                              ],
                            ),

                            const SizedBox(height: 6),

                            // Organisation + date on SEPARATE lines so they
                            // never overflow on narrow (360dp) phones.
                            Text(
                              widget.experience.organization,
                              style: AppTypography.bodySm.copyWith(
                                color: _accent,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.experience.isCurrent
                                  ? '${widget.experience.startDate} — Present'
                                  : '${widget.experience.startDate}'
                                  ' — '
                                  '${widget.experience.endDate ?? ''}',
                              style: AppTypography.caption.copyWith(
                                color: widget.isDark
                                    ? AppColors.darkTextTertiary
                                    : AppColors.lightTextTertiary,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Description — free to wrap to however many
                            // lines it needs; the Stack simply grows to fit.
                            Text(
                              widget.experience.description,
                              style: AppTypography.bodySm.copyWith(
                                color: widget.isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                                height: 1.65,
                              ),
                            ),

                            // Tech chips
                            if (widget.experience.technologies.isNotEmpty) ...[
                              const SizedBox(height: 14),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: widget.experience.technologies
                                    .map((t) => TechBadge(
                                  label: t,
                                  color: _accent,
                                ))
                                    .toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// "Current" green pill badge.
class _CurrentBadge extends StatelessWidget {
  const _CurrentBadge({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.emerald.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(
            color: AppColors.emerald.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: AppColors.emerald,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            'Current',
            style: AppTypography.labelSm.copyWith(
              color: AppColors.emerald,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}