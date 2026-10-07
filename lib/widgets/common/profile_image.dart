import 'package:flutter/material.dart';
import '../../data/portfolio_data.dart';
import '../../app/theme/app_colors.dart';

class ProfileImage extends StatelessWidget {
  final double size;
  final bool showBorder;
  final bool showBadge;
  final String? tooltip;

  const ProfileImage({
    super.key,
    this.size = 260.0,
    this.showBorder = true,
    this.showBadge = true,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    Widget avatarCore = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: showBorder
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor,
                  primaryColor.withValues(alpha: 0.4),
                  isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ],
              )
            : null,
        boxShadow: showBorder
            ? [
                BoxShadow(
                  color: primaryColor.withValues(alpha: isDark ? 0.3 : 0.2),
                  blurRadius: size * 0.12,
                  spreadRadius: size * 0.02,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      padding: showBorder ? EdgeInsets.all(size * 0.018) : EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          border: showBorder
              ? Border.all(
                  color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                  width: size * 0.015,
                )
              : null,
        ),
        child: ClipOval(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(
              PortfolioData.profileImage,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: primaryColor.withValues(alpha: 0.15),
                  alignment: Alignment.center,
                  child: Text(
                    'MV',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size * 0.3,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    if (!showBadge) {
      return tooltip != null ? Tooltip(message: tooltip!, child: avatarCore) : avatarCore;
    }

    final badgeSize = size * 0.14;

    return Stack(
      alignment: Alignment.center,
      children: [
        avatarCore,
        Positioned(
          bottom: size * 0.04,
          right: size * 0.04,
          child: Tooltip(
            message: 'Available for Opportunities',
            child: Container(
              padding: EdgeInsets.all(size * 0.025),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                width: badgeSize,
                height: badgeSize,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981), // Emerald active green
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
