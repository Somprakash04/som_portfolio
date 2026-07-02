import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/section_header.dart';
import '../../data/portfolio_data.dart';
import '../../providers/navigation_provider.dart';

/// ─────────────────────────────────────────────────────────────
/// AboutSection — bio, stats grid, core strengths list.
/// ─────────────────────────────────────────────────────────────
class AboutSection extends ConsumerStatefulWidget {
  const AboutSection({super.key});

  @override
  ConsumerState<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends ConsumerState<AboutSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final isMobile = R.isMobile(context);
    final key      = ref.watch(sectionKeysProvider)['about'];

    return VisibilityDetector(
      key: const Key('about-vis'),
      onVisibilityChanged: (i) {
        if (i.visibleFraction > 0.18 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        key: key,
        padding: R.sectionPadding(context),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurface.withOpacity(0.6)
              : AppColors.lightCard.withOpacity(0.6),
        ),
        child: R.constrained(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                label: '01  ABOUT',
                title: 'My Story & Mission',
                subtitle: 'From hobby projects to production systems — and still going.',
              ),
              isMobile
                  ? _mobile(isDark)
                  : _desktop(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktop(bool isDark) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(flex: 11, child: _Bio(isDark: isDark, visible: _visible)),
      const SizedBox(width: 48),
      Expanded(
        flex: 8,
        child: Column(
          children: [
            _StatsGrid(isDark: isDark, visible: _visible),
            const SizedBox(height: 24),
            _StrengthsList(isDark: isDark, visible: _visible),
          ],
        ),
      ),
    ],
  );

  Widget _mobile(bool isDark) => Column(
    children: [
      _Bio(isDark: isDark, visible: _visible),
      const SizedBox(height: 32),
      _StatsGrid(isDark: isDark, visible: _visible),
      const SizedBox(height: 24),
      _StrengthsList(isDark: isDark, visible: _visible),
    ],
  );
}

// ── Bio paragraphs ───────────────────────────────────────────
class _Bio extends StatelessWidget {
  const _Bio({required this.isDark, required this.visible});
  final bool isDark;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(-0.04, 0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: PortfolioData.aboutParagraphs.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Text(
              p,
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
                height: 1.78,
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }
}

// ── Stats 2×2 grid ───────────────────────────────────────────
class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.isDark, required this.visible});
  final bool isDark;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final entries = PortfolioData.stats.entries.toList();
    const cols = 2;
    const gap = 14.0;

    // Wrap + content-sized cards (NOT GridView+childAspectRatio).
    // A fixed aspect ratio forces an exact height regardless of how
    // much room the h3 number + caption label actually need — on
    // narrow mobile widths that caused repeated bottom overflow.
    // Wrap lets each card size to its own natural content height.
    return LayoutBuilder(builder: (_, constraints) {
      final cardW =
      ((constraints.maxWidth - gap * (cols - 1)) / cols)
          .clamp(0.0, double.infinity);

      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: entries.asMap().entries.map((entry) {
          final i = entry.key;
          final e = entry.value;
          return AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: Duration(milliseconds: 400 + i * 100),
            child: SizedBox(
              width: cardW,
              child: GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (b) =>
                          AppColors.primaryGradient.createShader(b),
                      child: Text(
                        e.value,
                        style: AppTypography.h3.copyWith(
                            fontWeight: FontWeight.w800),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      e.key,
                      style: AppTypography.caption.copyWith(
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}

// ── Core strengths bullet list ────────────────────────────────
class _StrengthsList extends StatelessWidget {
  const _StrengthsList({required this.isDark, required this.visible});
  final bool isDark;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Core Strengths',
            style: AppTypography.h5.copyWith(
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...PortfolioData.highlights.asMap().entries.map((e) =>
              AnimatedOpacity(
                opacity: visible ? 1 : 0,
                duration: Duration(milliseconds: 300 + e.key * 80),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 11),
                  child: Row(
                    children: [
                      Container(
                        width: 6, height: 6,
                        decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          e.value,
                          style: AppTypography.bodySm.copyWith(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}