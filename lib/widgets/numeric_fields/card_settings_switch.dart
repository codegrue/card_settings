// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a field that allows a boolean to be set via a switch widget.
class CardSettingsSwitch extends FormField<bool>
    implements ICommonFieldProperties {
  CardSettingsSwitch({
    Key? key,
    // bool autovalidate: false,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    this.enabled = true,
    this.trueLabel = "Yes",
    this.falseLabel = "No",
    this.visible = true,
    this.label = 'Label',
    this.labelWidth,
    this.requiredIndicator,
    this.labelAlign,
    this.icon,
    this.contentAlign,
    this.onChanged,
    this.showMaterialonIOS,
    this.fieldPadding,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            // autovalidate: autovalidate,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<bool> field) =>
                (field as _CardSettingsSwitchState)._build(field.context));

  /// The text to identify the field to the user
  @override
  final String label;

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  /// controls how the widget in the content area of the field is aligned
  @override
  final TextAlign? contentAlign;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// The text to show if the switch is "on"
  final String trueLabel;

  /// The text to show if the switch if "off"
  final String falseLabel;

  /// Fires when the switch state is changed
  @override
  final ValueChanged<bool>? onChanged;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  @override
  _CardSettingsSwitchState createState() => _CardSettingsSwitchState();
}

class _CardSettingsSwitchState extends FormFieldState<bool> {
  @override
  CardSettingsSwitch get widget => super.widget as CardSettingsSwitch;

  Widget _build(BuildContext context) {
    if (showCupertino(context, widget.showMaterialonIOS))
      return _cupertinoSettingsSwitch();
    return _materialSettingsSwitch();
  }

  Widget _materialSettingsSwitch() {
    return CardSettingsField(
      label: widget.label,
      labelAlign: widget.labelAlign,
      labelWidth: widget.labelWidth,
      enabled: widget.enabled,
      visible: widget.visible,
      icon: widget.icon,
      requiredIndicator: widget.requiredIndicator,
      errorText: errorText,
      fieldPadding: widget.fieldPadding,
      content: Row(children: <Widget>[
        Expanded(
          child: Text(
            value! ? widget.trueLabel : widget.falseLabel,
            style: contentStyle(context, value, widget.enabled),
            textAlign:
                widget.contentAlign ?? CardSettings.of(context)?.contentAlign,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0.0),
          height: 20.0,
          child: Switch(
            value: value!,
            onChanged: (widget.enabled)
                ? (value) {
                    didChange(value);
                    if (widget.onChanged != null) widget.onChanged!(value);
                  }
                : null, // to disable, we need to not provide an onChanged function
          ),
        ),
      ]),
    );
  }

  Widget _cupertinoSettingsSwitch() {
    final ls = labelStyle(context, widget.enabled);
    return Container(
      child: widget.visible == false
          ? null
          : CSControl(
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
              contentWidget: CupertinoSwitch(
                value: value!,
                onChanged: (widget.enabled)
                    ? (value) {
                        didChange(value);
                        if (widget.onChanged != null) widget.onChanged!(value);
                      }
                    : null, // to disable, we need to not provide an onChanged function
              ),
              style: CSWidgetStyle(icon: widget.icon),
            ),
    );
  }
}
