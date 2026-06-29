import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../data/portfolio_data.dart';

/// Row of social icon buttons shown in the Contact section.
class SocialLinksWidget extends StatelessWidget {
  const SocialLinksWidget({super.key, required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find me online',
          style: AppTypography.h5.copyWith(
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 20),
        ...PortfolioData.socialLinks.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _SocialTile(link: link, isDark: isDark),
            )),
      ],
    );
  }
}

class _SocialTile extends StatefulWidget {
  const _SocialTile({required this.link, required this.isDark});
  final dynamic link;
  final bool isDark;

  @override
  State<_SocialTile> createState() => _SocialTileState();
}

class _SocialTileState extends State<_SocialTile> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.link.color as Color? ?? AppColors.violet;

    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlLauncherUtils.open(widget.link.url as String),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: 13),
          decoration: BoxDecoration(
            color: _hov
                ? color.withOpacity(0.09)
                : (widget.isDark
                    ? AppColors.darkCard
                    : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: _hov
                  ? color.withOpacity(0.4)
                  : (widget.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FaIcon(
                    widget.link.icon,
                    size: 15,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Platform + username
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.link.platform as String,
                      style: AppTypography.label.copyWith(
                        fontWeight: FontWeight.w600,
                        color: widget.isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    if (widget.link.username != null)
                      Text(
                        widget.link.username as String,
                        style: AppTypography.caption.copyWith(
                          color: widget.isDark
                              ? AppColors.darkTextTertiary
                              : AppColors.lightTextTertiary,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: _hov
                    ? color
                    : (widget.isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
