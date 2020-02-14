// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';

/// This field allows a time to be selected.
class CardSettingsTimePicker extends FormField<TimeOfDay> {
  CardSettingsTimePicker({
    Key key,
    FormFieldSetter<TimeOfDay> onSaved,
    FormFieldValidator<TimeOfDay> validator,
    TimeOfDay initialValue,
    bool autovalidate: false,
    bool enabled = true,
    this.visible = true,
    this.onChanged,
    this.contentAlign,
    this.requiredIndicator,
    this.labelAlign,
    this.label = 'Label',
    this.icon,
    this.style,
    this.showMaterialonIOS = false,
  }) : super(
          key: key,
          initialValue: initialValue ?? TimeOfDay.now(),
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<TimeOfDay> field) =>
              (field as _CardSettingsTimePickerState)._build(field.context),
        );

  final ValueChanged<TimeOfDay> onChanged;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final Icon icon;

  final Widget requiredIndicator;

  final bool visible;

  final String label;

  final TextStyle style;

  final bool showMaterialonIOS;

  @override
  _CardSettingsTimePickerState createState() => _CardSettingsTimePickerState();
}

class _CardSettingsTimePickerState extends FormFieldState<TimeOfDay> {
  @override
  CardSettingsTimePicker get widget => super.widget as CardSettingsTimePicker;

  void _showDialog() {
    if (Platform.isIOS && !widget.showMaterialonIOS) {
      showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) {
          return _buildBottomPicker(
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
    } else {
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
                  contentWidget: Text(
                    value == null ? '' : value.format(context),
                    style: widget?.style ?? Theme.of(context).textTheme.subhead,
                    textAlign: widget?.contentAlign ??
                        CardSettings.of(context).contentAlign,
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
        label: widget?.label ?? "Time",
        labelAlign: widget?.labelAlign,
        visible: widget?.visible ?? true,
        icon: widget?.icon ?? Icon(Icons.event),
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Text(
          value == null ? '' : value.format(context),
          style: widget?.style ?? Theme.of(context).textTheme.subhead,
          textAlign:
              widget?.contentAlign ?? CardSettings.of(context).contentAlign,
        ),
        pickerIcon: Icons.arrow_drop_down,
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
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
}
