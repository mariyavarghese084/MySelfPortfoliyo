import 'package:flutter_test/flutter_test.dart';
import 'package:mariyaportfoliyo/app/app.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    // Verify that Mariya Varghese header/text is present.
    expect(find.text('Mariya Varghese'), findsWidgets);
  });
}
