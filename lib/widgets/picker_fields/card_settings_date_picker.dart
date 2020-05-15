// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.requiredIndicator,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
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

  final String label;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final DateTime firstDate;

  final DateTime lastDate;

  final DateFormat dateFormat;

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

    if (showCupertino(widget.showMaterialonIOS))
      showCupertinoDatePicker(_startDate, _endDate);
    else
      showMaterialDatePicker(_startDate, _endDate);
  }

  void showCupertinoDatePicker(DateTime _startDate, DateTime _endDate) {
    showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomPicker(
          CupertinoDatePicker(
            minimumDate: _startDate,
            minimumYear: _startDate.year,
            maximumDate: _endDate,
            maximumYear: _endDate.year,
            mode: CupertinoDatePickerMode.date,
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
  }

  void showMaterialDatePicker(DateTime _startDate, DateTime _endDate) {
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

  Widget _build(BuildContext context) {
    String formattedValue = (value == null)
        ? ''
        : (widget.dateFormat == null)
            ? DateFormat.yMd().format(value)
            : widget.dateFormat.format(value);

    if (showCupertino(widget.showMaterialonIOS))
      return cupertinoSettingsDatePicker(formattedValue);
    else
      return materialSettingsDatePicker(formattedValue);
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

  Widget cupertinoSettingsDatePicker(String formattedValue) {
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
                  formattedValue,
                  style: widget?.style ?? Theme.of(context).textTheme.subtitle1,
                  textAlign: widget?.contentAlign ??
                      CardSettings.of(context).contentAlign,
                ),
                style: CSWidgetStyle(icon: widget?.icon),
              ),
            ),
    );
  }

  Widget materialSettingsDatePicker(String formattedValue) {
    return GestureDetector(
      onTap: () {
        _showDialog();
      },
      child: CardSettingsField(
        label: widget?.label ?? "Date",
        labelAlign: widget?.labelAlign,
        visible: widget?.visible ?? true,
        icon: widget?.icon ?? Icon(Icons.event),
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Text(
          formattedValue,
          style: widget?.style ?? Theme.of(context).textTheme.subtitle1,
          textAlign:
              widget?.contentAlign ?? CardSettings.of(context).contentAlign,
        ),
        pickerIcon: Icons.arrow_drop_down,
      ),
    );
  }
}
