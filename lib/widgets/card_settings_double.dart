// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'card_settings_field.dart';
import 'package:card_settings/helpers/converter_functions.dart';

/// This is a field for entering numeric doubles
class CardSettingsDouble extends StatelessWidget {
  CardSettingsDouble({
    this.label: 'Label',
    this.labelAlign,
    this.initialValue: 0.0,
    this.maxLength: 10,
    this.autovalidate: false,
    this.validator,
    this.onSaved,
    this.unitLabel,
    this.visible: true,
    this.controller,
  });

  final String label;
  final TextAlign labelAlign;
  final double initialValue;
  final bool autovalidate;
  final String unitLabel;
  final int maxLength;
  final bool visible;
  final TextEditingController controller;

  // Events
  final FormFieldValidator<double> validator;
  final FormFieldSetter<double> onSaved;

  Widget build(BuildContext context) {
    return CardSettingsField(
      label: label,
      labelAlign: labelAlign,
      visible: visible,
      unitLabel: unitLabel,
      content: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
        ),
        initialValue: initialValue?.toString() ?? '',
        autovalidate: autovalidate,
        validator: _safeValidator,
        onSaved: _safeOnSaved,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
          WhitelistingTextInputFormatter(RegExp("[0-9]+.?[0-9]*")),
        ],
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
