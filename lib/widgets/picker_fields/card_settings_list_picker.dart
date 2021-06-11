// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a list picker that allows an arbitrary list of options to be provided.
class CardSettingsListPicker<T> extends FormField<T>
    implements ICommonFieldProperties {
  CardSettingsListPicker({
    Key? key,
    T? initialItem,
    FormFieldSetter<T?>? onSaved,
    FormFieldValidator<T?>? validator,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    this.enabled = true,
    this.label = 'Label',
    this.visible = true,
    this.onChanged,
    this.requiredIndicator,
    this.labelAlign,
    this.labelWidth,
    this.icon,
    this.contentAlign,
    this.hintText,
    required this.items,
    this.showMaterialonIOS,
    this.fieldPadding,
  }) : super(
            key: key,
            initialValue: initialItem ?? null,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<T> field) =>
                (field as _CardSettingsListPickerState)._build(field.context));

  /// fires when the picker value is changed
  @override
  final ValueChanged<T>? onChanged;

  /// The text to identify the field to the user
  @override
  final String label;

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  /// controls how the widget in the content area of the field is aligned
  @override
  final TextAlign? contentAlign;

  /// text to display to guide the user on what to enter
  final String? hintText;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// a list of items for the picker
  final List<T> items;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  @override
  _CardSettingsListPickerState<T> createState() =>
      _CardSettingsListPickerState<T>();
}

class _CardSettingsListPickerState<T> extends FormFieldState<T> {
  @override
  CardSettingsListPicker<T> get widget =>
      super.widget as CardSettingsListPicker<T>;

  List<T> items = List<T>.empty();

  void _showDialog(String label) {
    if (showCupertino(context, widget.showMaterialonIOS)) {
      int itemIndex = items.indexOf(value!);
      _showCupertinoBottomPicker(itemIndex);
    } else {
      _showMaterialScrollPicker(label, value!);
    }
  }

  void _showCupertinoBottomPicker(int optionIndex) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: optionIndex);
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) {
        return _buildCupertinoBottomPicker(
          CupertinoPicker(
            scrollController: scrollController,
            itemExtent: kCupertinoPickerItemHeight,
            backgroundColor: CupertinoColors.white,
            onSelectedItemChanged: (int index) {
              didChange(items[index]);
              widget.onChanged!(items[index]);
            },
            children: List<Widget>.generate(items.length, (int index) {
              return Center(
                child: Text(items[index].toString()),
              );
            }),
          ),
        );
      },
    ).then((item) {
      if (item != null) {
        didChange(item);
        if (widget.onChanged != null) widget.onChanged!(item);
      }
    });
  }

  void _showMaterialScrollPicker(String label, T selectedItem) {
    showMaterialScrollPicker<T>(
      context: context,
      title: label,
      items: items,
      selectedItem: selectedItem,
      onChanged: (value) {
        didChange(value);
        if (widget.onChanged != null) widget.onChanged!(value);
      },
    );
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

  Widget _build(BuildContext context) {
    // make local mutable copies of values and options
    items = widget.items;

    // get the content label from options based on value
    int itemIndex = items.indexOf(value!);
    String content = widget.hintText ?? '';
    if (itemIndex >= 0) {
      content = items[itemIndex].toString();
    }

    if (showCupertino(context, widget.showMaterialonIOS))
      return _cupertinoSettingsListPicker(content);
    else
      return _materialSettingsListPicker(content);
  }

  Widget _cupertinoSettingsListPicker(String content) {
    final ls = labelStyle(context, widget.enabled);
    return Container(
      child: widget.visible == false
          ? null
          : GestureDetector(
              onTap: () {
                if (widget.enabled) _showDialog(widget.label);
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
                  content,
                  style: contentStyle(context, value, widget.enabled),
                  textAlign: widget.contentAlign ??
                      CardSettings.of(context)?.contentAlign,
                ),
                style: CSWidgetStyle(icon: widget.icon),
              ),
            ),
    );
  }

  Widget _materialSettingsListPicker(String content) {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog(widget.label);
      },
      child: CardSettingsField(
        label: widget.label,
        enabled: widget.enabled,
        labelAlign: widget.labelAlign,
        labelWidth: widget.labelWidth,
        visible: widget.visible,
        icon: widget.icon,
        requiredIndicator: widget.requiredIndicator,
        errorText: errorText,
        fieldPadding: widget.fieldPadding,
        content: Text(
          content,
          style: contentStyle(context, value, widget.enabled),
          textAlign:
              widget.contentAlign ?? CardSettings.of(context)?.contentAlign,
        ),
        pickerIcon: (widget.enabled) ? Icons.arrow_drop_down : null,
      ),
    );
  }
}
