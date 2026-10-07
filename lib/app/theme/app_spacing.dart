import 'package:flutter/material.dart';

class AppSpacing {
  // Page Padding
  static const EdgeInsets pagePaddingDesktop =
      EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0);
  static const EdgeInsets pagePaddingTablet =
      EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0);
  static const EdgeInsets pagePaddingMobile =
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);

  // Section & Element Spacing
  static const double sectionSpacing = 64.0;
  static const double sectionSpacingMobile = 40.0;
  static const double elementSpacing = 20.0;
  static const double itemSpacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double xsSpacing = 4.0;

  // Max Content Width
  static const double maxContentWidth = 1200.0;

  // Radii
  static const double cardRadius = 16.0;
  static const double buttonRadius = 12.0;
  static const double chipRadius = 8.0;

  // BorderRadius Helpers
  static final BorderRadius cardBorderRadius = BorderRadius.circular(cardRadius);
  static final BorderRadius buttonBorderRadius = BorderRadius.circular(buttonRadius);
  static final BorderRadius chipBorderRadius = BorderRadius.circular(chipRadius);
}

class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 600);
}
