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
    this.requiredIndicator,
    this.labelAlign,
    this.icon,
    this.contentAlign,
    this.onChanged,
    this.showMaterialIOS = false,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> field) =>
                _CardSettingsSwitchState().widget);

  final String label;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final Icon icon;

  final Widget requiredIndicator;

  final String trueLabel;

  final String falseLabel;

  final ValueChanged<bool> onChanged;

  final bool visible;

  final bool showMaterialIOS;

  @override
  _CardSettingsSwitchState createState() => _CardSettingsSwitchState();
}

class _CardSettingsSwitchState extends FormFieldState<bool> {
  @override
  CardSettingsSwitch get widget => super.widget as CardSettingsSwitch;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && !widget.showMaterialIOS) {
      return CSControl(
          widget?.requiredIndicator != null
              ? (widget?.label ?? "") + ' *'
              : widget?.label,
          CupertinoSwitch(
            value: value,
            onChanged: (value) {
              didChange(value);
              if (widget?.onChanged != null) widget?.onChanged(value);
            },
          ),
          style: CSWidgetStyle(icon: widget?.icon));
    }
    return CardSettingsField(
      label: widget?.label,
      labelAlign: widget?.labelAlign,
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
            child: CupertinoSwitch(
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
