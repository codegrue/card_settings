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
import '../../interfaces/common_field_properties.dart';

/// This is the date picker field
class CardSettingsDateTimePicker extends FormField<DateTime>
    implements ICommonFieldProperties {
  CardSettingsDateTimePicker({
    Key? key,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    DateTime? initialValue,
    this.enabled = true,
    this.visible = true,
    this.label = "Date Time",
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
    this.fieldPadding,
    this.dateBuilder,
    this.timeBuilder,
  }) : super(
            key: key,
            initialValue: initialValue ?? DateTime.now(),
            onSaved: onSaved,
            validator: validator,
            // autovalidate: autovalidate,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<DateTime> field) =>
                (field as _CardSettingsDateTimePickerState)
                    ._build(field.context));

  /// fires when the picker value is changed
  @override
  final ValueChanged<DateTime>? onChanged;

  /// The text to identify the field to the user
  @override
  final String label;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  /// controls how the widget in the content area of the field is aligned
  @override
  final TextAlign? contentAlign;

  /// the first date in the selectable picker range
  final DateTime? firstDate;

  /// the last date in the selectable picker range
  final DateTime? lastDate;

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// the style of the label text
  final TextStyle? style;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  final Widget Function(BuildContext, Widget)? dateBuilder;

  final Widget Function(BuildContext, Widget)? timeBuilder;

  @override
  _CardSettingsDateTimePickerState createState() =>
      _CardSettingsDateTimePickerState();
}

class _CardSettingsDateTimePickerState extends FormFieldState<DateTime> {
  @override
  CardSettingsDateTimePicker get widget =>
      super.widget as CardSettingsDateTimePicker;

  void _showDialog() {
    DateTime _startDate = widget.firstDate ?? DateTime.now();
    if ((value ?? DateTime.now()).isBefore(_startDate)) {
      _startDate = value!;
    }
    final _endDate = widget.lastDate ?? _startDate.add(Duration(days: 1800));

    // Using platform on web will result on a crash,
    if (showCupertino(context, widget.showMaterialonIOS))
      _showCupertinoDateTimePopUp(_startDate, _endDate);
    else
      _showMaterialDateTimePopUp(_startDate, _endDate);
  }

  Future<void> _showCupertinoDateTimePopUp(
      DateTime _startDate, DateTime _endDate) {
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return _buildCupertinoBottomPicker(
          CupertinoDatePicker(
            minimumDate: _startDate,
            minimumYear: _startDate.year,
            maximumDate: _endDate,
            maximumYear: _endDate.year,
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: value ?? DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              didChange(newDateTime);
              if (widget.onChanged != null) widget.onChanged!(newDateTime);
            },
          ),
        );
      },
    ).then((_value) {
      if (_value != null) {
        didChange(_value);
        if (widget.onChanged != null) widget.onChanged!(_value);
      }
    });
  }

  void _showMaterialDateTimePopUp(DateTime _startDate, DateTime _endDate) {
    showDatePicker(
        context: context,
        initialDate: value ?? DateTime.now(),
        firstDate: _startDate,
        lastDate: _endDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context),
            child: child!,
          );
        }).then((_date) async {
      if (_date != null) {
        await showTimePicker(
            context: context,
            initialTime: value != null
                ? TimeOfDay(hour: value!.hour, minute: value!.minute)
                : TimeOfDay.now(),
            builder: (BuildContext context, Widget? child) {
              // return timeBuilder ??
              return Theme(
                data: Theme.of(context),
                child: child!,
              );
            }).then((_time) {
          if (_time != null)
            _date = DateTime(_date!.year, _date!.month, _date!.day, _time.hour,
                _time.minute);
        });
      }
      if (_date != null) {
        didChange(_date);
        if (widget.onChanged != null) widget.onChanged!(_date!);
      }
    });
  }

  Widget _build(BuildContext context) {
    if (showCupertino(context, widget.showMaterialonIOS))
      return _cupertinoSettingsButton();
    else
      return _materialSettingsButton();
  }

  Widget _buildCupertinoBottomPicker(Widget picker) {
    return Container(
      height: kCupertinoPickerSheetHeight,
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

  Widget _cupertinoSettingsButton() {
    final ls = labelStyle(context, widget.enabled);
    return Container(
      child: widget.visible == false
          ? null
          : GestureDetector(
              onTap: () {
                if (widget.enabled) _showDialog();
              },
              child: CSControl(
                nameWidget: Container(
                  width: widget.labelWidth ??
                      CardSettings.of(context)?.labelWidth ??
                      120.0,
                  child: widget.requiredIndicator != null
                      ? Text(
                          (widget.label) + ' *',
                          style: ls,
                        )
                      : Text(
                          widget.label,
                          style: ls,
                        ),
                ),
                contentWidget: Flexible(
                  child: Text(
                    value == null
                        ? ''
                        : DateFormat.yMd().add_jm().format(value!),
                    style: contentStyle(context, value, widget.enabled),
                    overflow: TextOverflow.ellipsis,
                    textAlign: widget.contentAlign ??
                        CardSettings.of(context)?.contentAlign,
                  ),
                ),
                style: CSWidgetStyle(icon: widget.icon),
              ),
            ),
    );
  }

  Widget _materialSettingsButton() {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog();
      },
      child: CardSettingsField(
        label: widget.label,
        labelAlign: widget.labelAlign,
        labelWidth: widget.labelWidth,
        visible: widget.visible,
        enabled: widget.enabled,
        icon: widget.icon ?? Icon(Icons.event),
        requiredIndicator: widget.requiredIndicator,
        errorText: errorText,
        fieldPadding: widget.fieldPadding,
        content: Text(
          value == null ? '' : DateFormat.yMd().add_jm().format(value!),
          style: contentStyle(context, value, widget.enabled),
          overflow: TextOverflow.ellipsis,
          textAlign:
              widget.contentAlign ?? CardSettings.of(context)?.contentAlign,
        ),
        pickerIcon: (widget.enabled) ? Icons.arrow_drop_down : null,
      ),
    );
  }
}
