import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import 'responsive_layout.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final String? projectNumber;

  const ProjectCard({
    super.key,
    required this.project,
    this.projectNumber,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final primaryColor = Theme.of(context).colorScheme.primary;

    final projectTheme = _getProjectTheme(widget.project.title);

    // Disable hover scale/translation on mobile devices or if animations disabled
    final isHoverActive = !isMobile && !disableAnimations && _isHovered;
    final scale = isHoverActive ? 1.02 : 1.0;
    final translateY = isHoverActive ? -4.0 : 0.0;
    final arrowTranslateX = isHoverActive ? 4.0 : 0.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, translateY, 0),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? primaryColor.withValues(alpha: 0.6)
                : (isDark
                    ? AppColors.darkCardBorder
                    : AppColors.lightCardBorder),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? primaryColor.withValues(alpha: _isHovered ? 0.18 : 0.06)
                  : const Color(0xFF111318)
                      .withValues(alpha: _isHovered ? 0.08 : 0.04),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 6 : 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image / Decorative Header Banner with 1.02x Zoom on Hover
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Zoomable Banner Image Container
                    Positioned.fill(
                      child: AnimatedScale(
                        scale: scale,
                        duration: AppDurations.fast,
                        curve: Curves.easeOutCubic,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: projectTheme.gradientColors,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: -10,
                                bottom: -10,
                                child: Icon(
                                  projectTheme.icon,
                                  size: 100,
                                  color: Colors.white.withValues(alpha: 0.15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Top Banner Badges (Project Number & VAPT Chip)
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.itemSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Project Number Chip (e.g. 01)
                          if (widget.projectNumber != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.45),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                widget.projectNumber!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),

                          // VAPT / Highlight Badge
                          if (widget.project.highlights != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.verified_rounded,
                                    size: 12,
                                    color: Color(0xFF10B981),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'VAPT Passed',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content Area (Flexible & Scrollable if text wraps)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.itemSpacing),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Title
                        Text(
                          widget.project.title,
                          style: AppTextStyles.cardTitle(isDark).copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xsSpacing),

                        // Short Description
                        Text(
                          widget.project.description,
                          style: AppTextStyles.body(isDark).copyWith(
                            fontSize: 13,
                            height: 1.45,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.itemSpacing * 0.75),

                        // Technology Chips
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: widget.project.technologies.map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: primaryColor.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                tech,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Footer Action Area: View Details Action with Translating Arrow
              InkWell(
                onTap: () => _showProjectDetailsModal(context),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.itemSpacing,
                    0,
                    AppSpacing.itemSpacing,
                    AppSpacing.itemSpacing,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? primaryColor.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _isHovered
                            ? primaryColor
                            : primaryColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'View Case Study',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        AnimatedContainer(
                          duration: AppDurations.fast,
                          curve: Curves.easeOutCubic,
                          transform:
                              Matrix4.translationValues(arrowTranslateX, 0, 0),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProjectDetailsModal(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final projectTheme = _getProjectTheme(widget.project.title);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor:
              isDark ? AppColors.darkSurface : AppColors.lightSurface,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 550),
            padding: const EdgeInsets.all(AppSpacing.elementSpacing * 1.2),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dialog Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: projectTheme.gradientColors,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                projectTheme.icon,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                widget.project.title,
                                style: AppTextStyles.cardTitle(isDark).copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Description
                  Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.project.description,
                    style: AppTextStyles.body(isDark).copyWith(
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.elementSpacing),

                  // Highlight Banner (if any, e.g. VAPT)
                  if (widget.project.highlights != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF10B981).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF10B981),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.project.highlights!,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.elementSpacing),
                  ],

                  // Features List (if available)
                  if (widget.project.features.isNotEmpty) ...[
                    Text(
                      'Key Features & Capabilities',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...widget.project.features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature,
                                style: AppTextStyles.body(isDark).copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.elementSpacing),
                  ],

                  // Technologies
                  Text(
                    'Technologies Used',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.technologies.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          tech,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.elementSpacing),

                  // Modal Close Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _ProjectTheme _getProjectTheme(String title) {
    if (title.contains('Admin')) {
      return _ProjectTheme(
        gradientColors: const [Color(0xFF4F46E5), Color(0xFF06B6D4)],
        icon: Icons.admin_panel_settings_rounded,
      );
    } else if (title.contains('Payments')) {
      return _ProjectTheme(
        gradientColors: const [Color(0xFF059669), Color(0xFF10B981)],
        icon: Icons.account_balance_wallet_rounded,
      );
    } else if (title.contains('KiddoMate')) {
      return _ProjectTheme(
        gradientColors: const [Color(0xFF8B5CF6), Color(0xFFEC4899)],
        icon: Icons.child_care_rounded,
      );
    } else {
      return _ProjectTheme(
        gradientColors: const [Color(0xFFD97706), Color(0xFFF59E0B)],
        icon: Icons.fact_check_rounded,
      );
    }
  }
}

class _ProjectTheme {
  final List<Color> gradientColors;
  final IconData icon;

  const _ProjectTheme({
    required this.gradientColors,
    required this.icon,
  });
}
