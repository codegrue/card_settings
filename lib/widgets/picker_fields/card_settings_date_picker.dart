// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:intl/intl.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is the date picker field
class CardSettingsDatePicker extends FormField<DateTime>
    implements ICommonFieldProperties {
  CardSettingsDatePicker({
    Key? key,
    // bool autovalidate: false,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    DateTime? initialValue,
    this.enabled = true,
    this.visible = true,
    this.label = 'Date',
    this.onChanged,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.labelWidth,
    this.requiredIndicator,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.style,
    this.showMaterialonIOS,
    this.fieldPadding,
  }) : super(
            key: key,
            initialValue: initialValue ?? DateTime.now(),
            onSaved: onSaved,
            validator: validator,
            // autovalidate: autovalidate,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<DateTime> field) =>
                (field as _CardSettingsDatePickerState)._build(field.context));

  /// fires when the picker value changes
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

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// the first date in the selectable picker range
  final DateTime? firstDate;

  /// the last date in the selectable picker range
  final DateTime? lastDate;

  /// the format to show the date in the field
  final DateFormat? dateFormat;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// The label style
  final TextStyle? style;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  @override
  _CardSettingsDatePickerState createState() => _CardSettingsDatePickerState();
}

class _CardSettingsDatePickerState extends FormFieldState<DateTime> {
  @override
  CardSettingsDatePicker get widget => super.widget as CardSettingsDatePicker;

  void _showDialog() {
    DateTime _startDate = widget.firstDate ?? DateTime.now();
    if ((value ?? DateTime.now()).isBefore(_startDate)) {
      _startDate = value!;
    }
    final _endDate = widget.lastDate ?? _startDate.add(Duration(days: 1800));

    if (showCupertino(context, widget.showMaterialonIOS))
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

  void showMaterialDatePicker(DateTime _startDate, DateTime _endDate) {
    showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: _startDate,
      lastDate: _endDate,
    ).then((_value) {
      if (_value != null) {
        didChange(_value);
        if (widget.onChanged != null) widget.onChanged!(_value);
      }
    });
  }

  Widget _build(BuildContext context) {
    String formattedValue = (value == null)
        ? ''
        : (widget.dateFormat == null)
            ? DateFormat.yMd().format(value!)
            : widget.dateFormat!.format(value!);

    if (showCupertino(context, widget.showMaterialonIOS))
      return _cupertinoSettingsDatePicker(formattedValue);
    else
      return _materialSettingsDatePicker(formattedValue);
  }

  Widget _buildBottomPicker(Widget picker) {
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

  Widget _cupertinoSettingsDatePicker(String formattedValue) {
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
                contentWidget: Text(
                  formattedValue,
                  style: contentStyle(context, value, widget.enabled),
                  textAlign: widget.contentAlign ??
                      CardSettings.of(context)?.contentAlign,
                ),
                style: CSWidgetStyle(icon: widget.icon),
              ),
            ),
    );
  }

  Widget _materialSettingsDatePicker(String formattedValue) {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog();
      },
      child: CardSettingsField(
        label: widget.label,
        labelAlign: widget.labelAlign,
        labelWidth: widget.labelWidth,
        enabled: widget.enabled,
        visible: widget.visible,
        icon: widget.icon ?? Icon(Icons.event),
        requiredIndicator: widget.requiredIndicator,
        errorText: errorText,
        fieldPadding: widget.fieldPadding,
        content: Text(
          formattedValue,
          style: contentStyle(context, value, widget.enabled),
          textAlign:
              widget.contentAlign ?? CardSettings.of(context)?.contentAlign,
        ),
        pickerIcon: (widget.enabled) ? Icons.arrow_drop_down : null,
      ),
    );
  }
}
