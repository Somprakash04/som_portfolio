import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../providers/navigation_provider.dart';
import '../../../providers/theme_provider.dart';

/// ─────────────────────────────────────────────────────────────
/// PortfolioNavBar — frosted glass top bar with:
///   • Logo (left)
///   • Section links (centre / drawer on mobile)
///   • Theme toggle (right)
/// ─────────────────────────────────────────────────────────────
class PortfolioNavBar extends ConsumerStatefulWidget {
  const PortfolioNavBar({super.key});

  @override
  ConsumerState<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends ConsumerState<PortfolioNavBar> {
  bool _drawerOpen = false;

  static const _items = [
    'About', 'Skills', 'Projects',
    'Experience', 'Achievements', 'Contact',
  ];

  void _scrollTo(String section) {
    final keys = ref.read(sectionKeysProvider);
    final ctx  = keys[section.toLowerCase()]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
    if (_drawerOpen) setState(() => _drawerOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark    = ref.watch(themeModeProvider) == ThemeMode.dark;
    final progress  = ref.watch(scrollProgressProvider);
    final isMobile  = R.isMobile(context);
    final scrolled  = progress > 0.01;

    return Column(
      children: [
        // ── Main bar ────────────────────────────────────────
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withOpacity(scrolled ? 0.72 : 0.35)
                    : Colors.white.withOpacity(scrolled ? 0.88 : 0.6),
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(scrolled ? 0.08 : 0.03)
                        : Colors.black.withOpacity(scrolled ? 0.07 : 0.03),
                  ),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 40,
                  ),
                  child: SizedBox(
                    height: isMobile
                        ? AppSpacing.navHeightMobile
                        : AppSpacing.navHeight,
                    child: Row(
                      children: [
                        _Logo(isDark: isDark),
                        const Spacer(),
                        if (!isMobile)
                          Row(
                            children: _items
                                .map((i) => _NavLink(
                                      label: i,
                                      onTap: () => _scrollTo(i),
                                      isDark: isDark,
                                    ))
                                .toList(),
                          ),
                        const SizedBox(width: 10),
                        _ThemeToggle(isDark: isDark),
                        if (isMobile) ...[
                          const SizedBox(width: 6),
                          _MenuBtn(
                            open: _drawerOpen,
                            isDark: isDark,
                            onTap: () =>
                                setState(() => _drawerOpen = !_drawerOpen),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // ── Mobile drawer ───────────────────────────────────
        if (isMobile)
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _MobileDrawer(
              isDark: isDark,
              items: _items,
              onTap: _scrollTo,
            ),
            crossFadeState: _drawerOpen
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
      ],
    );
  }
}

// ── Logo ─────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  const _Logo({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (b) =>
          AppColors.primaryGradient.createShader(b),
      child: Text(
        'SP.dev',
        style: AppTypography.h5.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
        ),
      ),
    );
  }
}

// ── Desktop nav link ─────────────────────────────────────────
class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.onTap,
    required this.isDark,
  });
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
          child: Text(
            widget.label,
            style: AppTypography.navLink.copyWith(
              color: _hov
                  ? AppColors.violet
                  : (widget.isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Theme toggle ─────────────────────────────────────────────
class _ThemeToggle extends ConsumerWidget {
  const _ThemeToggle({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: GestureDetector(
        onTap: () => ref.read(themeModeProvider.notifier).toggle(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.12)
                  : Colors.black.withOpacity(0.09),
            ),
          ),
          child: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            size: 17,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ),
    );
  }
}

// ── Hamburger button ─────────────────────────────────────────
class _MenuBtn extends StatelessWidget {
  const _MenuBtn(
      {required this.open, required this.onTap, required this.isDark});
  final bool open;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.06),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            open ? Icons.close : Icons.menu_rounded,
            key: ValueKey(open),
            size: 18,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ),
    );
  }
}

// ── Mobile drawer ─────────────────────────────────────────────
class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer(
      {required this.isDark, required this.items, required this.onTap});
  final bool isDark;
  final List<String> items;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.black.withOpacity(0.88)
            : Colors.white.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.07),
          ),
        ),
      ),
      child: Column(
        children: items
            .asMap()
            .entries
            .map((e) => GestureDetector(
                  onTap: () => onTap(e.value),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    child: Text(
                      e.value,
                      style: AppTypography.navLink.copyWith(
                        fontSize: 15,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                )
                    .animate(delay: Duration(milliseconds: e.key * 40))
                    .fadeIn(duration: 200.ms)
                    .slideX(begin: -0.05, end: 0))
            .toList(),
      ),
    );
  }
}
