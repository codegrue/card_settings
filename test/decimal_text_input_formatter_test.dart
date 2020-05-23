import 'package:card_settings/helpers/decimal_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DecimalTextInputFormatter', () {
    test('handles decimal truncation', () {
      var oldValue = TextEditingValue(
        text: "12,345.67",
      );
      var newValue = TextEditingValue(
        text: "12,345.678",
      );

      var formatter = DecimalTextInputFormatter(decimalDigits: 2);
      var result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, "12,345.67");
    });

    test('adds leading zero', () {
      var oldValue = TextEditingValue(
        text: "",
      );
      var newValue = TextEditingValue(
        text: ".",
      );

      var formatter = DecimalTextInputFormatter(decimalDigits: 2);
      var result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, "0.");
    });
  });
}
