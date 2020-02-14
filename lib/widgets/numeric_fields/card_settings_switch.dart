// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';

/// This is a field that allows a boolean to be set via a switch widget.
class CardSettingsSwitch extends FormField<bool> {
  CardSettingsSwitch({
    Key key,
    bool autovalidate: false,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    bool initialValue = false,
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
    this.showMaterialonIOS = false,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> field) =>
                (field as _CardSettingsSwitchState)._build(field.context));

  final String label;

  final TextAlign labelAlign;

  final double labelWidth;

  final TextAlign contentAlign;

  final Icon icon;

  final Widget requiredIndicator;

  final String trueLabel;

  final String falseLabel;

  final ValueChanged<bool> onChanged;

  final bool visible;

  final bool showMaterialonIOS;

  @override
  _CardSettingsSwitchState createState() => _CardSettingsSwitchState();
}

class _CardSettingsSwitchState extends FormFieldState<bool> {
  @override
  CardSettingsSwitch get widget => super.widget as CardSettingsSwitch;

  Widget _build(BuildContext context) {
    if (Platform.isIOS && !widget.showMaterialonIOS) {
      return Container(
        child: widget?.visible == false
            ? null
            : CSControl(
                nameWidget: widget?.requiredIndicator != null
                    ? Text((widget?.label ?? "") + ' *')
                    : Text(widget?.label),
                contentWidget: CupertinoSwitch(
                  value: value,
                  onChanged: (value) {
                    didChange(value);
                    if (widget?.onChanged != null) widget?.onChanged(value);
                  },
                ),
                style: CSWidgetStyle(icon: widget?.icon),
              ),
      );
    }
    return CardSettingsField(
      label: widget?.label,
      labelAlign: widget?.labelAlign,
      labelWidth: widget?.labelWidth,
      visible: widget?.visible,
      icon: widget?.icon,
      requiredIndicator: widget?.requiredIndicator,
      errorText: errorText,
      content: Row(children: <Widget>[
        Expanded(
          child: Text(
            value ? widget?.trueLabel : widget?.falseLabel,
            style: Theme.of(context).textTheme.subhead,
            textAlign:
                widget?.contentAlign ?? CardSettings.of(context).contentAlign,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0.0),
          child: Container(
            height: 20.0,
            child: Switch(
              value: value,
              onChanged: (value) {
                didChange(value);
                if (widget?.onChanged != null) widget?.onChanged(value);
              },
            ),
          ),
        ),
      ]),
    );
  }
}
