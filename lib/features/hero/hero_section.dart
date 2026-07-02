import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/utils/url_launcher_utils.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/gradient_text.dart';
import '../../data/portfolio_data.dart';
import '../../providers/navigation_provider.dart';

/// ─────────────────────────────────────────────────────────────
/// HeroSection — full-viewport opening section.
/// ─────────────────────────────────────────────────────────────
class HeroSection extends ConsumerStatefulWidget {
  const HeroSection({super.key});

  @override
  ConsumerState<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends ConsumerState<HeroSection> {
  int _titleIdx = 0;

  @override
  void initState() {
    super.initState();
    _cycle();
  }

  void _cycle() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() =>
      _titleIdx = (_titleIdx + 1) % PortfolioData.heroTitles.length);
      _cycle();
    });
  }

  void _goto(String key) {
    final ctx = ref.read(sectionKeysProvider)[key]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final isMobile = R.isMobile(context);
    final keys     = ref.watch(sectionKeysProvider);

    return Container(
      key: keys['hero'],
      width: double.infinity,
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height),
      color: isDark ? AppColors.darkBg : AppColors.lightBg,
      child: Stack(
        children: [
          // ── Decorative background ──────────────────────────
          const _GridBg(),
          _GlowOrb(
              top: -120, right: -120,
              color: AppColors.violet, size: 500,
              opacity: isDark ? 0.13 : 0.07),
          _GlowOrb(
              bottom: -80, left: -80,
              color: AppColors.cyan, size: 380,
              opacity: isDark ? 0.09 : 0.05),

          // ── Content ────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(
              top: AppSpacing.navHeight +
                  (isMobile ? 36 : 56),
              left:  R.hPad(context),
              right: R.hPad(context),
              bottom: 80,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: AppSpacing.maxContentWidth),
                child: isMobile
                    ? _mobileLayout(context, isDark)
                    : _desktopLayout(context, isDark),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopLayout(BuildContext context, bool isDark) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 11,
        child: _HeroContent(
          isDark: isDark, titleIdx: _titleIdx,
          onProjects: () => _goto('projects'),
          onContact:  () => _goto('contact'),
        ),
      ),
      const SizedBox(width: 56),
      Expanded(
        flex: 8,
        child: _HeroIllustration(isDark: isDark),
      ),
    ],
  );

  Widget _mobileLayout(BuildContext context, bool isDark) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
          child: _HeroIllustration(isDark: isDark, size: 240)),
      const SizedBox(height: 40),
      _HeroContent(
        isDark: isDark, titleIdx: _titleIdx,
        onProjects: () => _goto('projects'),
        onContact:  () => _goto('contact'),
        isMobile: true,
      ),
    ],
  );
}

