import 'package:flutter/material.dart';
import '../../models/skill.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

class SkillCard extends StatefulWidget {
  final Skill skill;

  const SkillCard({
    super.key,
    required this.skill,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    final scale = (disableAnimations || !_isHovered) ? 1.0 : 1.025;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: scale,
        duration: AppDurations.fast,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.smallSpacing * 1.2,
            vertical: AppSpacing.smallSpacing,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? (_isHovered ? AppColors.darkSurface : AppColors.darkCard)
                : (_isHovered ? AppColors.lightSurface : AppColors.lightCard),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? primaryColor.withValues(alpha: 0.6)
                  : (widget.skill.isPrimary
                      ? primaryColor.withValues(alpha: 0.25)
                      : (isDark
                          ? AppColors.darkCardBorder
                          : AppColors.lightCardBorder)),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? primaryColor.withValues(alpha: 0.15)
                    : Colors.black.withValues(alpha: isDark ? 0.15 : 0.04),
                blurRadius: _isHovered ? 12 : 4,
                offset: Offset(0, _isHovered ? 4 : 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: _isHovered ? 0.18 : 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.skill.icon ?? Icons.code_rounded,
                  size: 18,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.skill.name,
                  style: AppTextStyles.body(isDark).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.skill.isPrimary) ...[
                const SizedBox(width: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
