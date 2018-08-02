// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'card_settings_field.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// This is the color picker field
class CardSettingsColorPicker extends FormField<Color> {
  CardSettingsColorPicker({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    Color initialValue: Colors.green,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<Color> onSaved,
    FormFieldValidator<Color> validator,
  }) : super(
            key: key,
            initialValue: initialValue ?? Colors.black,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<Color> field) {
              final _CardSettingsColorPickerState state = field;
              return GestureDetector(
                onTap: () {
                  state._showDialog("Color for " + label);
                },
                child: CardSettingsField(
                  label: label,
                  labelAlign: labelAlign,
                  visible: visible,
                  errorText: field.errorText,
                  content: Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: state.value,
                    ),
                  ),
                ),
              );
            });

  @override
  _CardSettingsColorPickerState createState() =>
      new _CardSettingsColorPickerState();
}

class _CardSettingsColorPickerState extends FormFieldState<Color> {
  @override
  CardSettingsColorPicker get widget => super.widget;

  void _showDialog(String title) {
    Color _pickerColor = value;

    showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text(title),
          content: new SingleChildScrollView(
            child: new ColorPicker(
              pickerColor: _pickerColor,
              onColorChanged: (color) => _pickerColor = color,
              enableLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("CANCEL"),
            ),
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(_pickerColor),
              child: Text("OK"),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        didChange(value);
      }
    });
  }
}
