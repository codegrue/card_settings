// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../card_settings_field.dart';

/// This is the date picker field
class CardSettingsDatePicker extends FormField<DateTime> {
  CardSettingsDatePicker({
    Key key,
    label: 'Label',
    TextAlign labelAlign,
    initialValue,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<DateTime> onSaved,
    FormFieldValidator<DateTime> validator,
  }) : super(
            key: key,
            initialValue: initialValue ?? DateTime.now(),
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<DateTime> field) {
              final _CardSettingsDatePickerState state = field;
              return GestureDetector(
                onTap: () {
                  state._showDialog();
                },
                child: CardSettingsField(
                  label: label,
                  labelAlign: labelAlign,
                  visible: visible,
                  errorText: field.errorText,
                  content: Text(
                    state.value == null
                        ? ''
                        : DateFormat.yMd().format(state.value),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  pickerIcon: Icons.arrow_drop_down,
                ),
              );
            });

  @override
  _CardSettingsDatePickerState createState() =>
      new _CardSettingsDatePickerState();
}

class _CardSettingsDatePickerState extends FormFieldState<DateTime> {
  @override
  CardSettingsDatePicker get widget => super.widget;

  void _showDialog() {
    showDatePicker(
      context: context,
      initialDate: value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        didChange(value);
      }
    });
  }
}
