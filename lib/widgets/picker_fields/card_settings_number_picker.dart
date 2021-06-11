// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a list picker that allows for a range of numbers to be speficied as pptions.
class CardSettingsNumberPicker extends StatelessWidget
    implements ICommonFieldProperties {
  CardSettingsNumberPicker({
    Key? key,
    this.label: 'Label',
    this.labelAlign,
    this.labelWidth,
    this.initialValue,
    this.contentAlign,
    this.icon,
    this.requiredIndicator,
    required this.min,
    required this.max,
    this.stepInterval: 1,
    this.autovalidateMode: AutovalidateMode.onUserInteraction,
    this.enabled: true,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.visible: true,
    this.showMaterialonIOS,
    this.fieldPadding,
  }) : assert(min < max);

  /// The text to identify the field to the user
  @override
  final String label;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  /// controls how the widget in the content area of the field is aligned
  @override
  final TextAlign? contentAlign;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// the initial value fo the picker to be placed on
  final int? initialValue;

  /// the lowest value that will be shown
  final int min;

  /// the highest value that will be shown
  final int max;

  /// the interval for the values. Default is 1
  final int stepInterval;

  /// places the field into auto validation mode
  @override
  final AutovalidateMode autovalidateMode;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// If false, grays out the field and makes it unresponsive
  final bool enabled;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  /// fires when validation is requested
  @override
  final FormFieldValidator<int>? validator;

  /// vires when the enclosing for is saved
  @override
  final FormFieldSetter<int>? onSaved;

  /// firest when the content is changed
  @override
  final ValueChanged<int?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return CardSettingsListPicker<int>(
      key: key,
      label: this.label,
      showMaterialonIOS: showMaterialonIOS,
      fieldPadding: fieldPadding,
      labelAlign: labelAlign,
      labelWidth: labelWidth,
      contentAlign: contentAlign,
      visible: visible,
      enabled: enabled,
      initialItem: initialValue,
      icon: icon,
      requiredIndicator: requiredIndicator,
      items: List<int>.generate(
        (max - min) ~/ stepInterval + 1,
        (i) => (i * stepInterval + min),
      ),
      autovalidateMode: autovalidateMode,
      validator: _safeValidator,
      onSaved: _safeOnSaved,
      onChanged: _safeOnChanged,
    );
  }

  String? _safeValidator(int? value) {
    if (validator == null) return null;
    return validator!(intelligentCast<int>(value));
  }

  void _safeOnSaved(int? value) {
    if (onSaved == null) return;
    onSaved!(intelligentCast<int>(value));
  }

  void _safeOnChanged(int value) {
    if (onChanged == null) return;
    onChanged!(intelligentCast<int>(value));
  }
}
