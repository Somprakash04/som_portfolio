import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/utils/responsive_utils.dart';
import '../../core/widgets/section_header.dart';
import '../../data/portfolio_data.dart';
import '../../providers/navigation_provider.dart';
import 'widgets/timeline_item.dart';

/// ─────────────────────────────────────────────────────────────
/// ExperienceSection — animated vertical timeline.
/// ─────────────────────────────────────────────────────────────
class ExperienceSection extends ConsumerStatefulWidget {
  const ExperienceSection({super.key});

  @override
  ConsumerState<ExperienceSection> createState() =>
      _ExperienceSectionState();
}

class _ExperienceSectionState
    extends ConsumerState<ExperienceSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final key    = ref.watch(sectionKeysProvider)['experience'];
    final items  = PortfolioData.experiences;

    return VisibilityDetector(
      key: const Key('exp-vis'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.12 && !_visible) {
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
                label: '04  EXPERIENCE',
                title: 'My Journey',
                subtitle:
                    'A timeline of learning, building, and shipping.',
              ),

              // ── Timeline list ──────────────────────────────
              ...items.asMap().entries.map(
                    (e) => TimelineItem(
                      experience: e.value,
                      isLast: e.key == items.length - 1,
                      isDark: isDark,
                      visible: _visible,
                      index: e.key,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
