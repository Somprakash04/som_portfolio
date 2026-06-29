import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../data/models/skill_model.dart';

/// Animated skill card with proficiency progress bar.
class SkillCard extends StatefulWidget {
  const SkillCard({
    super.key,
    required this.skill,
    required this.visible,
    required this.staggerIdx,
    required this.accent,
    required this.isDark,
  });

  final SkillModel skill;
  final bool visible;
  final int staggerIdx;
  final Color accent;
  final bool isDark;

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.visible ? 1 : 0,
      duration: Duration(milliseconds: 300 + widget.staggerIdx * 55),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hov = true),
        onExit:  (_) => setState(() => _hov = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: widget.isDark
                ? (_hov ? AppColors.darkCardHover : AppColors.darkCard)
                : (_hov ? AppColors.lightCardHover : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: _hov
                  ? widget.accent.withOpacity(0.35)
                  : (widget.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
            ),
            boxShadow: _hov
                ? [
                    BoxShadow(
                      color: widget.accent.withOpacity(0.12),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.skill.name,
                      style: AppTypography.label.copyWith(
                        fontWeight: FontWeight.w600,
                        color: widget.isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${(widget.skill.proficiency * 100).round()}%',
                    style: AppTypography.caption.copyWith(
                      color: widget.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ── Progress bar ─────────────────────────────────
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusFull),
                child: Container(
                  height: 4,
                  color: widget.isDark
                      ? Colors.white.withOpacity(0.07)
                      : Colors.black.withOpacity(0.06),
                  child: widget.visible
                      ? FractionallySizedBox(
                          widthFactor: widget.skill.proficiency,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                widget.accent,
                                widget.accent.withOpacity(0.55),
                              ]),
                              borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusFull),
                            ),
                          ),
                        )
                          .animate()
                          .slideX(
                            begin: -1,
                            end: 0,
                            duration: Duration(
                                milliseconds:
                                    700 + widget.staggerIdx * 45),
                            curve: Curves.easeOut,
                          )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
