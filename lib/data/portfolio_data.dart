import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/experience.dart';

class PortfolioData {
  static const String name = 'Mariya Varghese';
  static const String title = 'Flutter Developer';
  static const String profileImage = 'assets/images/profile.jpg';
  static const String bio =
      'I am a Flutter Developer with experience building scalable cross-platform applications using Flutter and FlutterFlow.';
  static const String tagline =
      'Building real-world applications involving frontend development, REST API integration, SQL-backed systems, Firebase, and responsive cross-platform architectures.';

  static const String email = 'mariyavarghese084@gmail.com';
  static const String phone = '+91-7306815889';
  static const String githubUrl = 'https://github.com/mariyavarghese084';
  static const String linkedinUrl = 'https://www.linkedin.com/in/mariya-varghese-438320256';

  /// Configuration constant for the Android APK download URL.
  /// Replace this URL whenever updating the hosted APK build.
  static const String apkDownloadUrl =
      'https://github.com/mariyavarghese084/MySelfPortfoliyo/releases/download/v1.0.0/app-release.apk';


  static const List<String> languagesSpoken = [
    'English',
    'Hindi',
    'Malayalam',
  ];

  static const List<Skill> skills = [
    // Programming
    Skill(name: 'Dart', category: SkillCategory.programming, isPrimary: true, icon: Icons.code_rounded),
    Skill(name: 'C', category: SkillCategory.programming, icon: Icons.terminal_rounded),
    Skill(name: 'HTML', category: SkillCategory.programming, icon: Icons.html_rounded),
    Skill(name: 'CSS', category: SkillCategory.programming, icon: Icons.css_rounded),
    Skill(name: 'SQL', category: SkillCategory.programming, isPrimary: true, icon: Icons.data_array_rounded),

    // Frameworks & Tools
    Skill(name: 'Flutter', category: SkillCategory.frameworksAndTools, isPrimary: true, icon: Icons.widgets_rounded),
    Skill(name: 'FlutterFlow', category: SkillCategory.frameworksAndTools, isPrimary: true, icon: Icons.layers_rounded),
    Skill(name: 'Firebase', category: SkillCategory.frameworksAndTools, isPrimary: true, icon: Icons.local_fire_department_rounded),
    Skill(name: 'REST APIs', category: SkillCategory.frameworksAndTools, isPrimary: true, icon: Icons.api_rounded),
    Skill(name: 'Git', category: SkillCategory.frameworksAndTools, icon: Icons.fork_left_rounded),
    Skill(name: 'GitHub', category: SkillCategory.frameworksAndTools, icon: Icons.source_rounded),
    Skill(name: 'MySQL', category: SkillCategory.frameworksAndTools, isPrimary: true, icon: Icons.storage_rounded),
    Skill(name: 'Figma', category: SkillCategory.frameworksAndTools, icon: Icons.palette_rounded),

    // Platforms
    Skill(name: 'Android', category: SkillCategory.platforms, isPrimary: true, icon: Icons.android_rounded),
    Skill(name: 'iOS', category: SkillCategory.platforms, isPrimary: true, icon: Icons.apple_rounded),
    Skill(name: 'Web', category: SkillCategory.platforms, isPrimary: true, icon: Icons.language_rounded),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Admin Tracking App',
      description:
          'Location-based administrative tracking application used to verify user presence within assigned building premises.',
      technologies: ['Flutter', 'REST API'],
      features: [
        'GPS tracking',
        'Location validation',
        'Building management',
        'Reports',
        'Data tables',
        'Image uploads',
        'Role-based access',
      ],
      highlights:
          'Security: Successfully passed Vulnerability Assessment and Penetration Testing (VAPT).',
    ),
    Project(
      title: 'Payments Module',
      description:
          'A payments management module for a financial application supporting dual-tier operations.',
      technologies: ['Flutter', 'REST API', 'SQL Backend'],
      features: [
        'Branch-level payment operations',
        'Head-office payment operations',
        'Incoming payment tracking',
        'Outgoing payment tracking',
        'REST API integration',
        'SQL-backed transaction storage',
        'Administrative reporting',
      ],
    ),
    Project(
      title: 'KiddoMate App',
      description:
          'A mobile application developed to optimize the operations of Anganwadi centers and provide essential services to children and mothers across India.',
      technologies: ['Flutter', 'Dart', 'Firebase'],
      features: [
        'Anganwadi center operations optimization',
        'Essential service delivery for children & mothers',
        'Real-time data synchronization via Firebase',
        'Intuitive mobile workflow designed for accessibility',
      ],
    ),
    Project(
      title: 'Modern Audit Module',
      description:
          'An auditing module for a finance company specializing in gold trading.',
      technologies: ['FlutterFlow', 'REST API', 'SQL Backend'],
      features: [
        'Documentation',
        'Compliance tracking',
        'REST API integration',
        'Backend data handling',
        'Improved internal communication',
        'Improved operational accuracy',
      ],
    ),
  ];

  static const List<Experience> experiences = [
    Experience(
      role: 'Flutter & FlutterFlow Developer',
      company: 'MAFIL, Valapad, Thrissur',
      duration: 'July 2024 - Present',
      isCurrent: true,
      responsibilities: [
        'Developed and maintained cross-platform mobile applications using Flutter and FlutterFlow.',
        'Implemented backend functionality using SQL and REST APIs.',
        'Collaborated with designers and backend engineers to deliver performant applications.',
      ],
    ),
    Experience(
      role: 'Flutter Developer Intern',
      company: 'Freelance Projects & Academic',
      duration: 'May 2024',
      isCurrent: false,
      responsibilities: [
        'Designed and deployed Flutter applications with frontend and backend integrations.',
        'Worked in agile teams.',
        'Focused on clean code and collaborative development.',
      ],
    ),
  ];

  static const List<Education> educationList = [
    Education(
      degree: 'Master of Computer Application (MCA)',
      institution: 'MACFAST, MG University',
      duration: '2022 - 2024',
    ),
  ];
}
