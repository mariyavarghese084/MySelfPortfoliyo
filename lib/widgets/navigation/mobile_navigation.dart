import 'package:flutter/material.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../common/profile_image.dart';

class MobileNavigationDrawer extends StatelessWidget {
  final String activeSection;
  final ValueChanged<String>? onNavItemSelected;
  final VoidCallback? onToggleTheme;
  final bool isDark;

  const MobileNavigationDrawer({
    super.key,
    required this.activeSection,
    this.onNavItemSelected,
    this.onToggleTheme,
    required this.isDark,
  });

  static const List<Map<String, dynamic>> _menuItems = [
    {'title': 'Home', 'icon': Icons.home_rounded},
    {'title': 'About', 'icon': Icons.person_outline_rounded},
    {'title': 'Skills', 'icon': Icons.code_rounded},
    {'title': 'Experience', 'icon': Icons.work_outline_rounded},
    {'title': 'Projects', 'icon': Icons.folder_open_rounded},
    {'title': 'Education', 'icon': Icons.school_outlined},
    {'title': 'Contact', 'icon': Icons.mail_outline_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Drawer(
      child: Column(
        children: [
          // Header with Logo & Title
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightBackground,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                const ProfileImage(
                  size: 52,
                  showBorder: true,
                  showBadge: true,
                ),
                const SizedBox(width: AppSpacing.itemSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mariya Varghese',
                        style: AppTextStyles.cardTitle(isDark).copyWith(
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xsSpacing),
                      Text(
                        'Flutter Developer',
                        style: AppTextStyles.tag(isDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Menu List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.smallSpacing,
                vertical: AppSpacing.smallSpacing,
              ),
              children: _menuItems.map((item) {
                final String title = item['title'] as String;
                final IconData icon = item['icon'] as IconData;
                final isActive = activeSection.toLowerCase() == title.toLowerCase();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: ListTile(
                    leading: Icon(
                      icon,
                      color: isActive
                          ? primaryColor
                          : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                    ),
                    title: Text(
                      title,
                      style: AppTextStyles.navLink(isDark).copyWith(
                        color: isActive
                            ? primaryColor
                            : (isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary),
                        fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    selected: isActive,
                    selectedTileColor: primaryColor.withValues(alpha: 0.12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      onNavItemSelected?.call(title);
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(height: 1),

          // Footer Theme Toggle
          Padding(
            padding: const EdgeInsets.all(AppSpacing.itemSpacing),
            child: ListTile(
              leading: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: isDark ? const Color(0xFFFACC15) : primaryColor,
              ),
              title: Text(
                isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                style: AppTextStyles.body(isDark).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                Navigator.pop(context);
                onToggleTheme?.call();
              },
            ),
          ),
        ],
      ),
    );
  }
}
