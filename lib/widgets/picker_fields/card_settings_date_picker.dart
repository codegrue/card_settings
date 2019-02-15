// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../card_settings.dart';

/// This is the date picker field
class CardSettingsDatePicker extends FormField<DateTime> {
  CardSettingsDatePicker({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    DateTime initialValue,
    DateTime firstDate,
    DateTime lastDate,
    Icon icon,
    Widget requiredIndicator,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<DateTime> onSaved,
    this.onChanged,
    this.justDate = false,
    FormFieldValidator<DateTime> validator,
  }) : super(
          key: key,
          initialValue: initialValue ?? DateTime.now(),
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<DateTime> field) =>
              _CardSettingsDatePickerState(
                style: Theme.of(field.context).textTheme.subhead,
                textAlign:
                    contentAlign ?? CardSettings.of(field.context).contentAlign,
  
                icon: icon,
                labelAlign: labelAlign,
                requiredIndicator: requiredIndicator,
                visible: visible,
                startDate: firstDate,
                endDate: lastDate,
              ).widget,
        );

  final ValueChanged<DateTime> onChanged;
  final bool justDate;

  @override
  _CardSettingsDatePickerState createState() => _CardSettingsDatePickerState();
}

class _CardSettingsDatePickerState extends FormFieldState<DateTime> {
  @override
  CardSettingsDatePicker get widget => super.widget as CardSettingsDatePicker;

  _CardSettingsDatePickerState({
    this.icon,
    this.label,
    this.labelAlign,
    this.requiredIndicator,
    this.style,
    this.textAlign,
    this.visible,
    this.endDate,
    this.startDate,
  });

  final String label;
  final TextAlign labelAlign;
  final Icon icon;
  final Widget requiredIndicator;
  final bool visible;
  final TextStyle style;
  final TextAlign textAlign;
  final DateTime startDate;
  final DateTime endDate;

  void _showDialog({bool showFullCalendar = false}) {
    DateTime _startDate = startDate ?? DateTime.now();
    if ((value ?? DateTime.now()).isBefore(_startDate)) {
      _startDate = value;
    }
    final _endDate = endDate ?? _startDate.add(Duration(days: 1800));
    if (Platform.isIOS && !showFullCalendar) {
      showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) {
          return _buildBottomPicker(
            CupertinoDatePicker(
              minimumDate: _startDate,
              minimumYear: _startDate.year,
              maximumDate: _endDate,
              maximumYear: _endDate.year,
              mode: widget.justDate
                  ? CupertinoDatePickerMode.date
                  : CupertinoDatePickerMode.dateAndTime,
              initialDateTime: value ?? DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                didChange(newDateTime);
                if (widget.onChanged != null) widget.onChanged(newDateTime);
              },
            ),
          );
        },
      ).then((_value) {
        if (_value != null) {
          didChange(_value);
          if (widget.onChanged != null) widget.onChanged(_value);
        }
      });
    } else {
      showDatePicker(
        context: context,
        initialDate: value ?? DateTime.now(),
        firstDate: _startDate,
        lastDate: _endDate,
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
        _showDialog(showFullCalendar: true);
      },
      child: CardSettingsField(
        label: label ?? (widget.justDate ? "Date" : "Date Time"),
        labelAlign: labelAlign,
        visible: visible ?? true,
        icon: icon ?? Icon(Icons.event),
        requiredIndicator: requiredIndicator,
        errorText: errorText,
        content: Text(
          value == null ? '' : DateFormat.yMd().format(value),
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
