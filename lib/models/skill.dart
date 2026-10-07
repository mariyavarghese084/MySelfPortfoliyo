import 'package:flutter/material.dart';

enum SkillCategory {
  programming('Programming'),
  frameworksAndTools('Frameworks & Tools'),
  platforms('Platforms');

  final String displayName;
  const SkillCategory(this.displayName);
}

class Skill {
  final String name;
  final SkillCategory category;
  final IconData? icon;
  final String? subtitle;
  final bool isPrimary;

  const Skill({
    required this.name,
    required this.category,
    this.icon,
    this.subtitle,
    this.isPrimary = false,
  });
}
