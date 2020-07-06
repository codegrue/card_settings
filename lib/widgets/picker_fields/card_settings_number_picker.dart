// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a list picker that allows for a range of numbers to be speficied as pptions.
class CardSettingsNumberPicker extends StatelessWidget
    implements ICommonFieldProperties {
  CardSettingsNumberPicker({
    Key key,
    this.label: 'Label',
    this.labelAlign,
    this.labelWidth,
    this.initialValue,
    this.contentAlign,
    this.icon,
    this.requiredIndicator,
    @required this.min,
    @required this.max,
    this.stepInterval: 1,
    this.autovalidate: false,
    this.enabled: true,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.visible: true,
    this.showMaterialonIOS,
  }) : assert(min < max);

  // Variables
  @override
  final String label;
  @override
  final TextAlign labelAlign;
  @override
  final TextAlign contentAlign;
  @override
  final Icon icon;
  @override
  final Widget requiredIndicator;
  final int initialValue;
  final int min;
  final int max;
  final int stepInterval;
  @override
  final bool autovalidate;
  @override
  final bool visible;
  @override
  final bool showMaterialonIOS;
  final bool enabled;
  @override
  final double labelWidth;

  // Events
  @override
  final FormFieldValidator<int> validator;
  @override
  final FormFieldSetter<int> onSaved;
  @override
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return CardSettingsListPicker(
      key: key,
      label: this.label,
      showMaterialonIOS: showMaterialonIOS,
      labelAlign: labelAlign,
      labelWidth: labelWidth,
      contentAlign: contentAlign,
      visible: visible,
      enabled: enabled,
      initialValue: initialValue?.toString(),
      icon: icon,
      requiredIndicator: requiredIndicator,
      options: List<String>.generate(
        (max - min) ~/ stepInterval + 1,
        (i) => (i * stepInterval + min).toString(),
      ),
      autovalidate: autovalidate,
      validator: _safeValidator,
      onSaved: _safeOnSaved,
      onChanged: _safeOnChanged,
    );
  }

  String _safeValidator(String value) {
    if (validator == null) return null;
    return validator(intelligentCast<int>(value));
  }

  void _safeOnSaved(String value) {
    if (onSaved == null) return;
    onSaved(intelligentCast<int>(value));
  }

  void _safeOnChanged(String value) {
    if (onChanged == null) return;
    onChanged(intelligentCast<int>(value));
  }
}
