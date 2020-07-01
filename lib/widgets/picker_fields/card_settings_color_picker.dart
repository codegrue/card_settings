// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_attributes.dart';

enum CardSettingsColorPickerType { colors, material, block }

/// This is the color picker field
class CardSettingsColorPicker extends FormField<Color>
    implements ICommonFieldProperties {
  CardSettingsColorPicker({
    Key key,
    bool autovalidate: false,
    FormFieldSetter<Color> onSaved,
    FormFieldValidator<Color> validator,
    Color initialValue = Colors.green,
    this.enabled = true,
    this.onChanged,
    this.visible = true,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.labelWidth,
    this.pickerType = CardSettingsColorPickerType.colors,
    this.requiredIndicator,
    this.label = "Label",
    this.showMaterialonIOS,
  }) : super(
            key: key,
            initialValue: initialValue ?? Colors.black,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<Color> field) =>
                (field as _CardSettingsColorPickerState)._build(field.context));

  @override
  final ValueChanged<Color> onChanged;

  @override
  final TextAlign labelAlign;

  @override
  final double labelWidth;

  /// here for consistency, but does nothing.
  @override
  final TextAlign contentAlign;

  @override
  final Icon icon;

  @override
  final Widget requiredIndicator;

  @override
  final String label;

  @override
  final bool enabled;

  @override
  final bool visible;

  @override
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

    var title = widget.label;

    var cupertinoColors = showCupertino(context, widget.showMaterialonIOS);
    var headerColor = (cupertinoColors) ? Colors.white : null;
    var textColor = (cupertinoColors) ? Colors.black : null;

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
    if (showCupertino(context, widget.showMaterialonIOS))
      return cupertinoSettingsColorPicker();
    else
      return materialSettingsColorPicker();
  }

  Widget cupertinoSettingsColorPicker() {
    final ls = labelStyle(context, widget?.enabled ?? true);
    return Container(
      child: widget?.visible == false
          ? null
          : GestureDetector(
              onTap: () {
                if (widget.enabled) _showDialog();
              },
              child: CSControl(
                nameWidget: Container(
                  width: widget?.labelWidth ??
                      CardSettings.of(context).labelWidth ??
                      120.0,
                  child: widget?.requiredIndicator != null
                      ? Text((widget?.label ?? "") + ' *', style: ls,)
                      : Text(widget?.label, style: ls,),
                ),
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

  Widget materialSettingsColorPicker() {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog();
      },
      child: CardSettingsField(
        label: widget?.label,
        labelAlign: widget?.labelAlign,
        labelWidth: widget?.labelWidth,
        enabled: widget?.enabled,
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
