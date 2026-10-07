import 'package:flutter/material.dart';

class AppColors {
  // Primary Accent Color (Warm Coral / Crimson Accent)
  static const Color primary = Color(0xFFE85D4A);
  static const Color primaryHover = Color(0xFFD04735);

  // Dark Theme Palette (Neutral Obsidian / Dark Slate)
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkCardBorder = Color(0xFF334155);

  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // Light Theme Palette (Requested Custom Color System)
  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardBorder = Color(0xFFE6E8EE);

  static const Color lightTextPrimary = Color(0xFF111318);
  static const Color lightTextSecondary = Color(0xFF626775);
  static const Color lightTextMuted = Color(0xFF8A90A0);

  // Card Shadow (Very subtle)
  static List<BoxShadow> lightCardShadow = [
    BoxShadow(
      color: const Color(0xFF111318).withValues(alpha: 0.04),
      blurRadius: 12,
      spreadRadius: 0,
      offset: const Offset(0, 2),
    ),
  ];
}
