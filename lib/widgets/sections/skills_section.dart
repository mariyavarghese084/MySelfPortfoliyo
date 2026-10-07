import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../common/skill_card.dart';
import '../common/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../models/skill.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Desktop: 4 cols, Tablet: 3 cols, Mobile: 2 cols
    final int crossAxisCount = isDesktop ? 4 : (isTablet ? 3 : 2);

    // Group skills by category
    final Map<SkillCategory, List<Skill>> categorizedSkills = {
      SkillCategory.programming: [],
      SkillCategory.frameworksAndTools: [],
      SkillCategory.platforms: [],
    };

    for (final skill in PortfolioData.skills) {
      categorizedSkills[skill.category]?.add(skill);
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32.0 : 56.0,
        horizontal: AppSpacing.elementSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Technical Skills',
            subtitle: 'Capabilities & Technologies',
          ),
          const SizedBox(height: AppSpacing.sectionSpacing * 0.8),

          ...SkillCategory.values.map((category) {
            final categorySkills = categorizedSkills[category] ?? [];
            if (categorySkills.isEmpty) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sectionSpacing * 0.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          _getCategoryIcon(category),
                          size: 18,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.itemSpacing * 0.75),
                      Expanded(
                        child: Text(
                          category.displayName,
                          style: AppTextStyles.cardTitle(isDark).copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkCardBorder
                              : AppColors.lightCardBorder,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${categorySkills.length}',
                          style: AppTextStyles.bodySmall(isDark).copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.itemSpacing),

                  // Responsive Skill Grid (Desktop: 4, Tablet: 3, Mobile: 2)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: AppSpacing.itemSpacing * 0.75,
                      crossAxisSpacing: AppSpacing.itemSpacing * 0.75,
                      mainAxisExtent: 56,
                    ),
                    itemCount: categorySkills.length,
                    itemBuilder: (context, index) {
                      return SkillCard(skill: categorySkills[index]);
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(SkillCategory category) {
    switch (category) {
      case SkillCategory.programming:
        return Icons.terminal_rounded;
      case SkillCategory.frameworksAndTools:
        return Icons.build_circle_outlined;
      case SkillCategory.platforms:
        return Icons.devices_rounded;
    }
  }
}
