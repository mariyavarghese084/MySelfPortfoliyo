import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/portfolio_data.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border(
          top: BorderSide(
            color: isDark
                ? AppColors.darkCardBorder
                : AppColors.lightCardBorder,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sectionSpacing * 0.6,
        horizontal: AppSpacing.elementSpacing,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Name Title
          Text(
            PortfolioData.name,
            style: AppTextStyles.cardTitle(isDark).copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xsSpacing),

          // Subtitle / Title
          Text(
            PortfolioData.title,
            style: AppTextStyles.subtitle(isDark).copyWith(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.itemSpacing),

          // Tech Stack Bullet Row
          Text(
            'Flutter • Dart • Firebase • REST APIs • SQL',
            style: AppTextStyles.bodySmall(isDark).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.itemSpacing),

          // Social Links (GitHub | LinkedIn | Email)
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            children: [
              _buildFooterLink(
                label: 'GitHub',
                onTap: () => _launchUrl(PortfolioData.githubUrl),
                isDark: isDark,
                primaryColor: primaryColor,
              ),
              _buildDivider(isDark),
              _buildFooterLink(
                label: 'LinkedIn',
                onTap: () => _launchUrl(PortfolioData.linkedinUrl),
                isDark: isDark,
                primaryColor: primaryColor,
              ),
              _buildDivider(isDark),
              _buildFooterLink(
                label: 'Email',
                onTap: () => _launchUrl('mailto:${PortfolioData.email}'),
                isDark: isDark,
                primaryColor: primaryColor,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.itemSpacing * 1.2),

          // Copyright
          Text(
            '© ${DateTime.now().year} ${PortfolioData.name}',
            style: AppTextStyles.bodySmall(isDark).copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink({
    required String label,
    required VoidCallback onTap,
    required bool isDark,
    required Color primaryColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Text(
      '|',
      style: TextStyle(
        fontSize: 13,
        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
      ),
    );
  }
}
