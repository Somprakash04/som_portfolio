import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/widgets/section_header.dart';
import '../../data/models/skill_model.dart';
import '../../data/portfolio_data.dart';
import '../../providers/navigation_provider.dart';
import 'widgets/skill_card.dart';

/// ─────────────────────────────────────────────────────────────
/// SkillsSection — categorised animated skill cards.
/// ─────────────────────────────────────────────────────────────
class SkillsSection extends ConsumerStatefulWidget {
  const SkillsSection({super.key});

  @override
  ConsumerState<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends ConsumerState<SkillsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final key    = ref.watch(sectionKeysProvider)['skills'];

    final mobile  = PortfolioData.skills
        .where((s) => s.category == SkillCategory.mobile).toList();
    final backend = PortfolioData.skills
        .where((s) => s.category == SkillCategory.backend).toList();
    final tools   = PortfolioData.skills
        .where((s) => s.category == SkillCategory.tools).toList();

    return VisibilityDetector(
      key: const Key('skills-vis'),
      onVisibilityChanged: (i) {
        if (i.visibleFraction > 0.14 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        key: key,
        padding: R.sectionPadding(context),
        child: R.constrained(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                label: '02  SKILLS',
                title: 'Tech Stack & Expertise',
                subtitle:
                'Technologies I work with day-to-day — from pixels to packets.',
              ),
              _CatBlock(
                emoji: '📱',
                label: 'Mobile Development',
                skills: mobile,
                accent: AppColors.violet,
                visible: _visible,
                isDark: isDark,
                staggerOffset: 0,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _CatBlock(
                emoji: '⚡',
                label: 'Backend & Services',
                skills: backend,
                accent: AppColors.cyan,
                visible: _visible,
                isDark: isDark,
                staggerOffset: mobile.length,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _CatBlock(
                emoji: '🛠',
                label: 'Tools & DevOps',
                skills: tools,
                accent: AppColors.emerald,
                visible: _visible,
                isDark: isDark,
                staggerOffset: mobile.length + backend.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CatBlock extends StatelessWidget {
  const _CatBlock({
    required this.emoji,
    required this.label,
    required this.skills,
    required this.accent,
    required this.visible,
    required this.isDark,
    required this.staggerOffset,
  });

  final String emoji;
  final String label;
  final List<SkillModel> skills;
  final Color accent;
  final bool visible;
  final bool isDark;
  final int staggerOffset;

  @override
  Widget build(BuildContext context) {
    final isMobile = R.isMobile(context);
    final cols     = R.gridColumns(context, mobile: 2, tablet: 3, desktop: 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
            Text(
              label,
              style: AppTypography.h5.copyWith(
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Grid
        LayoutBuilder(builder: (_, constraints) {
          final gap = 14.0;
          final w   = ((constraints.maxWidth - gap * (cols - 1)) / cols)
              .clamp(0.0, double.infinity);
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: skills.asMap().entries.map((e) => SizedBox(
              width: w,
              child: SkillCard(
                skill: e.value,
                visible: visible,
                staggerIdx: staggerOffset + e.key,
                accent: accent,
                isDark: isDark,
              ),
            )).toList(),
          );
        }),
      ],
    );
  }
}