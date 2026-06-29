import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/utils/url_launcher_utils.dart';
import '../../core/widgets/gradient_text.dart';
import '../../data/portfolio_data.dart';

/// ─────────────────────────────────────────────────────────────
/// FooterSection — copyright + quick links + social icons.
/// ─────────────────────────────────────────────────────────────
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final isMobile = R.isMobile(context);
    final year     = DateTime.now().year;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: R.hPad(context),
        vertical: AppSpacing.xxl,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBg : AppColors.lightBg,
        border: Border(
          top: BorderSide(
            color: isDark
                ? AppColors.darkBorder
                : AppColors.lightBorder,
          ),
        ),
      ),
      child: R.constrained(
        Column(
          children: [
            // ── Top row ──────────────────────────────────────
            isMobile
                ? _mobileTop(isDark)
                : _desktopTop(isDark),

            const SizedBox(height: AppSpacing.xl),
            Divider(
              color: isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Bottom row ───────────────────────────────────
            isMobile
                ? _mobileBottom(isDark, year)
                : _desktopBottom(isDark, year),
          ],
        ),
      ),
    );
  }

  Widget _desktopTop(bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand col
        _BrandCol(isDark: isDark),
        const Spacer(),
        // Nav links
        _LinksCol(
          title: 'Navigation',
          links: const [
            'About', 'Skills', 'Projects',
            'Experience', 'Achievements', 'Contact',
          ],
          isDark: isDark,
        ),
        const SizedBox(width: 56),
        // Connect col
        _ConnectCol(isDark: isDark),
      ],
    );
  }

  Widget _mobileTop(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BrandCol(isDark: isDark),
        const SizedBox(height: 28),
        _ConnectCol(isDark: isDark),
      ],
    );
  }

  Widget _desktopBottom(bool isDark, int year) {
    return Row(
      children: [
        Text(
          '© $year ${PortfolioData.fullName}. Built with Flutter ❤️',
          style: AppTypography.caption.copyWith(
            color: isDark
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
          ),
        ),
        const Spacer(),
        Text(
          'Made in Udaipur, India 🇮🇳',
          style: AppTypography.caption.copyWith(
            color: isDark
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
          ),
        ),
      ],
    );
  }

  Widget _mobileBottom(bool isDark, int year) {
    return Column(
      children: [
        Text(
          '© $year ${PortfolioData.fullName}',
          style: AppTypography.caption.copyWith(
            color: isDark
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Built with Flutter ❤️  ·  Made in Udaipur 🇮🇳',
          style: AppTypography.caption.copyWith(
            color: isDark
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ── Brand column ─────────────────────────────────────────────
class _BrandCol extends StatelessWidget {
  const _BrandCol({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText(
            'SP.dev',
            gradient: AppColors.primaryGradient,
            style: AppTypography.h4.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Flutter Developer — building elegant, high-performance mobile experiences from Udaipur, India.',
            style: AppTypography.bodySm.copyWith(
              color: isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.lightTextTertiary,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Nav links column ─────────────────────────────────────────
class _LinksCol extends StatelessWidget {
  const _LinksCol({
    required this.title,
    required this.links,
    required this.isDark,
  });
  final String title;
  final List<String> links;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.label.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 14),
        ...links.map((l) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  l,
                  style: AppTypography.bodySm.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

// ── Connect column ───────────────────────────────────────────
class _ConnectCol extends StatelessWidget {
  const _ConnectCol({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect',
          style: AppTypography.label.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: PortfolioData.socialLinks.map((link) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _SocialIconBtn(
                icon: link.icon,
                url: link.url,
                color: link.color ?? AppColors.violet,
                isDark: isDark,
                tooltip: link.platform,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () =>
              UrlLauncherUtils.sendEmail(PortfolioData.email),
          child: Text(
            PortfolioData.email,
            style: AppTypography.bodySm.copyWith(
              color: AppColors.violet,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.violet,
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialIconBtn extends StatefulWidget {
  const _SocialIconBtn({
    required this.icon,
    required this.url,
    required this.color,
    required this.isDark,
    required this.tooltip,
  });

  final dynamic icon;
  final String url;
  final Color color;
  final bool isDark;
  final String tooltip;

  @override
  State<_SocialIconBtn> createState() => _SocialIconBtnState();
}

class _SocialIconBtnState extends State<_SocialIconBtn> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hov = true),
        onExit:  (_) => setState(() => _hov = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => UrlLauncherUtils.open(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 170),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _hov
                  ? widget.color.withOpacity(0.14)
                  : (widget.isDark
                      ? AppColors.darkCard
                      : AppColors.lightCard),
              shape: BoxShape.circle,
              border: Border.all(
                color: _hov
                    ? widget.color.withOpacity(0.5)
                    : (widget.isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder),
              ),
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 14,
                color: _hov
                    ? widget.color
                    : (widget.isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
