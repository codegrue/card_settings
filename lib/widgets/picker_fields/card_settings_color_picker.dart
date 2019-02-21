// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';

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
    bool autovalidate: false,
    FormFieldSetter<Color> onSaved,
    FormFieldValidator<Color> validator,
    Color initialValue = Colors.green,
    this.onChanged,
    this.visible = true,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.requiredIndicator,
    this.label = "Label",
    this.showMaterialIOS = false,
  }) : super(
            key: key,
            initialValue: initialValue ?? Colors.black,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<Color> field) =>
                _CardSettingsColorPickerState().widget);

  final ValueChanged<Color> onChanged;

  final TextAlign labelAlign;

  /// here for consistency, but does nothing.
  final TextAlign contentAlign;

  final Icon icon;

  final Widget requiredIndicator;

  final String label;

  final bool visible;

  final bool showMaterialIOS;

  @override
  _CardSettingsColorPickerState createState() =>
      _CardSettingsColorPickerState();
}

class _CardSettingsColorPickerState extends FormFieldState<Color> {
  @override
  CardSettingsColorPicker get widget => super.widget as CardSettingsColorPicker;

  void _showDialog(String title) {
    if (Platform.isIOS && !widget.showMaterialIOS) {
      Color _pickerColor = value;

      showDialog<Color>(
        context: context,
        builder: (BuildContext context) {
          return OrientationBuilder(builder: (context, orientation) {
            return AlertDialog(
              title: Container(
                height: _kPickerHeaderPortraitHeight,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(20.0),
              ),
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: _pickerColor,
                  onColorChanged: (color) => _pickerColor = color,
                  colorPickerWidth: 1000.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: true,
                ),
              ),
              actions: <Widget>[
                CupertinoButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(_pickerColor),
                ),
              ],
            );
          });
        },
      ).then((value) {
        if (value != null) {
          didChange(value);
          if (widget.onChanged != null) widget.onChanged(value);
        }
      });
    } else {
      Color _pickerColor = value;

      showDialog<Color>(
        context: context,
        builder: (BuildContext context) {
          return OrientationBuilder(builder: (context, orientation) {
            return AlertDialog(
              title: Container(
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
              ),
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: _pickerColor,
                  onColorChanged: (color) => _pickerColor = color,
                  colorPickerWidth: 1000.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: true,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(_pickerColor),
                ),
              ],
            );
          });
        },
      ).then((value) {
        if (value != null) {
          didChange(value);
          if (widget.onChanged != null) widget.onChanged(value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && !widget.showMaterialIOS) {
      return Container(
        child: widget?.visible == false
            ? null
            : GestureDetector(
                onTap: () {
                  _showDialog("Color for " + widget?.label);
                },
                child: CSControl(
                  widget?.requiredIndicator != null
                      ? (widget?.label ?? "") + ' *'
                      : widget?.label,
                  Container(
                    height: 20.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: value,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  style: CSWidgetStyle(icon: widget?.icon),
                ),
              ),
      );
    }
    return GestureDetector(
      onTap: () {
        _showDialog("Color for " + widget?.label);
      },
      child: CardSettingsField(
        label: widget?.label,
        labelAlign: widget?.labelAlign,
        visible: widget?.visible,
        icon: widget?.icon,
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Container(
          height: 20.0,
          decoration: BoxDecoration(
            color: value,
          ),
        ),
      ),
    );
  }
}
