// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

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
    this.values,
    this.showMaterialonIOS = false,
  })  : assert(values == null || options.length == values.length,
            "If you provide 'values', they need the same number as 'options'"),
        super(
            key: key,
            initialValue: initialValue ?? null,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> field) =>
                (field as _CardSettingsListPickerState)._build(field.context));

  final ValueChanged<String> onChanged;

  final String label;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final String hintText;

  final Icon icon;

  final Widget requiredIndicator;

  final List<String> options;

  final List<String> values;

  final bool visible;

  final bool showMaterialonIOS;

  @override
  _CardSettingsListPickerState createState() => _CardSettingsListPickerState();
}

class _CardSettingsListPickerState extends FormFieldState<String> {
  @override
  CardSettingsListPicker get widget => super.widget as CardSettingsListPicker;

  List<String> values;
  List<String> options;

  void _showDialog(String label) {
    int optionIndex = values.indexOf(value);
    String option;
    if (optionIndex >= 0) {
      option = options[optionIndex];
    } else {
      optionIndex = 0; // set to first element in the list
    }

    if (Platform.isIOS && !widget.showMaterialonIOS) {
      _showCupertinoBottomPicker(optionIndex);
    } else {
      _showMaterialScrollPicker(label, option);
    }
  }

  void _showCupertinoBottomPicker(int optionIndex) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: optionIndex);
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) {
        return _buildCupertinoBottomPicker(
          CupertinoPicker(
            scrollController: scrollController,
            itemExtent: kPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (int index) {
              didChange(values[index]);
              widget.onChanged(values[index]);
            },
            children: List<Widget>.generate(options.length, (int index) {
              return Center(
                child: Text(options[index].toString()),
              );
            }),
          ),
        );
      },
    ).then((option) {
      if (option != null) {
        String value = values[options.indexOf(option) ?? 0];
        didChange(value);
        if (widget.onChanged != null) widget.onChanged(value);
      }
    });
  }

  void _showMaterialScrollPicker(String label, String option) {
    showMaterialScrollPicker(
      context: context,
      title: label,
      items: options,
      selectedItem: option,
      onChanged: (option) {
        if (option != null) {
          int optionIndex = options.indexOf(option);
          String value = values[optionIndex];
          didChange(value);
          if (widget.onChanged != null) widget.onChanged(value);
        }
      },
    );
  }

  Widget _buildCupertinoBottomPicker(Widget picker) {
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

  Widget _build(BuildContext context) {
    // make local mutable copies of values and options
    options = widget.options;
    if (widget.values == null) {
      // if values are not provided, copy the options over and use those
      values = widget.options;
    } else {
      values = widget.values;
    }

    // get the content label from options based on value
    int optionIndex = values.indexOf(value);
    String content = widget?.hintText ?? '';
    if (optionIndex >= 0) {
      content = options[optionIndex];
    }

    if (Platform.isIOS && !widget.showMaterialonIOS) {
      return Container(
        child: widget?.visible == false
            ? null
            : GestureDetector(
                onTap: () {
                  _showDialog(widget?.label);
                },
                child: CSControl(
                  nameWidget: widget?.requiredIndicator != null
                      ? Text((widget?.label ?? "") + ' *')
                      : Text(widget?.label),
                  contentWidget: Text(
                    content,
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
        _showDialog(widget?.label);
      },
      child: CardSettingsField(
        label: widget?.label,
        labelAlign: widget?.labelAlign,
        visible: widget?.visible,
        icon: widget?.icon,
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Text(
          content,
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
