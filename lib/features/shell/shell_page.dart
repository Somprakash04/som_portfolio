import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/back_to_top_button.dart';
import '../../core/widgets/scroll_progress_indicator.dart';
import '../../providers/navigation_provider.dart';
import 'widgets/nav_bar.dart';

/// ─────────────────────────────────────────────────────────────
/// ShellPage — provides the outer scaffold shared by all routes:
///   • Frosted nav bar overlay
///   • Scroll-progress bar
///   • Back-to-top FAB
/// ─────────────────────────────────────────────────────────────
class ShellPage extends ConsumerStatefulWidget {
  const ShellPage({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends ConsumerState<ShellPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _attachScrollListener());
  }

  void _attachScrollListener() {
    final ctrl = ref.read(scrollControllerProvider);
    ctrl.addListener(() {
      final max = ctrl.position.maxScrollExtent;
      final cur = ctrl.offset;
      ref.read(scrollProgressProvider.notifier).state =
          max > 0 ? (cur / max).clamp(0.0, 1.0) : 0.0;
      ref.read(showBackToTopProvider.notifier).state = cur > 400;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress   = ref.watch(scrollProgressProvider);
    final showFab    = ref.watch(showBackToTopProvider);
    final ctrl       = ref.watch(scrollControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          // ── Main scrollable content ──────────────────────
          widget.child,

          // ── Frosted nav bar (top overlay) ────────────────
          const Positioned(
            top: 0, left: 0, right: 0,
            child: PortfolioNavBar(),
          ),

          // ── Scroll-progress bar (above nav) ──────────────
          ScrollProgressBar(progress: progress),

          // ── Back-to-top FAB ──────────────────────────────
          Positioned(
            bottom: 32,
            right: 24,
            child: BackToTopButton(
              visible: showFab,
              onPressed: () => ctrl.animateTo(
                0,
                duration: const Duration(milliseconds: 650),
                curve: Curves.easeInOut,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
