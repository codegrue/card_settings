// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'dart:io';

import '../../card_settings.dart';

/// This is a list picker that allows an arbitrary list of options to be provided.
class CardSettingsListPicker extends FormField<String> {
  CardSettingsListPicker({
    Key key,
    String initialValue,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    bool autovalidate: false,
    this.label = 'Label',
    this.visible = true,
    this.onChanged,
    this.requiredIndicator,
    this.labelAlign,
    this.icon,
    this.contentAlign,
    this.hintText,
    this.options,
    this.showMaterialIOS = false,
  }) : super(
            key: key,
            initialValue: initialValue ?? null,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> field) =>
                _CardSettingsListPickerState().widget);

  final ValueChanged<String> onChanged;

  final String label;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final String hintText;

  final Icon icon;

  final Widget requiredIndicator;

  final List<String> options;

  final bool visible;

  final bool showMaterialIOS;

  @override
  _CardSettingsListPickerState createState() => _CardSettingsListPickerState();
}

class _CardSettingsListPickerState extends FormFieldState<String> {
  @override
  CardSettingsListPicker get widget => super.widget as CardSettingsListPicker;

  void _showDialog(String label, List<String> options) {
    if (Platform.isIOS && !widget.showMaterialIOS) {
      final FixedExtentScrollController scrollController =
          FixedExtentScrollController(
              initialItem: options.indexOf(value ?? options.first));
      showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) {
          return _buildBottomPicker(
            CupertinoPicker(
              scrollController: scrollController,
              itemExtent: kPickerItemHeight,
              backgroundColor: CupertinoColors.white,
              onSelectedItemChanged: (int index) {
                didChange(value);
                widget.onChanged(options[index]);
              },
              children: List<Widget>.generate(options.length, (int index) {
                return Center(
                  child: Text(options[index].toString()),
                );
              }),
            ),
          );
        },
      ).then((value) {
        if (value != null) {
          didChange(value);
          if (widget.onChanged != null) widget.onChanged(value);
        }
      });
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return PickerDialog(
            items: options,
            title: label,
            initialValue: value,
          );
        },
      ).then((value) {
        if (value != null) {
          didChange(value);
          if (widget.onChanged != null) widget.onChanged(value);
        }
      });
    }
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

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && !widget.showMaterialIOS) {
      return Container(
        child: widget?.visible == false
            ? null
            : GestureDetector(
                onTap: () {
                  _showDialog(widget?.label, widget?.options);
                },
                child: CSControl(
                  widget?.label,
                  Text(
                    widget?.initialValue ?? widget?.hintText ?? '',
                    style: Theme.of(context).textTheme.subhead.copyWith(
                        color: (value == null)
                            ? Theme.of(context).hintColor
                            : Theme.of(context).textTheme.subhead.color),
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
        _showDialog(widget?.label, widget?.options);
      },
      child: CardSettingsField(
        label: widget?.label,
        labelAlign: widget?.labelAlign,
        visible: widget?.visible,
        icon: widget?.icon,
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Text(
          widget?.initialValue ?? widget?.hintText ?? '',
          style: Theme.of(context).textTheme.subhead.copyWith(
              color: (value == null)
                  ? Theme.of(context).hintColor
                  : Theme.of(context).textTheme.subhead.color),
          textAlign:
              widget?.contentAlign ?? CardSettings.of(context).contentAlign,
        ),
        pickerIcon: Icons.arrow_drop_down,
      ),
    );
  }
}
