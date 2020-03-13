// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../card_settings.dart';
import '../../models/common_card_field_attributes.dart';

/// This is a phone number field. It's designed for US numbers
class CardSettingsPhone extends StatelessWidget
    implements CommonCardFieldAttributes {
  CardSettingsPhone({
    Key key,
    this.label: 'Label',
    this.labelWidth,
    this.labelAlign,
    this.hintText,
    this.prefixText,
    this.contentAlign,
    this.initialValue,
    this.contentOnNewLine = false,
    this.maxLength,
    this.icon,
    this.requiredIndicator,
    this.visible: true,
    this.enabled: true,
    this.autofocus: false,
    this.obscureText: false,
    this.autocorrect: false,
    this.autovalidate: false,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.style,
    this.maxLengthEnforced: true,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.showMaterialonIOS = false,
  });

  @override
  final String label;

  @override
  final double labelWidth;

  @override
  final TextAlign labelAlign;

  @override
  final TextAlign contentAlign;

  @override
  final String hintText;

  @override
  final String prefixText;

  final int initialValue;

  final bool contentOnNewLine;

  final String inputMask = '(000) 000-0000';

  final int maxLength;

  @override
  final Icon icon;

  final Widget requiredIndicator;

  final bool visible;

  final bool enabled;

  final bool autofocus;

  final bool obscureText;

  final bool autocorrect;

  final bool autovalidate;

  final FormFieldValidator<int> validator;

  final FormFieldSetter<int> onSaved;

  final ValueChanged<int> onChanged;

  final TextEditingController controller;

  final FocusNode focusNode;

  final TextInputType keyboardType;

  final TextStyle style;

  final bool maxLengthEnforced;

  final ValueChanged<String> onFieldSubmitted;

  final List<TextInputFormatter> inputFormatters;

  final bool showMaterialonIOS;

  @override
  Widget build(BuildContext context) {
    return CardSettingsText(
      key: key,
      label: label,
      labelWidth: labelWidth,
      labelAlign: labelAlign,
      contentAlign: contentAlign,
      initialValue: initialValue.toString(),
      contentOnNewLine: contentOnNewLine,
      inputMask: inputMask,
      maxLength: maxLength,
      hintText: hintText,
      prefixText: prefixText,
      icon: icon,
      requiredIndicator: requiredIndicator,
      visible: visible,
      enabled: enabled,
      autofocus: autofocus,
      showMaterialonIOS: showMaterialonIOS,
      obscureText: obscureText,
      autocorrect: autocorrect,
      autovalidate: autovalidate,
      validator: _safeValidator,
      onSaved: _safeOnSaved,
      onChanged: _safeOnChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType:
          keyboardType ?? TextInputType.numberWithOptions(decimal: false),
      style: style,
      maxLengthEnforced: maxLengthEnforced,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
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
