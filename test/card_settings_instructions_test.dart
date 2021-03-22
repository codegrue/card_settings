import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardSettingsInstructions', () {
    Widget widgetTree = Container();
    var instructions = "Don't panic!";
    var color = Colors.indigo;

    setUpAll(() async {
      widgetTree = MaterialApp(
        home: CardSettings(
          children: [
            CardSettingsSection(
              instructions: CardSettingsInstructions(
                text: instructions,
                textColor: color,
              ),
            ),
          ],
        ),
      );
    });

    testWidgets('displays properties', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(widgetTree);

      // assert
      final instructionsFinder = find.text(instructions);
      expect(instructionsFinder, findsOneWidget);
      final value = instructionsFinder.evaluate().first.widget as Text;
      expect(value.style?.color, color);
    });
  });
}
