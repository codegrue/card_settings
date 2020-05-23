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

    test('on iOS, returns true if showMaterialonIOS and context not provided',
        () {
      bool showMaterialonIOS; // null
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

      bool showMaterialonIOS; // null
      bool isIOS = true;
      var result = showCupertino(context, showMaterialonIOS, mockIOS: isIOS);

      expect(result, true);
    });

    // testWidgets(
    //     'on iOS, returns showMaterialonIOS of CardSettings if showMaterialonIOS not provided',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(
    //     Builder(
    //       builder: (BuildContext context) {
    //         bool showMaterialonIOS; //null
    //         bool isIOS = true;
    //         var result =
    //             showCupertino(context, showMaterialonIOS, mockIOS: isIOS);

    //         expect(result, true);

    //         // The builder function must return a widget.
    //         return Placeholder();
    //       },
    //     ),
    //   );
    // });

// mock CardSettings.of(context).showMaterialonIOS
// mock platform.ios
  });
}

class MockContext extends Mock implements BuildContext {}
