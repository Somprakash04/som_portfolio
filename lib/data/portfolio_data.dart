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
  static const String name = 'SP';
  static const String fullName = 'SP Arun'; // ← Replace with your full name
  static const String title = 'Flutter Developer';
  static const String location = 'Udaipur, Rajasthan 🇮🇳';
  static const String email = 'your.email@example.com';
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
    "I'm a Computer Science Engineering student (graduating 2027) and Flutter developer with production-level experience building scalable mobile applications. My journey started with a passion for beautiful, high-performance apps — and evolved into deep expertise across the Flutter ecosystem.",
    "Currently interning at Cognus Technology, Udaipur, I've shipped full-stack systems that integrate Flutter frontends with Node.js backends, Firebase, hardware interfaces (RFID + ESP32), and AI-powered features. My approach: Clean Architecture, typed error handling with fpdart, and sealed-class state machines in Riverpod 2.x.",
    "I'm actively building toward roles at AI-first companies — bridging Flutter mobile development with LLM integration and on-device ML.",
  ];

  static const List<String> highlights = [
    'Clean Architecture & SOLID principles',
    'Riverpod 2.x & BLoC state management',
    'AI/LLM-powered mobile features',
    'Full-stack: Firebase, Supabase, Node.js',
    'Delivered 50+ Dart files in production',
    'CSE Student — graduating 2027',
  ];

  static const Map<String, String> stats = {
    'Projects': '10+',
    'Dart Files': '200+',
    'Internship': '1+ yr',
    'Coffee ☕': '∞',
  };

  // ── Skills ────────────────────────────────────────────────────
  static const List<SkillModel> skills = [
    // Mobile
    SkillModel(
      name: 'Flutter / Dart',
      category: SkillCategory.mobile,
      proficiency: 0.95,
    ),
    SkillModel(
      name: 'Riverpod 2.x',
      category: SkillCategory.mobile,
      proficiency: 0.90,
    ),
    SkillModel(
      name: 'BLoC Pattern',
      category: SkillCategory.mobile,
      proficiency: 0.85,
    ),
    SkillModel(
      name: 'GoRouter',
      category: SkillCategory.mobile,
      proficiency: 0.87,
    ),
    SkillModel(
      name: 'Flutter Animate',
      category: SkillCategory.mobile,
      proficiency: 0.84,
    ),
    SkillModel(
      name: 'Clean Architecture',
      category: SkillCategory.mobile,
      proficiency: 0.88,
    ),
    SkillModel(
      name: 'REST APIs',
      category: SkillCategory.mobile,
      proficiency: 0.90,
    ),
    SkillModel(
      name: 'fpdart',
      category: SkillCategory.mobile,
      proficiency: 0.78,
    ),

    // Backend
    SkillModel(
      name: 'Firebase',
      category: SkillCategory.backend,
      proficiency: 0.88,
    ),
    SkillModel(
      name: 'Supabase',
      category: SkillCategory.backend,
      proficiency: 0.80,
    ),
    SkillModel(
      name: 'Node.js / Express',
      category: SkillCategory.backend,
      proficiency: 0.76,
    ),
    SkillModel(
      name: 'MySQL',
      category: SkillCategory.backend,
      proficiency: 0.74,
    ),
    SkillModel(
      name: 'JWT Auth',
      category: SkillCategory.backend,
      proficiency: 0.80,
    ),
    SkillModel(
      name: 'FCM Push Notif.',
      category: SkillCategory.backend,
      proficiency: 0.82,
    ),

    // Tools
    SkillModel(
      name: 'Git / GitHub',
      category: SkillCategory.tools,
      proficiency: 0.90,
    ),
    SkillModel(
      name: 'Android Studio',
      category: SkillCategory.tools,
      proficiency: 0.88,
    ),
    SkillModel(name: 'Figma', category: SkillCategory.tools, proficiency: 0.70),
    SkillModel(
      name: 'ESP32 / Arduino',
      category: SkillCategory.tools,
      proficiency: 0.65,
    ),
    SkillModel(
      name: 'VS Code',
      category: SkillCategory.tools,
      proficiency: 0.92,
    ),
    SkillModel(
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
      title: 'Peblo',
      description:
          'AI-powered storytelling & learning platform for children aged 3–10.',
      longDescription:
          'Peblo is an intelligent children\'s platform built with Flutter. Features include an AI-powered "Story Buddy" module with Pip the robot narrator, text-to-speech narration, comprehension quizzes, and dynamic story generation. Built with Clean Architecture, Riverpod 2.x sealed-class state machines, and fpdart for typed error handling.',
      technologies: [
        'Flutter',
        'Dart',
        'Riverpod 2.x',
        'TTS',
        'AI/LLM',
        'Clean Architecture',
        'fpdart',
        'GoRouter',
      ],
      category: 'Mobile',
      isFeatured: true,
      accentColor: Color(0xFF8B5CF6),
      githubUrl: 'https://github.com/your-username/peblo',
    ),
    const ProjectModel(
      id: 'eduguard',
      title: 'EduGuard',
      description:
          'Full production-scale School Security & Attendance Management System.',
      longDescription:
          'EduGuard is a comprehensive school management platform with RFID-based attendance. Built with Flutter (50+ Dart files), Node.js/Express REST API, MySQL, RFID RC522 + ESP32 hardware, JWT auth, FCM push notifications. Role-specific portals: Admin, Teacher, Parent, Student.',
      technologies: [
        'Flutter',
        'Node.js',
        'MySQL',
        'RFID',
        'ESP32',
        'JWT',
        'FCM',
        'REST API',
        'Firebase',
      ],
      category: 'Full-Stack',
      isFeatured: true,
      accentColor: Color(0xFF06B6D4),
      githubUrl: 'https://github.com/your-username/eduguard',
    ),
    const ProjectModel(
      id: 'portfolio',
      title: 'Flutter Portfolio',
      description:
          'This portfolio — production-ready Flutter Web with premium design system.',
      longDescription:
          'A production-ready Flutter Web portfolio built with Clean Architecture, Riverpod, GoRouter, Flutter Animate, Google Fonts, Material 3, dark/light themes, glassmorphism, and full responsiveness across mobile → 4K.',
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
      githubUrl: 'https://github.com/your-username/portfolio',
      liveUrl: 'https://your-portfolio.web.app',
    ),
    // ── Add more projects here ────────────────────────────────
  ];

  // ── Experience / Timeline ─────────────────────────────────────
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      title: 'Flutter Developer Intern',
      organization: 'Cognus Technology',
      startDate: 'Jan 2024',
      description:
          'Developing and maintaining Flutter mobile applications for clients.'
          ' Contributed Clean Architecture patterns, integrated REST APIs '
          'and Firebase backend services, and debugged complex platform'
          ' issues across Android and iOS.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'BLoC'],
      type: ExperienceType.internship,
      isCurrent: true,
      url: 'https://cognustechnology.com',
    ),
    ExperienceModel(
      title: 'Full-Stack Developer — EduGuard',
      organization: 'Independent Project',
      startDate: 'Aug 2023',
      endDate: 'Dec 2023',
      description:
          'Architected and delivered a complete school security system: Flutter multi-portal app (50+ Dart files), Node.js/Express REST API, MySQL database, RFID hardware integration (RC522 + ESP32), JWT auth, and FCM push notifications.',
      technologies: ['Flutter', 'Node.js', 'MySQL', 'ESP32', 'JWT', 'FCM'],
      type: ExperienceType.project,
    ),
    ExperienceModel(
      title: 'AI Storytelling Platform — Peblo',
      organization: 'Independent Project',
      startDate: 'Feb 2024',
      description:
          'Designed and built Story Buddy — an in-app Flutter module with Pip the robot narrator, TTS narration, comprehension quizzes, and AI story generation. Implemented sealed-class state machines and fpdart typed error handling.',
      technologies: ['Flutter', 'Riverpod 2.x', 'fpdart', 'TTS', 'AI/LLM'],
      type: ExperienceType.project,
      isCurrent: true,
    ),
    ExperienceModel(
      title: 'B.Tech — Computer Science Engineering',
      organization: 'Your University, Udaipur',
      startDate: '2023',
      endDate: '2027',
      description:
          'Pursuing a Bachelor\'s degree in Computer Science Engineering. Coursework: Data Structures, Algorithms, OS, Networks, Database Management Systems.',
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
      date: '2023',
      type: AchievementType.certification,
      description:
          'Completed the 30+ hour complete Flutter & Dart bootcamp covering widgets, state, Firebase, and animations.',
      icon: Icons.school_outlined,
      color: Color(0xFF8B5CF6),
    ),
    AchievementModel(
      title: 'GitHub — Open Source Contributor',
      issuer: 'GitHub',
      date: 'Active',
      type: AchievementType.coding,
      description:
          'Active open-source contributor with consistent commit streaks on EduGuard and Peblo projects.',
      url: 'https://github.com/your-username',
      icon: Icons.code_rounded,
      color: Color(0xFF06B6D4),
    ),
    AchievementModel(
      title: 'LinkedIn — Flutter Content Creator',
      issuer: 'LinkedIn',
      date: '2024',
      type: AchievementType.recognition,
      description:
          'Recognised for consistent Flutter and mobile development content creation, growing a technical audience.',
      url: 'https://linkedin.com/in/your-profile',
      icon: Icons.workspace_premium_outlined,
      color: Color(0xFF0A66C2),
    ),
    AchievementModel(
      title: 'Hardware Integration — RFID + ESP32',
      issuer: 'EduGuard Project',
      date: '2023',
      type: AchievementType.award,
      description:
          'Delivered a complete IoT attendance system bridging Flutter mobile ↔ ESP32 hardware via REST API.',
      icon: Icons.memory_outlined,
      color: Color(0xFF10B981),
    ),
    // ── Add more achievements here ────────────────────────────
  ];

  // ── Social Links ──────────────────────────────────────────────
  static final List<SocialLinkModel> socialLinks = [
    SocialLinkModel(
      platform: 'GitHub',
      url: 'https://github.com/your-username',
      // icon: FontAwesomeIcons.github,
      icon: FontAwesomeIcons.github,
      username: '@your-username',
      color: const Color(0xFF333333),
    ),
    SocialLinkModel(
      platform: 'LinkedIn',
      url: 'https://linkedin.com/in/your-profile',
      icon: FontAwesomeIcons.linkedin,
      username: 'your-name',
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
      url: 'mailto:your.email@example.com',
      icon: FontAwesomeIcons.envelope,
      username: 'your.email@example.com',
      color: AppColors.violet,
    ),
  ];
}
