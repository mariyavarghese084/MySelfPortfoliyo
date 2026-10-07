import 'package:flutter/material.dart';
import '../../data/portfolio_data.dart';
import '../../app/theme/app_colors.dart';

class EditorialPortrait extends StatelessWidget {
  final double width;
  final double height;
  final bool isMobile;

  const EditorialPortrait({
    super.key,
    this.width = 380,
    this.height = 460,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    final double portraitWidth = width;
    final double portraitHeight = height;

    return Center(
      child: SizedBox(
        width: portraitWidth + 30,
        height: portraitHeight + 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Primary Blurred Gradient Accent Shape (BEHIND image)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: portraitWidth * 0.95,
                height: portraitHeight * 0.95,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(120),
                    topRight: Radius.circular(40),
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(100),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withValues(alpha: isDark ? 0.35 : 0.14),
                      const Color(0xFF6366F1).withValues(alpha: isDark ? 0.25 : 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // 2. Soft Secondary Radial Glow (BEHIND image)
            Positioned(
              bottom: 10,
              left: 0,
              child: Container(
                width: portraitWidth * 0.65,
                height: portraitHeight * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  gradient: RadialGradient(
                    colors: [
                      primaryColor.withValues(alpha: isDark ? 0.25 : 0.10),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // 3. Editorial Portrait Container (NO circle, NO material card border)
            Positioned(
              left: 10,
              top: 15,
              child: Container(
                width: portraitWidth,
                height: portraitHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                      blurRadius: 36,
                      spreadRadius: 0,
                      offset: const Offset(0, 16),
                    ),
                    BoxShadow(
                      color: primaryColor.withValues(alpha: isDark ? 0.2 : 0.05),
                      blurRadius: 28,
                      spreadRadius: 0,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    PortfolioData.profileImage,
                    width: portraitWidth,
                    height: portraitHeight,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person_rounded,
                                size: 72,
                                color: primaryColor,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                PortfolioData.name,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // 4. Subtle Floating Status Chip (Bottom Left / Bottom Right)
            Positioned(
              bottom: 2,
              left: isMobile ? 20 : 25,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.darkSurface : Colors.white)
                      .withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981), // Emerald green active indicator
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Flutter & Dart Developer',
                      style: TextStyle(
                        fontSize: isMobile ? 11 : 12,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
