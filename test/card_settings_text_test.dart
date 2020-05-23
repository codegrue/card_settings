import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardSettingsText', () {
    Widget widgetTree;
    var label = "MeInput";
    var initialValue = "Hello World";
    var icon = Icons.home;
    var requiredIndicator = "#";
    var hintText = "Show me the world!";

    setUpAll(() async {
      widgetTree = MaterialApp(
        home: CardSettings(
          children: [
            CardSettingsSection(
              children: [
                CardSettingsText(
                  label: label,
                  initialValue: initialValue,
                  icon: Icon(icon),
                  requiredIndicator: Text(requiredIndicator),
                  hintText: hintText,
                )
              ],
            ),
          ],
        ),
      );
    });

    testWidgets('displays properties', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(widgetTree);

      // assert
      final labelFinder = find.text(label);
      expect(labelFinder, findsOneWidget);
      final valueFinder = find.text(initialValue);
      expect(valueFinder, findsOneWidget);
      final iconFinder = find.byIcon(icon);
      expect(iconFinder, findsOneWidget);
      final requiredIndicatorFinder = find.text(requiredIndicator);
      expect(requiredIndicatorFinder, findsOneWidget);
    });

    testWidgets('changes text', (WidgetTester tester) async {
      // arrange
      var newText = "Brave new world";
      await tester.pumpWidget(widgetTree);

      // act
      await tester.enterText(find.byType(TextField), newText);

      // assert
      final valueFinder = find.text(newText);
      expect(valueFinder, findsOneWidget);
    });

    testWidgets('shows hintText', (WidgetTester tester) async {
      // arrange
      var newText = "";
      await tester.pumpWidget(widgetTree);

      // act
      await tester.enterText(find.byType(TextField), newText);

      // assert
      final hintFinder = find.text(hintText);
      expect(hintFinder, findsOneWidget);
    });
  });
}
