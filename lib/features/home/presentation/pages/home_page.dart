import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/navigation_provider.dart';
import '../../../hero/hero_section.dart';
import '../../../about/about_section.dart';
import '../../../skills/skills_section.dart';
import '../../../projects/projects_section.dart';
import '../../../experience/experience_section.dart';
import '../../../achievements/achievements_section.dart';
import '../../../contact/contact_section.dart';
import '../../../footer/footer_section.dart';

/// ─────────────────────────────────────────────────────────────
/// HomePage — single-page layout; all sections assembled here.
/// The ShellPage wraps this with the nav bar overlay + FABs.
/// ─────────────────────────────────────────────────────────────
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.watch(scrollControllerProvider);

    return Scrollbar(
      controller: ctrl,
      thumbVisibility: false,
      child: SingleChildScrollView(
        controller: ctrl,
        child: const Column(
          children: [
            // ── 00 Hero ──────────────────────────────────────
            HeroSection(),

            // ── 01 About ─────────────────────────────────────
            AboutSection(),

            // ── 02 Skills ────────────────────────────────────
            SkillsSection(),

            // ── 03 Projects ──────────────────────────────────
            ProjectsSection(),

            // ── 04 Experience ────────────────────────────────
            ExperienceSection(),

            // ── 05 Achievements ──────────────────────────────
            AchievementsSection(),

            // ── 06 Contact ───────────────────────────────────
            ContactSection(),

            // ── Footer ───────────────────────────────────────
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
