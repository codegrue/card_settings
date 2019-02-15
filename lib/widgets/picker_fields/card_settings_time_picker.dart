// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../card_settings.dart';

/// This field allows a time to be selected.
class CardSettingsTimePicker extends FormField<TimeOfDay> {
  CardSettingsTimePicker({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    TimeOfDay initialValue,
    Icon icon,
    Widget requiredIndicator,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<TimeOfDay> onSaved,
    this.onChanged,
    FormFieldValidator<TimeOfDay> validator,
  }) : super(
          key: key,
          initialValue: initialValue ?? TimeOfDay.now(),
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<TimeOfDay> field) =>
              _CardSettingsTimePickerState(
                style: Theme.of(field.context).textTheme.subhead,
                textAlign:
                    contentAlign ?? CardSettings.of(field.context).contentAlign,
                icon: icon,
                labelAlign: labelAlign,
                requiredIndicator: requiredIndicator,
                visible: visible,
              ).widget,
        );

  final ValueChanged<TimeOfDay> onChanged;

  @override
  _CardSettingsTimePickerState createState() => _CardSettingsTimePickerState();
}

class _CardSettingsTimePickerState extends FormFieldState<TimeOfDay> {
  @override
  CardSettingsTimePicker get widget => super.widget as CardSettingsTimePicker;

  _CardSettingsTimePickerState({
    this.icon,
    this.label,
    this.labelAlign,
    this.requiredIndicator,
    this.style,
    this.textAlign,
    this.visible,
  });

  final String label;
  final TextAlign labelAlign;
  final Icon icon;
  final Widget requiredIndicator;
  final bool visible;
  final TextStyle style;
  final TextAlign textAlign;

  void _showDialog({bool showFullTimer = false}) {
    if (Platform.isIOS && !showFullTimer) {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialog();
      },
      onLongPress: () {
        _showDialog(showFullTimer: true);
      },
      child: CardSettingsField(
        label: label ?? "Time",
        labelAlign: labelAlign,
        visible: visible ?? true,
        icon: icon ?? Icon(Icons.event),
        requiredIndicator: requiredIndicator,
        errorText: errorText,
        content: Text(
          value == null ? '' : value.format(context),
          style: style,
          textAlign: textAlign,
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
