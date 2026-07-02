import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/constants/app_colors.dart';
import 'models/achievement_model.dart';
import 'models/experience_model.dart';
import 'models/project_model.dart';
import 'models/skill_model.dart';
import 'models/social_link_model.dart';

// ═══════════════════════════════════════════════════════════════
//  PORTFOLIO DATA  ·  Edit ONLY this file to update content.
//  No UI changes needed — all sections read from here.
// ═══════════════════════════════════════════════════════════════

abstract class PortfolioData {
  // ── Personal ─────────────────────────────────────────────────
  static const String name = "I'm Som";
  static const String fullName =
      'Somprakash Arun'; // ← Replace with your full name
  static const String title = 'Flutter Developer';
  static const String location = 'Udaipur, Rajasthan 🇮🇳';
  static const String email = 'somprakasharun@gmail.com';
  static const String phone = '+91 8854062571';
  static const String profileImage =
      ''; // URL or leave '' for avatar placeholder

  /// Typewriter animation titles in the hero section.
  static const List<String> heroTitles = [
    'Flutter Developer',
    'Mobile App Engineer',
    'UI/UX Enthusiast',
    'AI-Powered App Builder',
    'Clean Code Advocate',
  ];

  static const String heroTagline =
      'Building elegant, high-performance mobile experiences — one widget at a time.';

  static const String resumeUrl = '/assets/resume/SOMPRAKASH_ARUN.pdf';

  // ── About ─────────────────────────────────────────────────────
  static const String aboutTitle = 'Crafting Mobile Experiences with Flutter';

  static const List<String> aboutParagraphs = [
    "I'm a Computer Science Engineering student (graduating 2027) and Flutter "
        "developer with hands-on experience building scalable, real-world "
        "mobile applications. My journey started with a passion for clean, "
        "high-performance apps — and evolved into deep expertise across "
        "the Flutter ecosystem.",
    "I recently completed a 4-month internship at Cognus Technology, Udaipur, "
        "where I shipped full-stack features integrating Flutter frontends with "
        "Node.js backends, Firebase, and AI-powered capabilities. My approach "
        "centers on Clean Architecture, typed error handling with fpdart, and "
        "sealed-class state machines in Riverpod 2.x.",
    "I'm actively building toward roles at AI-first companies — bridging "
        "Flutter mobile development with LLM integration and on-device ML.",
  ];

  static const List<String> highlights = [
    'Clean Architecture & SOLID Principles',
    'Riverpod 2.x & BLoC State Management',
    'AI/LLM-Powered Mobile Features',
    'Full-Stack: Firebase, Supabase & Node.js',
    'Built & Shipped 50+ Production-Grade Components',
    'CSE Student — Graduating 2027',
  ];

  static const Map<String, String> stats = {
    'Projects Built': '10+',
    'Lines of Code': '20K+',
    'Months Interned': '4',
    'Tech Tools Used': '10+',
    'GitHub Commits': '500+',
    'Coffee ☕': '∞',
  };

