// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_attributes.dart';

/// This field allows a time to be selected.
class CardSettingsTimePicker extends FormField<TimeOfDay>
    implements ICommonFieldProperties {
  CardSettingsTimePicker({
    Key key,
    FormFieldSetter<TimeOfDay> onSaved,
    FormFieldValidator<TimeOfDay> validator,
    TimeOfDay initialValue,
    bool autovalidate: false,
    this.enabled = true,
    this.visible = true,
    this.onChanged,
    this.contentAlign,
    this.requiredIndicator,
    this.labelAlign,
    this.labelWidth,
    this.label = 'Label',
    this.icon,
    this.style,
    this.showMaterialonIOS,
  }) : super(
          key: key,
          initialValue: initialValue ?? TimeOfDay.now(),
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<TimeOfDay> field) =>
              (field as _CardSettingsTimePickerState)._build(field.context),
        );

  @override
  final ValueChanged<TimeOfDay> onChanged;

  @override
  final TextAlign labelAlign;

  @override
  final TextAlign contentAlign;

  @override
  final Icon icon;

  @override
  final bool enabled;

  @override
  final Widget requiredIndicator;

  @override
  final bool visible;

  @override
  final String label;

  @override
  final double labelWidth;

  final TextStyle style;

  @override
  final bool showMaterialonIOS;

  @override
  _CardSettingsTimePickerState createState() => _CardSettingsTimePickerState();
}

class _CardSettingsTimePickerState extends FormFieldState<TimeOfDay> {
  @override
  CardSettingsTimePicker get widget => super.widget as CardSettingsTimePicker;

  void _showDialog() {
    if (showCupertino(context, widget.showMaterialonIOS)) {
      showCupertinoPopUpTimePicker();
    } else
      showMaterialPopUpTimePicker();
  }

  Widget _build(BuildContext context) {
    if (showCupertino(context, widget.showMaterialonIOS))
      return cupertinoSettingsTimePicker();
    else
      return materialSettingsTimePicker();
  }

  Widget _buildBottomPicker(BuildContext context, Widget picker) {
    return Container(
      height: kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0 * MediaQuery.of(context).textScaleFactor,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  void showCupertinoPopUpTimePicker() {
    showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomPicker(
          context,
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: value == null
                ? DateTime.now()
                : DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, value.hour, value.minute),
            onDateTimeChanged: (DateTime newDateTime) {
              didChange(TimeOfDay.fromDateTime(newDateTime));
              if (widget.onChanged != null)
                widget.onChanged(TimeOfDay.fromDateTime(newDateTime));
            },
          ),
        );
      },
    ).then((_value) {
      if (_value != null) {
        didChange(TimeOfDay.fromDateTime(_value));
        if (widget.onChanged != null)
          widget.onChanged(TimeOfDay.fromDateTime(_value));
      }
    });
  }

  void showMaterialPopUpTimePicker() {
    showTimePicker(
      context: context,
      initialTime: value,
    ).then((_value) {
      if (_value != null) {
        didChange(_value);
        if (widget.onChanged != null) widget.onChanged(_value);
      }
    });
  }

  Widget cupertinoSettingsTimePicker() {
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
                      ? Text((widget?.label ?? "") + ' *')
                      : Text(widget?.label),
                ),
                contentWidget: Text(
                  value == null ? '' : value.format(context),
                  style: contentStyle(context, value, widget.enabled),
                  textAlign: widget?.contentAlign ??
                      CardSettings.of(context).contentAlign,
                ),
                style: CSWidgetStyle(icon: widget?.icon),
              ),
            ),
    );
  }

  Widget materialSettingsTimePicker() {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog();
      },
      child: CardSettingsField(
        label: widget?.label ?? "Time",
        labelAlign: widget?.labelAlign,
        labelWidth: widget?.labelWidth,
        visible: widget?.visible ?? true,
        icon: widget?.icon ?? Icon(Icons.event),
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Text(
          value == null ? '' : value.format(context),
          style: contentStyle(context, value, widget.enabled),
          textAlign:
              widget?.contentAlign ?? CardSettings.of(context).contentAlign,
        ),
        pickerIcon: (widget.enabled) ? Icons.arrow_drop_down : null,
      ),
    );
  }
}
