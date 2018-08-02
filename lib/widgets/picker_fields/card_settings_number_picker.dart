// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../../card_settings.dart';

/// This is a list picker that allows for a range of numbers to be speficied as pptions.
class CardSettingsNumberPicker extends StatelessWidget {
  CardSettingsNumberPicker({
    this.label: 'Label',
    this.labelAlign,
    this.initialValue,
    this.contentAlign,
    @required this.min,
    @required this.max,
    this.autovalidate: false,
    this.validator,
    this.onSaved,
    this.visible: true,
  }) : assert(min < max);

  // Variables
  final String label;
  final TextAlign labelAlign;
  final TextAlign contentAlign;
  final int initialValue;
  final int min;
  final int max;
  final bool autovalidate;
  final bool visible;

  // Events
  final FormFieldValidator<int> validator;
  final FormFieldSetter<int> onSaved;

  @override
  Widget build(BuildContext context) {
    return new CardSettingsListPicker(
      label: this.label,
      labelAlign: labelAlign,
      contentAlign: contentAlign,
      visible: visible,
      initialValue: initialValue?.toString(),
      options:
          new List<String>.generate(max - min + 1, (i) => (i + min).toString()),
      autovalidate: autovalidate,
      validator: _safeValidator,
      onSaved: _safeOnSaved,
    );
  }

  String _safeValidator(value) {
    if (validator == null) return null;
    return validator(intelligentCast<int>(value));
  }

  void _safeOnSaved(value) {
    if (onSaved == null) return;
    onSaved(intelligentCast<int>(value));
  }
}
