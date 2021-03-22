import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardSettingsHeader', () {
    Widget widgetTree = Container();
    var label = "ArbitraryTitle";

    setUpAll(() async {
      widgetTree = MaterialApp(
        home: CardSettings(
          children: [
            CardSettingsSection(
              header: CardSettingsHeader(
                label: label,
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
      final labelFinder = find.text(label);
      expect(labelFinder, findsOneWidget);
    });
  });
}
