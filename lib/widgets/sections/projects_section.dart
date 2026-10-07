import 'package:flutter/material.dart';
import '../common/section_title.dart';
import '../common/project_card.dart';
import '../common/responsive_layout.dart';
import '../common/download_apk_button.dart';
import '../../data/portfolio_data.dart';
import '../../app/theme/app_spacing.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    // Desktop: 3 columns, Tablet: 2 columns, Mobile: 1 column
    final int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    final projects = PortfolioData.projects;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32.0 : 56.0,
        horizontal: AppSpacing.elementSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Featured Projects',
            subtitle: 'Portfolio Highlights',
          ),
          const SizedBox(height: AppSpacing.sectionSpacing * 0.6),

          const DownloadApkButton(
            variant: DownloadApkButtonVariant.bannerCallout,
          ),
          const SizedBox(height: AppSpacing.sectionSpacing * 0.6),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: AppSpacing.elementSpacing,
              crossAxisSpacing: AppSpacing.elementSpacing,
              mainAxisExtent: 395,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(
                project: projects[index],
                projectNumber: (index + 1).toString().padLeft(2, '0'),
              );
            },
          ),
        ],
      ),
    );
  }
}
