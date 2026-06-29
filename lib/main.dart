import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'router/app_router.dart';

// ═══════════════════════════════════════════════════════════════
//  main.dart — Entry point
// ═══════════════════════════════════════════════════════════════

void main() {
  // Speed up flutter_animate globally
  // FlutterAnimate.restartOnHotReload = true;

  runApp(
    // Wrap the whole app in ProviderScope (Riverpod)
    const ProviderScope(
      child: PortfolioApp(),
    ),
  );
}

/// Root widget — reads theme + router from Riverpod.
class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router    = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      // ── Meta ─────────────────────────────────────────────
      title: 'SP | Flutter Developer',
      debugShowCheckedModeBanner: false,

      // ── Theme ─────────────────────────────────────────────
      theme:      AppTheme.lightTheme,
      darkTheme:  AppTheme.darkTheme,
      themeMode:  themeMode,

      // ── Router ─────────────────────────────────────────────
      routerConfig: router,

      // ── Responsive framework ───────────────────────────────
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: const [
          Breakpoint(start: 0,    end: 480,  name: MOBILE),
          Breakpoint(start: 481,  end: 768,  name: TABLET),
          Breakpoint(start: 769,  end: 1280, name: DESKTOP),
          Breakpoint(start: 1281, end: 1920, name: '4K'),
          Breakpoint(start: 1921, end: double.infinity, name: '8K'),
        ],
      ),
    );
  }
}
