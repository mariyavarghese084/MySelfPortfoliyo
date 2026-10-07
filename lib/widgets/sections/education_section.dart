import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../common/education_card.dart';
import '../common/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

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
            title: 'Education',
            subtitle: 'Academic Background',
          ),
          const SizedBox(height: AppSpacing.sectionSpacing * 0.8),

          // Education Cards
          ...PortfolioData.educationList.map(
            (edu) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.itemSpacing),
              child: EducationCard(education: edu),
            ),
          ),

          const SizedBox(height: AppSpacing.itemSpacing * 1.5),

          // Languages Section
          Text(
            'Languages Spoken',
            style: AppTextStyles.cardTitle(isDark).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.smallSpacing * 1.5),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: PortfolioData.languagesSpoken.map((lang) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkCardBorder
                        : AppColors.lightCardBorder,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.translate_rounded,
                      size: 14,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      lang,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
