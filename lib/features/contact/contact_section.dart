import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/utils/url_launcher_utils.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/section_header.dart';
import '../../data/portfolio_data.dart';
import '../../providers/navigation_provider.dart';
import 'widgets/contact_form.dart';
import 'widgets/social_links_widget.dart';

/// ─────────────────────────────────────────────────────────────
/// ContactSection — form (left) + social links (right).
/// ─────────────────────────────────────────────────────────────
class ContactSection extends ConsumerStatefulWidget {
  const ContactSection({super.key});

  @override
  ConsumerState<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends ConsumerState<ContactSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final isMobile = R.isMobile(context);
    final key      = ref.watch(sectionKeysProvider)['contact'];

    return VisibilityDetector(
      key: const Key('contact-vis'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
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
                label: '06  CONTACT',
                title: 'Let\'s Work Together',
                subtitle:
                    'Have a project in mind, want to collaborate, or just say hi? I\'d love to hear from you.',
              ),

              AnimatedOpacity(
                opacity: _visible ? 1 : 0,
                duration: const Duration(milliseconds: 550),
                child: isMobile
                    ? _MobileLayout(isDark: isDark)
                    : _DesktopLayout(isDark: isDark),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // ── Resume download CTA ──────────────────────
              Center(
                child: CustomButton(
                  label: 'Download My Resume',
                  icon: Icons.file_download_outlined,
                  variant: BtnVariant.outline,
                  onPressed: () =>
                      UrlLauncherUtils.download(PortfolioData.resumeUrl),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Form
        Expanded(
          flex: 11,
          child: ContactForm(isDark: isDark),
        ),
        const SizedBox(width: 48),
        // Social links
        Expanded(
          flex: 8,
          child: SocialLinksWidget(isDark: isDark),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactForm(isDark: isDark),
        const SizedBox(height: 36),
        SocialLinksWidget(isDark: isDark),
      ],
    );
  }
}
