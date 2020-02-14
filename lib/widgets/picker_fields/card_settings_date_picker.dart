// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:intl/intl.dart';

import '../../card_settings.dart';

/// This is the date picker field
class CardSettingsDatePicker extends FormField<DateTime> {
  CardSettingsDatePicker({
    Key key,
    bool autovalidate: false,
    FormFieldSetter<DateTime> onSaved,
    FormFieldValidator<DateTime> validator,
    DateTime initialValue,
    this.visible = true,
    this.label = 'Label',
    this.onChanged,
    this.justDate = false,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.requiredIndicator,
    this.firstDate,
    this.lastDate,
    this.style,
    this.showMaterialonIOS = false,
  }) : super(
            key: key,
            initialValue: initialValue ?? DateTime.now(),
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<DateTime> field) =>
                (field as _CardSettingsDatePickerState)._build(field.context));

  final ValueChanged<DateTime> onChanged;

  final bool justDate;

  final String label;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final DateTime firstDate;

  final DateTime lastDate;

  final Icon icon;

  final Widget requiredIndicator;

  final bool visible;

  final TextStyle style;

  final bool showMaterialonIOS;

  @override
  _CardSettingsDatePickerState createState() => _CardSettingsDatePickerState();
}

class _CardSettingsDatePickerState extends FormFieldState<DateTime> {
  @override
  CardSettingsDatePicker get widget => super.widget as CardSettingsDatePicker;

  void _showDialog() {
    DateTime _startDate = widget?.firstDate ?? DateTime.now();
    if ((value ?? DateTime.now()).isBefore(_startDate)) {
      _startDate = value;
    }
    final _endDate = widget?.lastDate ?? _startDate.add(Duration(days: 1800));

    if (Platform.isIOS && !widget.showMaterialonIOS) {
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
                    value == null ? '' : DateFormat.yMd().format(value),
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
        label: widget?.label ?? (widget.justDate ? "Date" : "Date Time"),
        labelAlign: widget?.labelAlign,
        visible: widget?.visible ?? true,
        icon: widget?.icon ?? Icon(Icons.event),
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Text(
          value == null ? '' : DateFormat.yMd().format(value),
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
