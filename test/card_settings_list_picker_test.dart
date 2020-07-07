import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardSettingsListPicker', () {
    Widget widgetTree;
    var label = "PickOne";
    var initialValue = "A";
    var option1 = "Aaa";
    var option2 = "Bbb";
    var option3 = "Ccc";
    var options = [option1, option2, option3];
    var values = ["A", "B", "C"];
    var icon = Icons.home;
    var requiredIndicator = "#";

    setUpAll(() async {
      widgetTree = MaterialApp(
        home: CardSettings(
          children: [
            CardSettingsSection(
              children: [
                CardSettingsSelectionPicker(
                  label: label,
                  initialValue: initialValue,
                  options: options,
                  values: values,
                  icon: Icon(icon),
                  requiredIndicator: Text(requiredIndicator),
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
      expect(find.text(label), findsOneWidget);
      expect(find.text(option1), findsOneWidget);
      expect(find.byIcon(icon), findsOneWidget);
      expect(find.text(requiredIndicator), findsOneWidget);
    });

    testWidgets('picks from dialog', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(widgetTree);

      // act
      await tester.tap(find.text(option1)); // tap field
      await tester.pumpAndSettle();

      await tester.tap(find.text(option2)); // tap item in dialog
      await tester.pumpAndSettle();

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      // assert
      expect(find.text(option1), findsNothing);
      expect(find.text(option2), findsOneWidget);
      expect(find.text(option3), findsNothing);
    });
  });
}
