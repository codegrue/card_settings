// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';
import '../../interfaces/text_field_properties.dart';

/// This is a phone number field. It's designed for US numbers
class CardSettingsPhone extends StatelessWidget
    implements ICommonFieldProperties, ITextFieldProperties {
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
    this.inputAction,
    this.inputActionNode,
    this.keyboardType,
    this.style,
    this.maxLengthEnforced: true,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.showMaterialonIOS,
    this.fieldPadding,
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

  final String prefixText;

  final int initialValue;

  final bool contentOnNewLine;

  final int maxLength;

  @override
  final Icon icon;

  @override
  final Widget requiredIndicator;

  @override
  final bool visible;

  final bool enabled;

  final bool autofocus;

  final bool obscureText;

  final bool autocorrect;

  @override
  final bool autovalidate;

  @override
  final FormFieldValidator<int> validator;

  @override
  final FormFieldSetter<int> onSaved;

  @override
  final ValueChanged<int> onChanged;

  final TextEditingController controller;

  final FocusNode focusNode;

  final FocusNode inputActionNode;

  final TextInputType keyboardType;

  final TextStyle style;

  final TextInputAction inputAction;

  final bool maxLengthEnforced;

  final ValueChanged<String> onFieldSubmitted;

  final List<TextInputFormatter> inputFormatters;

  @override
  final EdgeInsetsGeometry fieldPadding;

  @override
  final bool showMaterialonIOS;

  @override
  Widget build(BuildContext context) {
    return CardSettingsText(
      key: key,
      label: label,
      labelWidth: labelWidth,
      labelAlign: labelAlign,
      contentAlign: contentAlign,
      initialValue: formatAsPhoneNumber(initialValue.toString()),
      contentOnNewLine: contentOnNewLine,
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
      fieldPadding: fieldPadding,
      inputActionNode: inputActionNode,
      keyboardType:
          keyboardType ?? TextInputType.numberWithOptions(decimal: false),
      style: style,
      maxLengthEnforced: maxLengthEnforced,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: [
        PhoneInputFormatter(),
      ],
      inputAction: inputAction,
    );
  }

  String _safeValidator(String value) {
    if (validator == null) return null;
    var numbers = toNumericString(value);
    return validator(intelligentCast<int>(numbers));
  }

  void _safeOnSaved(String value) {
    if (onSaved == null) return;
    var numbers = toNumericString(value);
    onSaved(intelligentCast<int>(numbers));
  }

  void _safeOnChanged(String value) {
    if (onChanged == null) return;
    var numbers = toNumericString(value);
    onChanged(intelligentCast<int>(numbers));
  }
}
