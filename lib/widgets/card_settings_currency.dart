// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'card_settings_field.dart';
import 'package:card_settings/helpers/converter_functions.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

/// This is a field for entering numeric doubles
class CardSettingsCurrency extends StatelessWidget {
  CardSettingsCurrency({
    this.label: 'Label',
    this.initialValue,
    this.maxLength: 10,
    this.autovalidate: false,
    this.validator,
    this.onSaved,
    this.currencySymbol: '\$',
    this.currencyName: 'USD',
    this.decimalSeparator: '.',
    this.thousandSeparator: ',',
    this.visible: true,
  });

  final String label;
  final double initialValue;
  final bool autovalidate;
  final String currencySymbol;
  final String currencyName;
  final String decimalSeparator;
  final String thousandSeparator;
  final int maxLength;
  final bool visible;

  // Events
  final FormFieldValidator<double> validator;
  final FormFieldSetter<double> onSaved;

  Widget build(BuildContext context) {
    var controller = new MoneyMaskedTextController(
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator);
    controller.value = TextEditingValue(text: initialValue?.toString());

    return CardSettingsField(
      label: label,
      visible: visible,
      unitLabel: currencyName,
      content: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
          prefixText: currencySymbol,
        ),
        controller: controller,
        autovalidate: autovalidate,
        validator: _safeValidator,
        onSaved: _safeOnSaved,
        keyboardType: TextInputType.number,
      ),
    );
  }

  String _safeValidator(value) {
    if (validator == null) return null;
    return validator(intelligentCast<double>(value));
  }

  void _safeOnSaved(value) {
    if (onSaved == null) return;
    onSaved(intelligentCast<double>(value));
  }
}
