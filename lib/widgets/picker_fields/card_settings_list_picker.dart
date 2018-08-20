// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../../card_settings.dart';

/// This is a list picker that allows an arbitrary list of options to be provided.
class CardSettingsListPicker extends FormField<String> {
  CardSettingsListPicker({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    String initialValue,
    Icon icon,
    Widget requiredIndicator,
    List<String> options,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    this.onChanged,
  }) : super(
            key: key,
            initialValue: initialValue ?? '',
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> field) {
              final _CardSettingsListPickerState state = field;
              return GestureDetector(
                onTap: () {
                  state._showDialog(label, options);
                },
                child: CardSettingsField(
                  label: label,
                  labelAlign: labelAlign,
                  visible: visible,
                  icon: icon,
                  requiredIndicator: requiredIndicator,
                  errorText: field.errorText,
                  content: Text(
                    state.value ?? '',
                    style: Theme.of(field.context).textTheme.subhead,
                    textAlign: contentAlign ??
                        CardSettings.of(field.context).contentAlign,
                  ),
                  pickerIcon: Icons.arrow_drop_down,
                ),
              );
            });

  final ValueChanged<String> onChanged;

  @override
  _CardSettingsListPickerState createState() => _CardSettingsListPickerState();
}

class _CardSettingsListPickerState extends FormFieldState<String> {
  @override
  CardSettingsListPicker get widget => super.widget as CardSettingsListPicker;

  void _showDialog(String label, List<String> options) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return PickerDialog(
          items: options,
          title: 'Select ' + label,
          initialValue: value,
        );
      },
    ).then((value) {
      if (value != null) {
        didChange(value);
        widget.onChanged(value);
      }
    });
  }
}
