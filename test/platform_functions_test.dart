import 'package:card_settings/helpers/platform_functions.dart';
import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('showCupertino', () {
    testWidgets('returns false on non-iOS', (WidgetTester tester) async {
      var showMaterialonIOS = true;
      bool isIOS = true;
      var result = showCupertino(null, showMaterialonIOS, mockIOS: isIOS);

      expect(result, false);
    });

    test('on iOS, returns false if showMaterialonIOS true', () {
      var showMaterialonIOS = true;
      bool isIOS = true;
      var result = showCupertino(null, showMaterialonIOS, mockIOS: isIOS);

      expect(result, false);
    });

    test(
        'on iOS, returns true if showMaterialonIOS null and context not provided',
        () {
      bool? showMaterialonIOS; // null
      bool isIOS = true;
      var result = showCupertino(null, showMaterialonIOS, mockIOS: isIOS);

      expect(result, true);
    });

    test(
        'on iOS, returns showMaterialonIOS of CardSettings if showMaterialonIOS not provided',
        () {
      // set up mocks
      var context = MockContext();
      when(context.dependOnInheritedWidgetOfExactType<CardSettings>())
          .thenReturn(
        CardSettings(
          children: [
            CardSettingsSection(),
          ],
        ),
      );

      bool? showMaterialonIOS; // null
      bool isIOS = true;
      var result = showCupertino(context, showMaterialonIOS, mockIOS: isIOS);

      expect(result, true);
    });
  });

  group('labelStyle', () {
    test('enabled uses textTheme.subtitle1 color', () {
      // Arrange
      bool enabled = true;
      var context = MockContext();

      // Act
      var result = labelStyle(context, enabled);

      // Assert
      var expectedColor = Theme.of(context).textTheme.subtitle1?.color;
      expect(result?.color, expectedColor);
    });

    test('disabled uses disabledColor', () {
      // Arrange
      bool enabled = false;
      var context = MockContext();

      // Act
      var result = labelStyle(context, enabled);

      // Assert
      var expectedColor = Theme.of(context).disabledColor;
      expect(result?.color, expectedColor);
    });
  });

  group('contentStyle', () {
    test('enabled uses textTheme.subtitle1 color if value is present', () {
      // Arrange
      bool enabled = true;
      String value = "Some text";
      var context = MockContext();

      // Act
      var result = contentStyle(context, value, enabled);

      // Assert
      var expectedColor = Theme.of(context).textTheme.subtitle1?.color;
      expect(result?.color, expectedColor);
    });

    test('enabled uses textTheme.hintColor if value not present', () {
      // Arrange
      bool enabled = true;
      String? value; // null
      var context = MockContext();

      // Act
      var result = contentStyle(context, value, enabled);

      // Assert
      var expectedColor = Theme.of(context).hintColor;
      expect(result?.color, expectedColor);
    });

    test('disabled uses disabledColor', () {
      // Arrange
      bool enabled = false;
      String value = "Some text";
      var context = MockContext();

      // Act
      var result = contentStyle(context, value, enabled);

      // Assert
      var expectedColor = Theme.of(context).disabledColor;
      expect(result?.color, expectedColor);
    });
  });
}

class MockContext extends Mock implements BuildContext {}
