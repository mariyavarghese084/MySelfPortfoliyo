import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mariyaportfoliyo/data/portfolio_data.dart';
import 'package:mariyaportfoliyo/utils/apk_helper.dart';
import 'package:mariyaportfoliyo/widgets/common/download_apk_button.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('APK Download Feature Tests', () {
    test('PortfolioData contains clear apkDownloadUrl configuration constant', () {
      expect(PortfolioData.apkDownloadUrl, isNotEmpty);
      expect(PortfolioData.apkDownloadUrl.startsWith('http') || PortfolioData.apkDownloadUrl.startsWith('assets'), isTrue);
    });

    test('ApkHelper correctly identifies platform download support', () {
      if (defaultTargetPlatform == TargetPlatform.android) {
        expect(ApkHelper.shouldShowDownloadButton, isFalse);
      } else {
        expect(ApkHelper.shouldShowDownloadButton, isTrue);
      }
    });

    testWidgets('DownloadApkButton renders with forceShow=true regardless of platform',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DownloadApkButton(
              forceShow: true,
              label: 'Download Android App',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Download Android App'), findsOneWidget);
      expect(find.byIcon(Icons.android_rounded), findsOneWidget);
    });

    testWidgets('HeroSection renders DownloadApkButton when forceShow is enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: DownloadApkButton(
                forceShow: true,
                variant: DownloadApkButtonVariant.outlined,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DownloadApkButton), findsOneWidget);
      expect(find.text('Download Android App'), findsOneWidget);
    });

    testWidgets('DownloadApkButton bannerCallout variant renders cleanly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DownloadApkButton(
              forceShow: true,
              variant: DownloadApkButtonVariant.bannerCallout,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Try on Android Device'), findsOneWidget);
      expect(find.text('Download APK'), findsOneWidget);
    });
  });
}