  // ── Skills ────────────────────────────────────────────────────
  static final List<SkillModel> skills = [
    // Mobile
    const SkillModel(
      name: 'Flutter / Dart',
      category: SkillCategory.mobile,
      proficiency: 0.85,
    ),
    const SkillModel(
      name: 'Riverpod 2.x',
      category: SkillCategory.mobile,
      proficiency: 0.90,
    ),
    const SkillModel(
      name: 'BLoC Pattern',
      category: SkillCategory.mobile,
      proficiency: 0.85,
    ),
    const SkillModel(
      name: 'GoRouter',
      category: SkillCategory.mobile,
      proficiency: 0.87,
    ),
    const SkillModel(
      name: 'Flutter Animate',
      category: SkillCategory.mobile,
      proficiency: 0.84,
    ),
    const SkillModel(
      name: 'Clean Architecture',
      category: SkillCategory.mobile,
      proficiency: 0.88,
    ),
    const SkillModel(
      name: 'REST APIs',
      category: SkillCategory.mobile,
      proficiency: 0.90,
    ),
    const SkillModel(
      name: 'fpdart',
      category: SkillCategory.mobile,
      proficiency: 0.78,
    ),

    // Backend
    const SkillModel(
      name: 'Firebase',
      category: SkillCategory.backend,
      proficiency: 0.88,
    ),
    const SkillModel(
      name: 'Supabase',
      category: SkillCategory.backend,
      proficiency: 0.80,
    ),
    const SkillModel(
      name: 'Node.js / Express',
      category: SkillCategory.backend,
      proficiency: 0.76,
    ),
    const SkillModel(
      name: 'MySQL',
      category: SkillCategory.backend,
      proficiency: 0.74,
    ),
    const SkillModel(
      name: 'JWT Auth',
      category: SkillCategory.backend,
      proficiency: 0.80,
    ),
    const SkillModel(
      name: 'FCM Push Notif.',
      category: SkillCategory.backend,
      proficiency: 0.82,
    ),

    // Core / CS Foundations
    SkillModel(
      name: 'C++',
      category: SkillCategory.core,
      proficiency: 0.85,
    ),
    SkillModel(
      name: 'Data Structures & Algorithms',
      category: SkillCategory.core,
      proficiency: 0.85,
    ),
    SkillModel(
      name: 'Object-Oriented Design',
      category: SkillCategory.core,
      proficiency: 0.82,
    ),

    // Tools
    const SkillModel(
      name: 'Git / GitHub',
      category: SkillCategory.tools,
      proficiency: 0.90,
    ),
    const SkillModel(
      name: 'VS Code',
      category: SkillCategory.tools,
      proficiency: 0.92,
    ),
    const SkillModel(
      name: 'Android Studio',
      category: SkillCategory.tools,
      proficiency: 0.88,
    ),
    const SkillModel(
      name: 'Postman',
      category: SkillCategory.tools,
      proficiency: 0.82,
    ),
  ];

  // ── Projects ──────────────────────────────────────────────────
  // To add a new project: append a new ProjectModel to this list.
  static final List<ProjectModel> projects = [
    const ProjectModel(
      id: 'peblo',
      title: 'Peblo Story Buddy',
      description:
          'AI-powered storytelling & learning platform for children aged 3–10.',
      longDescription:
          'Peblo is an intelligent children\'s learning platform built with '
          'Flutter. Features include an AI-powered "Story Buddy" module '
          'with Pip the robot narrator, text-to-speech narration, '
          'comprehension quizzes, and dynamic story generation using LLMs. '
          'Architected with Clean Architecture, Riverpod 2.x sealed-class '
          'state machines, and fpdart for typed, functional error handling.',
      technologies: [
        'Flutter',
        'Dart',
        'Riverpod 2.x',
        'Text-to-Speech',
        'AI/LLM Integration',
        'Clean Architecture',
        'fpdart',
        'GoRouter',
      ],
      category: 'Mobile',
      isFeatured: true,
      accentColor: Color(0xFF8B5CF6),
      githubUrl: 'https://github.com/Somprakash04/Peblo-Story-Buddy',
    ),
    const ProjectModel(
      id: 'portfolio',
      title: 'Flutter Portfolio',
      description:
          'A production-grade Flutter Web portfolio with a custom design system.',
      longDescription:
          'This portfolio itself — built with Flutter Web using Clean '
          'Architecture, Riverpod, and GoRouter. Features a custom design '
          'system with Material 3, Google Fonts, dark/light theming, '
          'glassmorphism effects, scroll-based animations via Flutter '
          'Animate, and full responsiveness from mobile to 4K displays.',
      technologies: [
        'Flutter Web',
        'Riverpod',
        'GoRouter',
        'Flutter Animate',
        'Material 3',
        'Google Fonts',
      ],
      category: 'Web',
      isFeatured: false,
      accentColor: Color(0xFF10B981),
      githubUrl: 'https://github.com/Somprakash04/som_portfolio',
      liveUrl: 'https://your-portfolio.web.app',
    ),
    // ── Add more projects here ────────────────────────────────
  ];

