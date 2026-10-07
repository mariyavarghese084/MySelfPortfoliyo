import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mariyaportfoliyo/app/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<Size> testResolutions = const [
    Size(375, 812),   // 375 x 812 (iPhone X / Mobile)
    Size(390, 844),   // 390 x 844 (iPhone 12/13/14)
    Size(412, 915),   // 412 x 915 (Android Pixel)
    Size(768, 1024),  // 768 x 1024 (Tablet Portrait)
    Size(1024, 768),  // 1024 x 768 (Tablet Landscape)
    Size(1280, 800),  // 1280 x 800 (Laptop)
    Size(1440, 900),  // 1440 x 900 (Desktop MacBook)
    Size(1920, 1080), // 1920 x 1080 (Full HD Desktop)
  ];

  for (final size in testResolutions) {
    testWidgets(
      'Responsive UI Audit at ${size.width.toInt()}x${size.height.toInt()} - Zero Overflows',
      (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(const PortfolioApp());
        await tester.pumpAndSettle();

        // 1. Verify app title / Mariya Varghese present
        expect(find.text('Mariya Varghese'), findsWidgets);
        expect(tester.takeException(), isNull);

        // 2. Scroll through page from top to bottom by dragging center of screen
        final centerScreen = Offset(size.width / 2, size.height / 2);
        for (int i = 0; i < 5; i++) {
          await tester.dragFrom(centerScreen, const Offset(0, -400));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }

        // 3. Tap "View Details" button if visible
        final viewDetailsFinder = find.text('View Details');
        if (viewDetailsFinder.evaluate().isNotEmpty) {
          final firstBtn = viewDetailsFinder.first;
          await tester.dragUntilVisible(
            firstBtn,
            find.byType(Scrollable).first,
            const Offset(0, -100),
          );
          await tester.pumpAndSettle();

          await tester.tap(firstBtn);
          await tester.pumpAndSettle();

          // Verify modal dialog renders cleanly without exception
          expect(find.text('Overview'), findsOneWidget);
          expect(tester.takeException(), isNull);

          // Close modal dialog safely using close icon
          final closeIcon = find.byIcon(Icons.close_rounded);
          if (closeIcon.evaluate().isNotEmpty) {
            await tester.tap(closeIcon.first);
            await tester.pumpAndSettle();
          }
        }
      },
    );
  }
}
