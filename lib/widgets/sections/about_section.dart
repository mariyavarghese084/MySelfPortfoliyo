import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../common/responsive_layout.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isMobile ? 16.0 : 24.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32.0 : 48.0,
        horizontal: isMobile ? AppSpacing.itemSpacing : AppSpacing.elementSpacing * 1.2,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.5)
            : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'About Me',
            subtitle: 'Professional Introduction',
          ),
          const SizedBox(height: AppSpacing.sectionSpacing),
          if (isMobile) ...[
            _buildIntroductionText(context, isDark, primaryColor),
            const SizedBox(height: AppSpacing.sectionSpacing),
            _buildDeveloperCards(context, isDark, primaryColor, isMobile: true),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Professional Introduction
                Expanded(
                  flex: 5,
                  child: _buildIntroductionText(context, isDark, primaryColor),
                ),
                const SizedBox(width: AppSpacing.sectionSpacing * 0.8),
                // Right Column: Developer Statistics / Domain Cards
                Expanded(
                  flex: 6,
                  child: _buildDeveloperCards(context, isDark, primaryColor, isMobile: false),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIntroductionText(
      BuildContext context, bool isDark, Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Passionate Flutter & FlutterFlow developer building responsive, performant, and secure cross-platform solutions.',
          style: AppTextStyles.cardTitle(isDark).copyWith(
            fontSize: 20,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.itemSpacing),
        Text(
          'I am a Flutter Developer with experience building scalable cross-platform applications across mobile and web environments. Holding a Master of Computer Application (MCA) degree and current experience at MAFIL, I specialize in building user-friendly frontends, integrating RESTful APIs, and implementing SQL-backed data systems.',
          style: AppTextStyles.body(isDark).copyWith(height: 1.6),
        ),
        const SizedBox(height: AppSpacing.itemSpacing),
        Text(
          'I thrive in agile team environments, collaborating closely with designers and backend engineers to turn functional requirements into clean, maintainable, and production-ready applications.',
          style: AppTextStyles.body(isDark).copyWith(height: 1.6),
        ),
        const SizedBox(height: AppSpacing.elementSpacing),
        // Concise Resume Feature Chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _FeatureChip(label: 'Flutter Development'),
            _FeatureChip(label: 'FlutterFlow'),
            _FeatureChip(label: 'RESTful APIs'),
            _FeatureChip(label: 'SQL Databases'),
            _FeatureChip(label: 'Cross-Platform'),
            _FeatureChip(label: 'Team Collaboration'),
          ],
        ),
      ],
    );
  }

  Widget _buildDeveloperCards(
      BuildContext context, bool isDark, Color primaryColor,
      {required bool isMobile}) {
    final cardsData = [
      {
        'title': 'Flutter Development',
        'subtitle': 'Custom UI & State Management',
        'description':
            'Crafting performant Dart & Flutter application architectures with clean UI components.',
        'icon': Icons.code_rounded,
      },
      {
        'title': 'Cross Platform Apps',
        'subtitle': 'Mobile & Web Solutions',
        'description':
            'Building unified cross-platform mobile and web applications using Flutter & FlutterFlow.',
        'icon': Icons.devices_rounded,
      },
      {
        'title': 'REST API Integration',
        'subtitle': 'Backend Services & Data Fetching',
        'description':
            'Integrating robust HTTP services, JSON data parsing, and secure API endpoints.',
        'icon': Icons.api_rounded,
      },
      {
        'title': 'SQL & Backend Integration',
        'subtitle': 'Database Storage & Firebase',
        'description':
            'Managing relational SQL data structures, MySQL databases, and real-time Firebase sync.',
        'icon': Icons.storage_rounded,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final useSingleColumn = isMobile || constraints.maxWidth < 480;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: useSingleColumn ? 1 : 2,
            mainAxisSpacing: AppSpacing.itemSpacing,
            crossAxisSpacing: AppSpacing.itemSpacing,
            mainAxisExtent: useSingleColumn ? 160 : 185,
          ),
          itemCount: cardsData.length,
          itemBuilder: (context, index) {
            final card = cardsData[index];
            return _DevStatCard(
              title: card['title'] as String,
              subtitle: card['subtitle'] as String,
              description: card['description'] as String,
              icon: card['icon'] as IconData,
              isDark: isDark,
              primaryColor: primaryColor,
            );
          },
        );
      },
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final String label;

  const _FeatureChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 14,
            color: primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DevStatCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final bool isDark;
  final Color primaryColor;

  const _DevStatCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  State<_DevStatCard> createState() => _DevStatCardState();
}

class _DevStatCardState extends State<_DevStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.all(AppSpacing.itemSpacing),
        decoration: BoxDecoration(
          color: widget.isDark
              ? (_isHovered ? AppColors.darkSurface : AppColors.darkCard)
              : (_isHovered ? AppColors.lightSurface : AppColors.lightCard),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? widget.primaryColor.withValues(alpha: 0.5)
                : (widget.isDark
                    ? AppColors.darkCardBorder
                    : AppColors.lightCardBorder),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.primaryColor.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: widget.isDark ? 0.2 : 0.05),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 6 : 2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.primaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 20,
                      color: widget.primaryColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: _isHovered
                        ? widget.primaryColor
                        : (widget.isDark
                            ? AppColors.darkTextMuted
                            : AppColors.lightTextMuted),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: AppTextStyles.cardTitle(widget.isDark).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: widget.primaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                widget.description,
                style: AppTextStyles.bodySmall(widget.isDark).copyWith(
                  fontSize: 12,
                  height: 1.35,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
