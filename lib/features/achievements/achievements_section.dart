import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/widgets/section_header.dart';
import '../../data/portfolio_data.dart';
import '../../providers/navigation_provider.dart';
import 'widgets/achievement_card.dart';

/// ─────────────────────────────────────────────────────────────
/// AchievementsSection — certs, coding profiles, awards grid.
/// ─────────────────────────────────────────────────────────────
class AchievementsSection extends ConsumerStatefulWidget {
  const AchievementsSection({super.key});

  @override
  ConsumerState<AchievementsSection> createState() =>
      _AchievementsSectionState();
}

class _AchievementsSectionState
    extends ConsumerState<AchievementsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final key    = ref.watch(sectionKeysProvider)['achievements'];
    final items  = PortfolioData.achievements;
    final cols   =
        R.gridColumns(context, mobile: 1, tablet: 2, desktop: 3);

    return VisibilityDetector(
      key: const Key('achievements-vis'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.12 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        key: key,
        padding: R.sectionPadding(context),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSurface.withOpacity(0.5)
              : AppColors.lightCard.withOpacity(0.4),
        ),
        child: R.constrained(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                label: '05  ACHIEVEMENTS',
                title: 'Certifications & Recognition',
                subtitle:
                    'Milestones that mark the learning journey.',
              ),

              // ── Grid ──────────────────────────────────────
              LayoutBuilder(builder: (_, constraints) {
                final gap  = 18.0;
                final cardW =
                    (constraints.maxWidth - gap * (cols - 1)) /
                        cols;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: items.asMap().entries.map((e) {
                    return SizedBox(
                      width: cardW,
                      child: AchievementCard(
                        achievement: e.value,
                        visible: _visible,
                        staggerIdx: e.key,
                        isDark: isDark,
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
