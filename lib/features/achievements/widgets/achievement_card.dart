import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../data/models/achievement_model.dart';

/// ─────────────────────────────────────────────────────────────
/// AchievementCard — cert / award / coding profile card.
/// ─────────────────────────────────────────────────────────────
class AchievementCard extends StatefulWidget {
  const AchievementCard({
    super.key,
    required this.achievement,
    required this.visible,
    required this.staggerIdx,
    required this.isDark,
  });

  final AchievementModel achievement;
  final bool visible;
  final int staggerIdx;
  final bool isDark;

  @override
  State<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<AchievementCard> {
  bool _hov = false;

  Color get _accent =>
      widget.achievement.color ?? AppColors.violet;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.visible ? 1 : 0,
      duration: Duration(
          milliseconds: 300 + widget.staggerIdx * 90),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hov = true),
        onExit:  (_) => setState(() => _hov = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 210),
          transform: _hov
              ? (Matrix4.identity()..translate(0.0, -4.0))
              : Matrix4.identity(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: widget.isDark
                ? (_hov ? AppColors.darkCardHover : AppColors.darkCard)
                : (_hov ? AppColors.lightCardHover : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(
              color: _hov
                  ? _accent.withOpacity(0.45)
                  : (widget.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
            ),
            boxShadow: _hov
                ? [
                    BoxShadow(
                      color: _accent.withOpacity(0.13),
                      blurRadius: 22,
                      offset: const Offset(0, 7),
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Icon circle ──────────────────────────────
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: _accent.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: _accent.withOpacity(0.3)),
                    ),
                    child: Icon(
                      widget.achievement.icon ??
                          Icons.emoji_events_outlined,
                      size: 20,
                      color: _accent,
                    ),
                  ),
                  const Spacer(),
                  _TypeChip(type: widget.achievement.type),
                ],
              ),

              const SizedBox(height: 14),

              // ── Title ────────────────────────────────────
              Text(
                widget.achievement.title,
                style: AppTypography.h5.copyWith(
                  color: widget.isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              // ── Issuer + date ────────────────────────────
              Text(
                '${widget.achievement.issuer}  ·  ${widget.achievement.date}',
                style: AppTypography.caption.copyWith(
                  color: _accent,
                  fontWeight: FontWeight.w600,
                ),
              ),

              // ── Description ──────────────────────────────
              if (widget.achievement.description != null) ...[
                const SizedBox(height: 10),
                Text(
                  widget.achievement.description!,
                  style: AppTypography.caption.copyWith(
                    color: widget.isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                    height: 1.65,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              // ── Link ─────────────────────────────────────
              if (widget.achievement.url != null) ...[
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () =>
                      UrlLauncherUtils.open(widget.achievement.url!),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View',
                        style: AppTypography.caption.copyWith(
                          color: _accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.open_in_new_rounded,
                          size: 12, color: _accent),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Small type label chip (Certification / Coding / Award).
class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.type});
  final AchievementType type;

  String get _label {
    switch (type) {
      case AchievementType.certification: return 'Cert';
      case AchievementType.coding:        return 'Coding';
      case AchievementType.award:         return 'Award';
      case AchievementType.recognition:   return 'Recognition';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.violet.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border:
            Border.all(color: AppColors.violet.withOpacity(0.22)),
      ),
      child: Text(
        _label,
        style: AppTypography.labelSm.copyWith(
          color: AppColors.violet,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
