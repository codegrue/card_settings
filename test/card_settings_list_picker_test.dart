import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardSettingsListPicker', () {
    Widget widgetTree = Container();
    var label = "PickOne";
    var option1 = PickerModel("Aaa", code: "A", icon: Icon(Icons.home));
    var option2 = PickerModel("Bbb", code: "B", icon: Icon(Icons.access_alarm));
    var option3 = PickerModel("Ccc", code: "C", icon: Icon(Icons.exit_to_app));
    var items = [option1, option2, option3];
    var requiredIndicator = "#";
    var initialValue = option1;

    setUpAll(() async {
      widgetTree = MaterialApp(
        home: CardSettings(
          children: [
            CardSettingsSection(
              children: [
                CardSettingsSelectionPicker<PickerModel>(
                  label: label,
                  initialItem: initialValue,
                  items: items,
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
      expect(find.text(option1.name), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.text(requiredIndicator), findsOneWidget);
    });

    testWidgets('picks from dialog', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(widgetTree);

      // act
      await tester.tap(find.text(option1.name)); // tap field
      await tester.pumpAndSettle();

      await tester.tap(find.text(option2.name)); // tap item in dialog
      await tester.pumpAndSettle();

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      // assert
      expect(find.text(option1.name), findsNothing);
      expect(find.text(option2.name), findsOneWidget);
      expect(find.text(option3.name), findsNothing);
    });
  });
}
