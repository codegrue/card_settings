// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../card_settings_field.dart';

/// This is a field that allows multiple lines of text to be entered.
class CardSettingsParagraph extends StatelessWidget {
  CardSettingsParagraph({
    this.label: 'Label',
    this.labelAlign,
    this.initialValue,
    this.autovalidate: false,
    this.numberOfLines: 7,
    this.maxLength: 250,
    this.validator,
    this.onSaved,
    this.visible: true,
    this.controller,
  });

  final String label;
  final TextAlign labelAlign;
  final String initialValue;
  final bool autovalidate;
  final int numberOfLines;
  final int maxLength;
  final bool visible;
  final TextEditingController controller;

  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;

  Widget build(BuildContext context) {
    return new CardSettingsField(
      contentOnNewLine: true,
      label: label,
      labelAlign: labelAlign,
      visible: visible,
      content: Container(
        child: TextFormField(
          maxLines: numberOfLines,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0.0),
            border: InputBorder.none,
          ),
          initialValue: initialValue,
          autovalidate: autovalidate,
          validator: validator,
          onSaved: onSaved,
          controller: controller,
          maxLength: maxLength, // note, this will show the counter
        ),
      ),
    );
  }
}
