import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:card_settings/card_settings.dart';

void main() {
  group('intelligentCast', () {
    test('handles doubles', () {
      double? result = intelligentCast<double>("3.145");
      expect(result, 3.145);
    });

    test('handles booleans', () {
      bool? result = intelligentCast<bool>("True");
      expect(result, true);

      result = intelligentCast<bool>("Yes");
      expect(result, true);

      result = intelligentCast<bool>("1");
      expect(result, true);

      result = intelligentCast<bool>("False");
      expect(result, false);

      result = intelligentCast<bool>("No");
      expect(result, false);

      result = intelligentCast<bool>("0");
      expect(result, false);
    });

    test('handles integers', () {
      int? result = intelligentCast<int>("42");
      expect(result, 42);
    });

    test('handles nulls', () {
      bool? boolResult = intelligentCast<bool>(null);
      expect(boolResult, false);

      int? intResult = intelligentCast<int>(null);
      expect(intResult, null);

      double? doubleResult = intelligentCast<double>(null);
      expect(doubleResult, null);

      Color? colorResult = intelligentCast<Color>(null);
      expect(colorResult, null);
    });

    test('handles Strings', () {
      String? result = intelligentCast<String>('sample');
      expect(result, 'sample');

      result = intelligentCast<String>(''); // empty string becomes null
      expect(result, null);
    });

    test('handles Colors', () {
      Color? result = intelligentCast<Color>("FFFFFFFF");
      expect(result, Colors.white);

      result = intelligentCast<Color>("000000");
      expect(result, Colors.black);
    });
  });
}
