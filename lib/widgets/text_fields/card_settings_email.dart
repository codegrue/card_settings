// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../card_settings.dart';

/// This is a sepcial field used to collect email addresses
class CardSettingsEmail extends StatelessWidget {
  CardSettingsEmail({
    this.label: 'Email',
    this.labelAlign,
    this.contentAlign,
    this.initialValue,
    this.maxLength: 20,
    this.autovalidate: false,
    this.validator,
    this.onSaved,
    this.keyboardType: TextInputType.emailAddress,
    this.unitLabel,
    this.visible: true,
    this.controller,
  });

  final String label;
  final TextAlign labelAlign;
  final TextAlign contentAlign;
  final String initialValue;
  final bool autovalidate;
  final TextInputType keyboardType;
  final String unitLabel;
  final int maxLength;
  final bool visible;
  final TextEditingController controller;

  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;

  Widget build(BuildContext context) {
    return new CardSettingsField(
      label: label,
      labelAlign: labelAlign,
      visible: visible,
      unitLabel: unitLabel,
      content: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0), border: InputBorder.none),
        initialValue: initialValue,
        textAlign: contentAlign ?? CardSettings.of(context).contentAlign,
        autovalidate: autovalidate,
        validator: validator,
        keyboardType: keyboardType,
        onSaved: onSaved,
        controller: controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
      ),
    );
  }
}
