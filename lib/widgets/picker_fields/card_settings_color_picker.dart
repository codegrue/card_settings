// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';

// Constants
const double _kPickerHeaderPortraitHeight = 60.0;

enum CardSettingsColorPickerType { colors, material, block }

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
    this.pickerType = CardSettingsColorPickerType.colors,
    this.requiredIndicator,
    this.label = "Label",
    this.showMaterialonIOS = false,
  }) : super(
            key: key,
            initialValue: initialValue ?? Colors.black,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<Color> field) =>
                (field as _CardSettingsColorPickerState)._build(field.context));

  final ValueChanged<Color> onChanged;

  final TextAlign labelAlign;

  /// here for consistency, but does nothing.
  final TextAlign contentAlign;

  final Icon icon;

  final Widget requiredIndicator;

  final String label;

  final bool visible;

  final bool showMaterialonIOS;

  final CardSettingsColorPickerType pickerType;

  @override
  _CardSettingsColorPickerState createState() =>
      _CardSettingsColorPickerState();
}

class _CardSettingsColorPickerState extends FormFieldState<Color> {
  @override
  CardSettingsColorPicker get widget => super.widget as CardSettingsColorPicker;

  Color pickerColor;

  void _showDialog(String title) {
    pickerColor = value;

    Widget _pickerControl;

    switch (widget.pickerType) {
      case CardSettingsColorPickerType.colors:
        _pickerControl = ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: (color) => pickerColor = color,
          colorPickerWidth: 1000.0,
          pickerAreaHeightPercent: 0.3,
          enableAlpha: true,
          displayThumbColor: true,
          enableLabel: true,
          paletteType: PaletteType.hsv,
        );
        break;
      case CardSettingsColorPickerType.material:
        _pickerControl = MaterialPicker(
          pickerColor: pickerColor,
          onColorChanged: (color) => pickerColor = color,
          enableLabel: true, // only on portrait mode
        );
        break;
      case CardSettingsColorPickerType.block:
        _pickerControl = BlockPicker(
          pickerColor: pickerColor,
          onColorChanged: (color) => pickerColor = color,
        );
        break;
    }

    if (Platform.isIOS && !widget.showMaterialonIOS) {
      _showDialogCupertino(title, _pickerControl);
    } else {
      _showDialogMaterial(title, _pickerControl);
    }
  }

  void _showDialogCupertino(String title, Widget pickerControl) {
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
              child: pickerControl,
            ),
            actions: <Widget>[
              CupertinoButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(pickerColor),
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

  void _showDialogMaterial(String title, Widget pickerControl) {
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
            content: SingleChildScrollView(child: pickerControl),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(pickerColor),
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

  Widget _build(BuildContext context) {
    if (Platform.isIOS && !widget.showMaterialonIOS) {
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
