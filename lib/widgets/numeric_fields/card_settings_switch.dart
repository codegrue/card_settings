// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_attributes.dart';

/// This is a field that allows a boolean to be set via a switch widget.
class CardSettingsSwitch extends FormField<bool>
    implements ICommonFieldProperties {
  CardSettingsSwitch({
    Key key,
    bool autovalidate: false,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
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
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> field) =>
                (field as _CardSettingsSwitchState)._build(field.context));

  @override
  final String label;

  @override
  final bool enabled;

  @override
  final TextAlign labelAlign;

  @override
  final double labelWidth;

  @override
  final TextAlign contentAlign;

  @override
  final Icon icon;

  @override
  final Widget requiredIndicator;

  final String trueLabel;

  final String falseLabel;

  @override
  final ValueChanged<bool> onChanged;

  @override
  final bool visible;

  @override
  final bool showMaterialonIOS;

  @override
  _CardSettingsSwitchState createState() => _CardSettingsSwitchState();
}

class _CardSettingsSwitchState extends FormFieldState<bool> {
  @override
  CardSettingsSwitch get widget => super.widget as CardSettingsSwitch;

  Widget _build(BuildContext context) {
    if (showCupertino(context, widget.showMaterialonIOS))
      return cupertinoSettingsSwitch();
    return materialSettingsSwitch();
  }

  Widget materialSettingsSwitch() {
    return CardSettingsField(
      label: widget?.label,
      labelAlign: widget?.labelAlign,
      labelWidth: widget?.labelWidth,
      enabled: widget?.enabled,
      visible: widget?.visible,
      icon: widget?.icon,
      requiredIndicator: widget?.requiredIndicator,
      errorText: errorText,
      content: Row(children: <Widget>[
        Expanded(
          child: Text(
            value ? widget?.trueLabel : widget?.falseLabel,
            style: contentStyle(context, value, widget.enabled),
            textAlign:
                widget?.contentAlign ?? CardSettings.of(context).contentAlign,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0.0),
          height: 20.0,
          child: Switch(
            value: value,
            onChanged: (widget.enabled)
                ? (value) {
                    didChange(value);
                    if (widget?.onChanged != null) widget?.onChanged(value);
                  }
                : null, // to disable, we need to not provide an onChanged function
          ),
        ),
      ]),
    );
  }

  Widget cupertinoSettingsSwitch() {
    final ls = labelStyle(context, widget?.enabled ?? true);
    return Container(
      child: widget?.visible == false
          ? null
          : CSControl(
              nameWidget: Container(
                width: widget?.labelWidth ??
                    CardSettings.of(context).labelWidth ??
                    120.0,
                child: widget?.requiredIndicator != null
                    ? Text(
                        (widget?.label ?? "") + ' *',
                        style: ls,
                      )
                    : Text(
                        widget?.label,
                        style: ls,
                      ),
              ),
              contentWidget: CupertinoSwitch(
                value: value,
                onChanged: (widget.enabled)
                    ? (value) {
                        didChange(value);
                        if (widget?.onChanged != null) widget?.onChanged(value);
                      }
                    : null, // to disable, we need to not provide an onChanged function
              ),
              style: CSWidgetStyle(icon: widget?.icon),
            ),
    );
  }
}
