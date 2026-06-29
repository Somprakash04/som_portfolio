import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// ═══════════════════════════════════════════════════════════════
//  Navigation / Scroll Providers
// ═══════════════════════════════════════════════════════════════

/// Shared ScrollController for the single-page layout.
final scrollControllerProvider = Provider<ScrollController>((ref) {
  final c = ScrollController();
  ref.onDispose(c.dispose);
  return c;
});

/// GlobalKey map for every named section — used by nav to scroll-to.
final sectionKeysProvider = Provider<Map<String, GlobalKey>>((ref) => {
      'hero': GlobalKey(),
      'about': GlobalKey(),
      'skills': GlobalKey(),
      'projects': GlobalKey(),
      'experience': GlobalKey(),
      'achievements': GlobalKey(),
      'contact': GlobalKey(),
    });

/// Normalised scroll progress (0.0 – 1.0).
final scrollProgressProvider = StateProvider<double>((ref) => 0.0);

/// Whether the back-to-top FAB should be visible.
final showBackToTopProvider = StateProvider<bool>((ref) => false);
