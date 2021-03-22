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
    Key? key,
    this.label: 'Phone',
    this.labelWidth,
    this.labelAlign,
    this.hintText,
    this.prefixText,
    this.contentAlign,
    this.initialValue,
    this.contentOnNewLine = false,
    this.maxLength = 20,
    this.icon,
    this.requiredIndicator,
    this.visible: true,
    this.enabled: true,
    this.autofocus: false,
    this.obscureText: false,
    this.autocorrect: false,
    this.autovalidateMode: AutovalidateMode.onUserInteraction,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.inputAction,
    this.inputActionNode,
    this.keyboardType,
    this.style,
    this.maxLengthEnforcement: MaxLengthEnforcement.enforced,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.showMaterialonIOS,
    this.fieldPadding,
  });

  // The text to identify the field to the user
  @override
  final String label;

  // The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  // The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  // controls how the widget in the content area of the field is aligned
  @override
  final TextAlign? contentAlign;

  @override
  // text to display to guide the user on what to enter
  final String? hintText;

  final String? prefixText;

  final int? initialValue;

  final bool contentOnNewLine;

  final int maxLength;

  // The icon to display to the left of the field content
  @override
  final Icon? icon;

  // A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  // If false hides the widget on the card setting panel
  @override
  final bool visible;

  // If false, grays out the field and makes it unresponsive
  final bool enabled;

  final bool autofocus;

  final bool obscureText;

  final bool autocorrect;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final FormFieldValidator<int>? validator;

  @override
  final FormFieldSetter<int>? onSaved;

  @override
  final ValueChanged<int?>? onChanged;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final FocusNode? inputActionNode;

  final TextInputType? keyboardType;

  final TextStyle? style;

  final TextInputAction? inputAction;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final ValueChanged<String>? onFieldSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  // provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  // Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  @override
  Widget build(BuildContext context) {
    return CardSettingsText(
      key: key,
      label: label,
      labelWidth: labelWidth,
      labelAlign: labelAlign,
      contentAlign: contentAlign,
      initialValue: initialValue != null
          ? formatAsPhoneNumber(initialValue.toString())
          : "",
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
      autovalidateMode: autovalidateMode,
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
      maxLengthEnforcement: maxLengthEnforcement,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: [
        PhoneInputFormatter(),
      ],
      inputAction: inputAction,
    );
  }

  String? _safeValidator(String? value) {
    if (validator == null) return null;
    var numbers = toNumericString(value);
    return validator!(intelligentCast<int>(numbers));
  }

  void _safeOnSaved(String? value) {
    if (onSaved == null) return;
    var numbers = toNumericString(value);
    onSaved!(intelligentCast<int>(numbers));
  }

  void _safeOnChanged(String? value) {
    if (onChanged == null) return;
    var numbers = toNumericString(value);
    onChanged!(intelligentCast<int>(numbers));
  }
}
