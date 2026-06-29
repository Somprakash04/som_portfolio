import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// ─────────────────────────────────────────────────────────────
/// SectionHeader — labelled section title + optional subtitle.
/// Used at the top of every portfolio section.
/// ─────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.label,
    this.align = CrossAxisAlignment.start,
  });

  final String title;
  final String? subtitle;

  /// Short uppercase category label, e.g. "01 ABOUT"
  final String? label;

  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textAlign =
        align == CrossAxisAlignment.center ? TextAlign.center : TextAlign.start;
    final mainAlign = align == CrossAxisAlignment.center
        ? MainAxisAlignment.center
        : MainAxisAlignment.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        // ── Chip label ──────────────────────────────────────
        if (label != null)
          Row(
            mainAxisAlignment: mainAlign,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.violet.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusFull),
                  border: Border.all(
                      color: AppColors.violet.withOpacity(0.22)),
                ),
                child: Text(
                  label!,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.violet,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

        if (label != null) const SizedBox(height: AppSpacing.md),

        // ── Title ────────────────────────────────────────────
        Text(
          title,
          textAlign: textAlign,
          style: AppTypography.h2.copyWith(
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 80.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

        // ── Subtitle ─────────────────────────────────────────
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            subtitle!,
            textAlign: textAlign,
            style: AppTypography.bodyLg.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 160.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
        ],

        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}
