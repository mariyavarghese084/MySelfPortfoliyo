import 'package:flutter/material.dart';
import '../../utils/apk_helper.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

enum DownloadApkButtonVariant {
  outlined,
  elevated,
  bannerCallout,
}

class DownloadApkButton extends StatefulWidget {
  final DownloadApkButtonVariant variant;
  final String label;
  final bool forceShow;
  final VoidCallback? onDownloaded;

  const DownloadApkButton({
    super.key,
    this.variant = DownloadApkButtonVariant.outlined,
    this.label = 'Download Android App',
    this.forceShow = false,
    this.onDownloaded,
  });

  @override
  State<DownloadApkButton> createState() => _DownloadApkButtonState();
}

class _DownloadApkButtonState extends State<DownloadApkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Hide button on Android platform unless forceShow is true
    if (!ApkHelper.shouldShowDownloadButton && !widget.forceShow) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    if (widget.variant == DownloadApkButtonVariant.bannerCallout) {
      return _buildBannerCallout(context, isDark, primaryColor);
    }

    final isElevated = widget.variant == DownloadApkButtonVariant.elevated;

    final ButtonStyle style = isElevated
        ? ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: _isHovered ? 6 : 3,
            shadowColor: primaryColor.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          )
        : OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            backgroundColor: _isHovered
                ? primaryColor.withValues(alpha: 0.12)
                : Colors.transparent,
            foregroundColor: primaryColor,
            side: BorderSide(
              color: _isHovered
                  ? primaryColor
                  : primaryColor.withValues(alpha: 0.6),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );

    final Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.android_rounded, size: 20),
        const SizedBox(width: 8),
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(width: 6),
        const Icon(Icons.arrow_downward_rounded, size: 16),
      ],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: 'Download Android APK package to test app natively',
        child: isElevated
            ? ElevatedButton(
                onPressed: _handleTap,
                style: style,
                child: buttonContent,
              )
            : OutlinedButton(
                onPressed: _handleTap,
                style: style,
                child: buttonContent,
              ),
      ),
    );
  }

  Widget _buildBannerCallout(
      BuildContext context, bool isDark, Color primaryColor) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkCard
              : primaryColor.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? primaryColor
                : primaryColor.withValues(alpha: 0.25),
            width: 1.2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.android_rounded,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Try on Android Device',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Download the compiled Android APK to run the application natively on your phone.',
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleTap,
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text('Download APK'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkCard
              : primaryColor.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? primaryColor
                : primaryColor.withValues(alpha: 0.25),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: _isHovered ? 0.12 : 0.04),
              blurRadius: _isHovered ? 12 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.android_rounded,
                color: primaryColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Try on Android Device',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Download the compiled Android APK to run the application natively on your phone.',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: _handleTap,
              icon: const Icon(Icons.download_rounded, size: 18),
              label: const Text('Download APK'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    ApkHelper.downloadApk();
    widget.onDownloaded?.call();
  }
}
