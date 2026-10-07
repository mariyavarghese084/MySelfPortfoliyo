import 'package:flutter/material.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_colors.dart';
import '../common/profile_image.dart';

class DesktopNavigation extends StatelessWidget {
  final String activeSection;
  final ValueChanged<String>? onNavItemSelected;
  final VoidCallback? onToggleTheme;
  final bool isDark;

  const DesktopNavigation({
    super.key,
    required this.activeSection,
    this.onNavItemSelected,
    this.onToggleTheme,
    required this.isDark,
  });

  static const List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Education',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkBackground.withValues(alpha: 0.9)
            : AppColors.lightBackground.withValues(alpha: 0.9),
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.elementSpacing * 1.5,
        vertical: AppSpacing.itemSpacing,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo / Name on Left
              InkWell(
                onTap: () => onNavItemSelected?.call('Home'),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ProfileImage(
                        size: 36,
                        showBorder: true,
                        showBadge: false,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Mariya Varghese',
                        style: AppTextStyles.cardTitle(isDark).copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Nav items + Theme toggle on Right
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...navItems.map((item) => _buildNavItem(context, item)),
                      const SizedBox(width: AppSpacing.smallSpacing),
                      Container(
                        height: 24,
                        width: 1,
                        color: isDark
                            ? AppColors.darkCardBorder
                            : AppColors.lightCardBorder,
                      ),
                      const SizedBox(width: AppSpacing.smallSpacing),
                      Tooltip(
                        message: isDark
                            ? 'Switch to Light Mode'
                            : 'Switch to Dark Mode',
                        child: IconButton(
                          icon: AnimatedSwitcher(
                            duration: AppDurations.fast,
                            child: Icon(
                              isDark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              key: ValueKey(isDark),
                              color: isDark
                                  ? const Color(0xFFFACC15)
                                  : primaryColor,
                            ),
                          ),
                          onPressed: onToggleTheme,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title) {
    final isActive = activeSection.toLowerCase() == title.toLowerCase();
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        decoration: BoxDecoration(
          color: isActive
              ? primaryColor.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () => onNavItemSelected?.call(title),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            title,
            style: AppTextStyles.navLink(isDark).copyWith(
              color: isActive
                  ? primaryColor
                  : (isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary),
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
