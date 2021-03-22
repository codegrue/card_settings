// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This allows selection of which variant of the color picker you would like to use
enum CardSettingsColorPickerType { colors, material, block }

/// This is the color picker field
class CardSettingsColorPicker extends FormField<Color>
    implements ICommonFieldProperties {
  CardSettingsColorPicker({
    Key? key,
    // bool autovalidate: false,
    FormFieldSetter<Color>? onSaved,
    FormFieldValidator<Color>? validator,
    Color initialValue = Colors.green,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
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
    this.fieldPadding,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<Color> field) =>
                (field as _CardSettingsColorPickerState)._build(field.context));

  /// Fires when the color value changes
  @override
  final ValueChanged<Color>? onChanged;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  /// controls how the widget in the content area of the field is aligned
  // here for consistency, but does nothing.
  @override
  final TextAlign? contentAlign;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// The text to identify the field to the user
  @override
  final String label;

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  /// the specific variant of the color picker to use
  final CardSettingsColorPickerType pickerType;

  @override
  _CardSettingsColorPickerState createState() =>
      _CardSettingsColorPickerState();
}

class _CardSettingsColorPickerState extends FormFieldState<Color> {
  @override
  CardSettingsColorPicker get widget => super.widget as CardSettingsColorPicker;

  Color pickerColor = Colors.green;

  void _showDialog() {
    pickerColor = value!;

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
            didChange(value);
            if (widget.onChanged != null) widget.onChanged!(value);
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
            didChange(value);
            if (widget.onChanged != null) widget.onChanged!(value);
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
            didChange(value);
            if (widget.onChanged != null) widget.onChanged!(value);
          },
        );
        break;
    }
  }

  Widget _build(BuildContext context) {
    if (showCupertino(context, widget.showMaterialonIOS))
      return _cupertinoSettingsColorPicker();
    else
      return _materialSettingsColorPicker();
  }

  Widget _cupertinoSettingsColorPicker() {
    final ls = labelStyle(context, widget.enabled);
    return Container(
      child: widget.visible == false
          ? null
          : GestureDetector(
              onTap: () {
                if (widget.enabled) _showDialog();
              },
              child: CSControl(
                nameWidget: Container(
                  width: widget.labelWidth ??
                      CardSettings.of(context)?.labelWidth ??
                      120.0,
                  child: widget.requiredIndicator != null
                      ? Text(
                          (widget.label) + ' *',
                          style: ls,
                        )
                      : Text(
                          widget.label,
                          style: ls,
                        ),
                ),
                contentWidget: Container(
                  height: 20.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: value,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                style: CSWidgetStyle(icon: widget.icon),
              ),
            ),
    );
  }

  Widget _materialSettingsColorPicker() {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog();
      },
      child: CardSettingsField(
        label: widget.label,
        labelAlign: widget.labelAlign,
        labelWidth: widget.labelWidth,
        enabled: widget.enabled,
        visible: widget.visible,
        icon: widget.icon,
        requiredIndicator: widget.requiredIndicator,
        errorText: errorText,
        fieldPadding: widget.fieldPadding,
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
