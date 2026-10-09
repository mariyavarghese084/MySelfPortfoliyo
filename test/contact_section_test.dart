import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mariyaportfoliyo/widgets/sections/contact_section.dart';

void main() {
  testWidgets('ContactSection renders all four form fields and submit button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ContactSection(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(TextFormField, 'Your Name'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Your Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Subject'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Message'), findsOneWidget);
    expect(find.text('Send Message'), findsOneWidget);
  });
}