  // ── Experience / Timeline ─────────────────────────────────────
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      title: 'Flutter Developer Intern',
      organization: 'Cognus Technology',
      startDate: 'Dec 2025',
      endDate: 'Apr 2026',
      description:
          'Developed and maintained Flutter mobile applications for clients. '
          'Implemented Clean Architecture patterns, integrated REST APIs and '
          'Firebase backend services, and resolved cross-platform issues '
          'across Android and iOS.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'BLoC'],
      type: ExperienceType.internship,
      isCurrent: false,
      url: 'https://cognustechnology.com',
    ),
    ExperienceModel(
      title: 'AI Storytelling Platform — Peblo',
      organization: 'Independent Project',
      startDate: 'Mar 2026',
      description:
          'Designing and building Story Buddy — an in-app Flutter module '
          'featuring Pip the robot narrator, TTS narration, comprehension '
          'quizzes, and AI-driven story generation. Implemented sealed-class '
          'state machines and fpdart for typed, functional error handling.',
      technologies: ['Flutter', 'Riverpod 2.x', 'fpdart', 'TTS', 'AI/LLM'],
      type: ExperienceType.project,
      isCurrent: true,
    ),
    ExperienceModel(
      title: 'B.Tech — Computer Science Engineering',
      organization: 'Geetanjali Institute of Technology Studies, Udaipur',
      startDate: 'Jul 2023',
      endDate: '2027',
      description:
          'Pursuing a Bachelor\'s degree in Computer Science Engineering with '
          'coursework in Data Structures, Algorithms, Operating Systems, '
          'Computer Networks, and Database Management Systems.',
      technologies: ['C++', 'Java', 'Python', 'SQL'],
      type: ExperienceType.education,
      isCurrent: true,
    ),
  ];

  // ── Achievements ──────────────────────────────────────────────
  static const List<AchievementModel> achievements = [
    AchievementModel(
      title: 'Flutter Development Bootcamp',
      issuer: 'Udemy — Dr. Angela Yu',
      date: '2024',
      type: AchievementType.certification,
      description:
          'Completed a 30+ hour comprehensive Flutter & Dart bootcamp covering '
          'widgets, state management, Firebase, and animations.',
      icon: Icons.school_outlined,
      color: Color(0xFF8B5CF6),
    ),
    AchievementModel(
      title: 'GitHub — Building in Public',
      issuer: 'GitHub',
      date: 'Ongoing',
      type: AchievementType.coding,
      description:
          'Maintains public GitHub repositories for personal projects with '
          'consistent commits as new features are developed and technologies '
          'are explored and learned',
      url: 'https://github.com/Somprakash04',
      icon: Icons.code_rounded,
      color: Color(0xFF06B6D4),
    ),
    AchievementModel(
      title: 'DSA Practice — LeetCode',
      issuer: 'LeetCode',
      date: 'Ongoing',
      type: AchievementType.coding,
      description:
          'Solved 150+ Data Structures & Algorithms problems in C++ '
          'across arrays trees, graphs, and dynamic programming, strengthening '
          'problem-solving skills through efficient, clean, and maintainable code.',
      url: 'https://leetcode.com/u/Somprakash/',
      icon: Icons.terminal_rounded,
      color: Color(0xFFFFA116), // LeetCode's signature orange
    ),
    // ── Add more achievements here ────────────────────────────
  ];

  // ── Social Links ──────────────────────────────────────────────
  static final List<SocialLinkModel> socialLinks = [
    SocialLinkModel(
      platform: 'GitHub',
      url: 'https://github.com/Somprakash04',
      icon: FontAwesomeIcons.github,
      username: 'Somprakash04',
      color: const Color(0xFF333333),
    ),
    SocialLinkModel(
      platform: 'LinkedIn',
      url: 'https://www.linkedin.com/in/somprakash-arun-b7683730a/',
      icon: FontAwesomeIcons.linkedin,
      username: 'Somprakash Arun',
      color: const Color(0xFF0A66C2),
    ),
    SocialLinkModel(
      platform: 'Twitter / X',
      url: 'https://twitter.com/your-handle',
      icon: FontAwesomeIcons.twitter,
      username: '@your-handle',
      color: const Color(0xFF1DA1F2),
    ),
    SocialLinkModel(
      platform: 'Email',
      url: 'mailto:somprakasharun@gmail.com',
      icon: FontAwesomeIcons.envelope,
      username: 'somprakasharun@gmail.com',
      color: AppColors.violet,
    ),
  ];
}
