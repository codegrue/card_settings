// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../../card_settings.dart';

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

  void _showDialog() {
    pickerColor = value;

    var title = "Color for " + widget?.label;

    var showCupertino = (Platform.isIOS && !widget.showMaterialonIOS);
    var headerColor = (showCupertino) ? Colors.white : null;
    var textColor = (showCupertino) ? Colors.black : null;

    switch (widget.pickerType) {
      case CardSettingsColorPickerType.colors:
        showMaterialColorPicker(
          context: context,
          title: title,
          headerColor: headerColor,
          buttonTextColor: textColor,
          headerTextColor: textColor,
          selectedColor: pickerColor,
          onChanged: (value) {
            if (value != null) {
              didChange(value);
              if (widget.onChanged != null) widget.onChanged(value);
            }
          },
        );
        break;
      case CardSettingsColorPickerType.material:
        showMaterialPalettePicker(
          context: context,
          title: title,
          headerColor: headerColor,
          buttonTextColor: textColor,
          headerTextColor: textColor,
          selectedColor: pickerColor,
          onChanged: (value) {
            if (value != null) {
              didChange(value);
              if (widget.onChanged != null) widget.onChanged(value);
            }
          },
        );
        break;
      case CardSettingsColorPickerType.block:
        showMaterialSwatchPicker(
          context: context,
          title: title,
          headerColor: headerColor,
          headerTextColor: textColor,
          buttonTextColor: textColor,
          selectedColor: pickerColor,
          onChanged: (value) {
            if (value != null) {
              didChange(value);
              if (widget.onChanged != null) widget.onChanged(value);
            }
          },
        );
        break;
    }
  }

  Widget _build(BuildContext context) {
    if (Platform.isIOS && !widget.showMaterialonIOS) {
      return Container(
        child: widget?.visible == false
            ? null
            : GestureDetector(
                onTap: () {
                  _showDialog();
                },
                child: CSControl(
                  nameWidget: widget?.requiredIndicator != null
                      ? Text((widget?.label ?? "") + ' *')
                      : Text(widget?.label),
                  contentWidget: Container(
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
        _showDialog();
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
