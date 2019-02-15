// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../../card_settings.dart';
/// This is a list picker that allows an arbitrary list of options to be provided.
class CardSettingsListPicker extends FormField<String> {
  CardSettingsListPicker({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    String initialValue,
    String hintText,
    Icon icon,
    Widget requiredIndicator,
    List<String> options,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    this.onChanged,
  }) : super(
            key: key,
            initialValue: initialValue ?? null,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> field) {
              // final _CardSettingsListPickerState state = field;
              return GestureDetector(
                onTap: () {
                  _CardSettingsListPickerState._showDialog(label, options);
                },
                child: CardSettingsField(
                  label: label,
                  labelAlign: labelAlign,
                  visible: visible,
                  icon: icon,
                  requiredIndicator: requiredIndicator,
                  errorText: field.errorText,
                  content: Text(
                    field.value ?? hintText ?? '',
                    style: Theme.of(field.context).textTheme.subhead.copyWith(
                        color: (field.value == null)
                            ? Theme.of(field.context).hintColor
                            : Theme.of(field.context).textTheme.subhead.color),
                    textAlign: contentAlign ??
                        CardSettings.of(field.context).contentAlign,
                  ),
                  pickerIcon: Icons.arrow_drop_down,
                ),
              );
            });

  final ValueChanged<String> onChanged;

  @override
  _CardSettingsListPickerState createState() => _CardSettingsListPickerState();
}

class _CardSettingsListPickerState extends FormFieldState<String> {
  @override
  CardSettingsListPicker get widget => super.widget as CardSettingsListPicker;

  void _showDialog(String label, List<String> options) {
    if (Platform.isIOS) {
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
}
