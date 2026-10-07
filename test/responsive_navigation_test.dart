import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mariyaportfoliyo/app/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> testViewport(
      WidgetTester tester, double width, double height) async {
    tester.view.physicalSize = Size(width, height);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('Mariya Varghese'), findsWidgets);

    // Verify no overflow errors occurred
    expect(tester.takeException(), isNull);
  }

  testWidgets('Renders cleanly on 375px Mobile viewport without overflow',
      (WidgetTester tester) async {
    await testViewport(tester, 375, 812);
  });

  testWidgets('Renders cleanly on 768px Tablet viewport without overflow',
      (WidgetTester tester) async {
    await testViewport(tester, 768, 1024);
  });

  testWidgets('Renders cleanly on 1024px Tablet landscape viewport without overflow',
      (WidgetTester tester) async {
    await testViewport(tester, 1024, 768);
  });

  testWidgets('Renders cleanly on 1440px Desktop viewport without overflow',
      (WidgetTester tester) async {
    await testViewport(tester, 1440, 900);
  });
}
