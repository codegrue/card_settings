// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:async';

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:intl/intl.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_attributes.dart';

/// This is the date picker field
class CardSettingsDateTimePicker extends FormField<DateTime>
    implements ICommonFieldProperties {
  CardSettingsDateTimePicker(
      {Key key,
      bool autovalidate: false,
      FormFieldSetter<DateTime> onSaved,
      FormFieldValidator<DateTime> validator,
      DateTime initialValue,
      this.enabled = true,
      this.visible = true,
      this.label = 'Label',
      this.onChanged,
      this.contentAlign,
      this.icon,
      this.labelAlign,
      this.labelWidth,
      this.requiredIndicator,
      this.firstDate,
      this.lastDate,
      this.style,
      this.showMaterialonIOS,
      this.dateBuilder,
      this.timeBuilder})
      : super(
            key: key,
            initialValue: initialValue ?? DateTime.now(),
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<DateTime> field) =>
                (field as _CardSettingsDateTimePickerState)
                    ._build(field.context));

  @override
  final ValueChanged<DateTime> onChanged;

  @override
  final String label;

  @override
  final TextAlign labelAlign;

  @override
  final double labelWidth;

  @override
  final TextAlign contentAlign;

  final DateTime firstDate;

  final DateTime lastDate;

  @override
  final bool enabled;

  @override
  final Icon icon;

  @override
  final Widget requiredIndicator;

  @override
  final bool visible;

  final TextStyle style;

  @override
  final bool showMaterialonIOS;

  final Widget Function(BuildContext, Widget) dateBuilder;

  final Widget Function(BuildContext, Widget) timeBuilder;

  @override
  _CardSettingsDateTimePickerState createState() =>
      _CardSettingsDateTimePickerState();
}

class _CardSettingsDateTimePickerState extends FormFieldState<DateTime> {
  @override
  CardSettingsDateTimePicker get widget =>
      super.widget as CardSettingsDateTimePicker;

  void _showDialog() {
    DateTime _startDate = widget?.firstDate ?? DateTime.now();
    if ((value ?? DateTime.now()).isBefore(_startDate)) {
      _startDate = value;
    }
    final _endDate = widget?.lastDate ?? _startDate.add(Duration(days: 1800));

    // Using platform on web will result on a crash,
    if (showCupertino(context, widget.showMaterialonIOS))
      showCupertinoDateTimePopUp(_startDate, _endDate);
    else
      showMaterialDateTimePopUp(_startDate, _endDate);
  }

  Future<void> showCupertinoDateTimePopUp(
      DateTime _startDate, DateTime _endDate) {
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomPicker(
          CupertinoDatePicker(
            minimumDate: _startDate,
            minimumYear: _startDate.year,
            maximumDate: _endDate,
            maximumYear: _endDate.year,
            mode: CupertinoDatePickerMode.dateAndTime,
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

  void showMaterialDateTimePopUp(DateTime _startDate, DateTime _endDate) {
    showDatePicker(
        context: context,
        initialDate: value ?? DateTime.now(),
        firstDate: _startDate,
        lastDate: _endDate,
        builder: (BuildContext context, Widget child) {
          // return dateBuilder ??
          return Theme(
            data: Theme.of(context),
            child: child,
          );
        }).then((_date) async {
      if (_date != null) {
        await showTimePicker(
            context: context,
            initialTime: value != null
                ? TimeOfDay(hour: value.hour, minute: value.minute)
                : TimeOfDay.now(),
            builder: (BuildContext context, Widget child) {
              // return timeBuilder ??
              return Theme(
                data: Theme.of(context),
                child: child,
              );
            }).then((_time) {
          if (_time != null)
            _date = DateTime(
                _date.year, _date.month, _date.day, _time.hour, _time.minute);
        });
      }
      if (_date != null) {
        didChange(_date);
        if (widget.onChanged != null) widget.onChanged(_date);
      }
    });
  }

  Widget _build(BuildContext context) {
    if (showCupertino(context, widget.showMaterialonIOS))
      return cupertinoSettingsButton();
    else
      return materialSettingsButton();
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

  Widget cupertinoSettingsButton() {
    final ls = labelStyle(context, widget?.enabled ?? true);
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
                      ? Text((widget?.label ?? "") + ' *', style: ls,)
                      : Text(widget?.label, style: ls,),
                ),
                contentWidget: Text(
                  value == null ? '' : DateFormat.yMd().add_jms().format(value),
                  style: contentStyle(context, value, widget.enabled),
                  textAlign: widget?.contentAlign ??
                      CardSettings.of(context).contentAlign,
                ),
                style: CSWidgetStyle(icon: widget?.icon),
              ),
            ),
    );
  }

  Widget materialSettingsButton() {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog();
      },
      child: CardSettingsField(
        label: widget?.label ?? "Date Time",
        labelAlign: widget?.labelAlign,
        labelWidth: widget?.labelWidth,
        visible: widget?.visible ?? true,
        enabled: widget?.enabled,
        icon: widget?.icon ?? Icon(Icons.event),
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Text(
          value == null ? '' : DateFormat.yMd().add_jms().format(value),
          style: contentStyle(context, value, widget.enabled),
          textAlign:
              widget?.contentAlign ?? CardSettings.of(context).contentAlign,
        ),
        pickerIcon: (widget.enabled) ? Icons.arrow_drop_down : null,
      ),
    );
  }
}