// ─────────────────────────────────────────────────────────────
// Hero text content
// ─────────────────────────────────────────────────────────────
class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.isDark,
    required this.titleIdx,
    required this.onProjects,
    required this.onContact,
    this.isMobile = false,
  });

  final bool isDark;
  final int titleIdx;
  final VoidCallback onProjects;
  final VoidCallback onContact;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── "Available" pill ──────────────────────────────────
        _AvailableBadge(isDark: isDark)
            .animate()
            .fadeIn(duration: 400.ms)
            .slideX(begin: -0.1, end: 0, curve: Curves.easeOut),

        const SizedBox(height: 22),

        // ── Name ──────────────────────────────────────────────
        GradientText(
          PortfolioData.name,
          gradient: AppColors.heroGradient,
          style: AppTypography.display.copyWith(
            fontSize: isMobile ? 64 : 88,
            fontWeight: FontWeight.w900,
            height: 0.92,
            letterSpacing: -3,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .slideY(begin: 0.15, end: 0, curve: Curves.easeOut),

        const SizedBox(height: 18),

        // ── Animated typewriter title ─────────────────────────
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 380),
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween<Offset>(
                  begin: const Offset(0, 0.25), end: Offset.zero)
                  .animate(CurvedAnimation(
                  parent: anim, curve: Curves.easeOut)),
              child: child,
            ),
          ),
          child: Text(
            PortfolioData.heroTitles[titleIdx],
            key: ValueKey(titleIdx),
            style: AppTypography.h3.copyWith(
              fontSize: isMobile ? 20 : 28,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

        const SizedBox(height: 20),

        // ── Tagline ───────────────────────────────────────────
        Text(
          PortfolioData.heroTagline,
          style: AppTypography.bodyLg.copyWith(
            color: isDark
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
            height: 1.65,
          ),
          maxLines: 3,
        ).animate().fadeIn(duration: 500.ms, delay: 320.ms),

        const SizedBox(height: 40),

        // ── CTA row ───────────────────────────────────────────
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            CustomButton(
              label: 'View Projects',
              icon: Icons.work_outline_rounded,
              trailingIcon: Icons.arrow_forward_rounded,
              variant: BtnVariant.primary,
              onPressed: onProjects,
            ),
            CustomButton(
              label: 'Download Resume',
              icon: Icons.file_download_outlined,
              variant: BtnVariant.secondary,
              onPressed: () =>
                  UrlLauncherUtils.download(PortfolioData.resumeUrl),
            ),
            CustomButton(
              label: 'Contact Me',
              icon: Icons.mail_outline_rounded,
              variant: BtnVariant.ghost,
              onPressed: onContact,
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: 440.ms)
            .slideY(begin: 0.1, end: 0),

        const SizedBox(height: 44),

        // ── Location line ─────────────────────────────────────
        Row(
          children: [
            Icon(Icons.location_on_outlined,
                size: 15,
                color: isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                PortfolioData.location,
                style: AppTypography.bodySm.copyWith(
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 400.ms, delay: 600.ms),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Floating avatar illustration
// ─────────────────────────────────────────────────────────────
class _HeroIllustration extends StatefulWidget {
  const _HeroIllustration({required this.isDark, this.size = 380});
  final bool isDark;
  final double size;

  @override
  State<_HeroIllustration> createState() => _HeroIllustrationState();
}

class _HeroIllustrationState extends State<_HeroIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
  AnimationController(vsync: this, duration: const Duration(seconds: 3))
    ..repeat(reverse: true);
  late final Animation<double> _float =
  Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _float,
      builder: (_, child) =>
          Transform.translate(offset: Offset(0, _float.value), child: child),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glow
            Container(
              width: widget.size * 0.68,
              height: widget.size * 0.68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.violet.withValues(alpha: 0.28),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
            // Avatar
            Container(
              width: widget.size * 0.74,
              height: widget.size * 0.74,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient),
              padding: const EdgeInsets.all(3.5),
              child: ClipOval(
                child: Container(
                  color: widget.isDark
                      ? AppColors.darkCard
                      : AppColors.lightCard,
                  child: PortfolioData.profileImage.isNotEmpty
                      ? Image.network(PortfolioData.profileImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          _Placeholder(size: widget.size))
                      : _Placeholder(size: widget.size),
                ),
              ),
            ),
            // Floating badge — top-right
            Positioned(
              top: widget.size * 0.06,
              right: widget.size * 0.02,
              child: _FloatBadge(
                  label: 'Flutter Dev',
                  icon: Icons.flutter_dash,
                  isDark: widget.isDark),
            ),
            // Floating badge — bottom-left
            Positioned(
              bottom: widget.size * 0.1,
              left: widget.size * 0.0,
              child: _FloatBadge(
                  label: 'Clean Code',
                  icon: Icons.code_rounded,
                  isDark: widget.isDark),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms, delay: 180.ms)
        .scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1));
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBg,
      child: Center(
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (b) =>
              AppColors.primaryGradient.createShader(b),
          child: Text(
            PortfolioData.name.isNotEmpty
                ? PortfolioData.name[0]
                : 'S',
            style: TextStyle(
              fontSize: size * 0.28,
              // fontSize: size * 0.28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatBadge extends StatelessWidget {
  const _FloatBadge(
      {required this.label, required this.icon, required this.isDark});
  final String label;
  final IconData icon;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.1),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.violet),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────
class _AvailableBadge extends StatelessWidget {
  const _AvailableBadge({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.violet.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: AppColors.violet.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6, height: 6,
            decoration: const BoxDecoration(
                color: AppColors.emerald, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          // Flexible (loose fit) lets the text shrink-to-ellipsis on
          // narrow screens instead of forcing the Row past its bounds.
          Flexible(
            child: Text(
              'Available for opportunities',
              style: AppTypography.caption.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _GridBg extends StatelessWidget {
  const _GridBg();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Positioned.fill(
      child: CustomPaint(painter: _GridPainter(isDark: isDark)),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.isDark});
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.028)
      ..strokeWidth = 1;
    const step = 44.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(_GridPainter o) => o.isDark != isDark;
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    this.top, this.bottom, this.left, this.right,
    required this.color, required this.size, required this.opacity,
  });
  final double? top, bottom, left, right;
  final Color color;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [
            color.withValues(alpha: opacity),
            Colors.transparent,
          ]),
        ),
      ),
    );
  }
}