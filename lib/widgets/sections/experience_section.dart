import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../common/experience_card.dart';
import '../common/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveLayout.isMobile(context);
    final primaryColor = Theme.of(context).colorScheme.primary;

    final experiences = PortfolioData.experiences;
    final double nodeSize = isMobile ? 36.0 : 42.0;

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
            title: 'Work Experience',
            subtitle: 'Professional Timeline',
          ),
          const SizedBox(height: AppSpacing.sectionSpacing * 0.8),

          // Vertical Timeline Stack
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final exp = experiences[index];
              final isLast = index == experiences.length - 1;

              return Stack(
                children: [
                  // Connecting Vertical Line
                  if (!isLast)
                    Positioned(
                      left: nodeSize / 2 - 1,
                      top: nodeSize,
                      bottom: 0,
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              primaryColor,
                              primaryColor.withValues(alpha: 0.2),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Node and Card Content
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline Node Icon Circle
                      Container(
                        width: nodeSize,
                        height: nodeSize,
                        decoration: BoxDecoration(
                          color: exp.isCurrent
                              ? primaryColor
                              : (isDark
                                  ? AppColors.darkSurface
                                  : AppColors.lightSurface),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(
                                  alpha: exp.isCurrent ? 0.35 : 0.15),
                              blurRadius: exp.isCurrent ? 12 : 6,
                              spreadRadius: exp.isCurrent ? 2 : 0,
                            ),
                          ],
                        ),
                        child: Icon(
                          exp.isCurrent
                              ? Icons.work_rounded
                              : Icons.work_outline_rounded,
                          size: isMobile ? 18 : 20,
                          color: exp.isCurrent ? Colors.white : primaryColor,
                        ),
                      ),
                      SizedBox(width: isMobile ? 12 : 20),

                      // Experience Card
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: AppSpacing.sectionSpacing * 0.6),
                          child: ExperienceCard(experience: exp),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
