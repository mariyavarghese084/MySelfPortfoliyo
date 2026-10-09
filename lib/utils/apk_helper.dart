import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';

/// Helper utility for handling Android APK download availability and web/desktop downloading.
class ApkHelper {
  /// Determines whether the Android APK download button should be displayed.
  ///
  /// Prominently shown on Web and Desktop platforms.
  /// Hidden when running on Android devices (native or mobile Android web).44
  static bool get shouldShowDownloadButton {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return false;
    }
    return kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux;
  }

  /// Triggers standard web/desktop browser download of the configured APK URL.
  ///
  /// Does NOT attempt automatic installation. Opens the URL using [LaunchMode.externalApplication]
  /// which prompts the web browser to download the file natively.
  static Future<void> downloadApk([String? customUrl]) async {
    final String targetUrl = customUrl ?? PortfolioData.apkDownloadUrl;
    final Uri uri = Uri.parse(targetUrl);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch APK download URL: $targetUrl');
    }
  }
}
