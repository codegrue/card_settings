// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../../card_settings.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Constants
const double _kPickerHeaderPortraitHeight = 60.0;
const double _kPickerPortraitWidth = 330.0;
const double _kPickerPortraitHeight = 500.0;
const double _kPickerLandscapeWidth = 530.0;
const double _kPickerLandscapeHeight = 300.0;
const double _kDialogActionBarHeight = 52.0;

/// This is the color picker field
class CardSettingsColorPicker extends FormField<Color> {
  CardSettingsColorPicker({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign, // here for consistency, but does nothing.
    Color initialValue: Colors.green,
    Icon icon,
    Widget requiredIndicator,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<Color> onSaved,
    this.onChanged,
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
                  icon: icon,
                  requiredIndicator: requiredIndicator,
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

  final ValueChanged<Color> onChanged;

  @override
  _CardSettingsColorPickerState createState() =>
      _CardSettingsColorPickerState();
}

class _CardSettingsColorPickerState extends FormFieldState<Color> {
  @override
  CardSettingsColorPicker get widget => super.widget as CardSettingsColorPicker;

  void _showDialog(String title) {
    Color _pickerColor = value;

    showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        Widget header = Container(
          color: Theme.of(context).primaryColor,
          height: _kPickerHeaderPortraitHeight,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                color: const Color(0xffffffff),
              ),
            ),
          ),
          padding: EdgeInsets.all(20.0),
        );

        Widget picker = Container(
          child: ColorPicker(
            pickerColor: _pickerColor,
            onColorChanged: (color) => _pickerColor = color,
            colorPickerWidth: 1000.0,
            enableLabel: true,
            pickerAreaHeightPercent: 0.7,
          ),
        );

        final Widget actions = ButtonTheme.bar(
          child: Container(
            height: _kDialogActionBarHeight,
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(_pickerColor),
                ),
              ],
            ),
          ),
        );

        return Dialog(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              assert(orientation != null);
              assert(context != null);
              return SizedBox(
                width: (orientation == Orientation.portrait)
                    ? _kPickerPortraitWidth
                    : _kPickerLandscapeWidth,
                height: (orientation == Orientation.portrait)
                    ? _kPickerPortraitHeight
                    : _kPickerLandscapeHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    header,
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          picker,
                          actions,
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        didChange(value);
        if (widget.onChanged != null) widget.onChanged(value);
      }
    });
  }
}
