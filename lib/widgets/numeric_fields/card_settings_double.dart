// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

import '../../interfaces/text_field_properties.dart';

/// This is a phone number field. It's designed for US numbers
class CardSettingsDouble extends StatelessWidget
    implements ICommonFieldProperties, ITextFieldProperties {
  CardSettingsDouble({
    Key? key,
    this.label: 'Label',
    this.labelWidth,
    this.labelAlign,
    this.hintText,
    this.prefixText,
    this.contentAlign,
    this.initialValue,
    this.contentOnNewLine = false,
    this.maxLength = 10,
    this.decimalDigits = 2,
    this.icon,
    this.requiredIndicator,
    this.unitLabel,
    this.visible: true,
    this.enabled: true,
    this.autofocus: false,
    this.obscureText: false,
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
    this.locale,
    this.fieldPadding,
  });

  /// The text to identify the field to the user
  @override
  final String label;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  /// controls how the widget in the content area of the field is aligned
  @override
  final TextAlign? contentAlign;

  @override

  /// text to display to guide the user on what to enter
  final String? hintText;

  /// Text to show before the content area
  final String? prefixText;

  /// The initial value of the content
  final double? initialValue;

  /// Put the content below the label
  final bool contentOnNewLine;

  /// number of digits for the value
  final int maxLength;

  /// if provided, show text after the value
  final String? unitLabel;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// If false, grays out the field and makes it unresponsive
  final bool enabled;

  /// Allows flutter to advance to this field
  final bool autofocus;

  final bool obscureText;

  /// used to configure the autovalidation of this field
  @override
  final AutovalidateMode autovalidateMode;

  /// The function to call to validate the content
  @override
  final FormFieldValidator<double>? validator;

  /// This fires when the form is saved
  @override
  final FormFieldSetter<double>? onSaved;

  /// This fires when the value is changed
  @override
  final ValueChanged<double?>? onChanged;

  /// You can provide a custom text controller here
  final TextEditingController? controller;

  /// the order for this node to receive focus
  final FocusNode? focusNode;

  final FocusNode? inputActionNode;

  /// the type of keyboard to show
  final TextInputType? keyboardType;

  /// The style for the label
  final TextStyle? style;

  final TextInputAction? inputAction;

  /// the max length of the number in characters
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// the number of digits allowed after the decimal
  final int decimalDigits;

  /// This fires when the form is submitted
  final ValueChanged<String>? onFieldSubmitted;

  /// input formatters to enforce entry
  final List<TextInputFormatter>? inputFormatters;

  /// the localization region to use
  final Locale? locale;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  @override
  Widget build(BuildContext context) {
    var myLocale = locale ?? Localizations.localeOf(context);

    var pattern = "#,###" +
        ((decimalDigits > 0) ? ".".padRight(decimalDigits + 1, "#") : "");

    var formatter = NumberFormat(pattern, myLocale.languageCode);

    String? initialText =
        (initialValue == null) ? null : formatter.format(initialValue!);

    return CardSettingsText(
      key: key,
      label: label,
      hintText: hintText,
      showMaterialonIOS: showMaterialonIOS,
      fieldPadding: fieldPadding,
      labelAlign: labelAlign,
      labelWidth: labelWidth,
      contentAlign: contentAlign,
      initialValue: initialText,
      unitLabel: unitLabel,
      icon: icon,
      requiredIndicator: requiredIndicator,
      maxLength: maxLength,
      visible: visible,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      validator: (val) => _safeValidator(val, formatter),
      onSaved: (val) => _safeOnSaved(val, formatter),
      onChanged: (val) => _safeOnChanged(val, formatter),
      controller: controller,
      focusNode: focusNode,
      inputAction: inputAction,
      inputActionNode: inputActionNode,
      keyboardType:
          keyboardType ?? TextInputType.numberWithOptions(decimal: true),
      style: style,
      maxLengthEnforcement: maxLengthEnforcement,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: [
        ThousandsFormatter(
            formatter: formatter, allowFraction: (decimalDigits > 0)),
        LengthLimitingTextInputFormatter(maxLength),
      ],
    );
  }

  String? _safeValidator(String? value, NumberFormat formatter) {
    if (validator == null) return null;
    num? number = (value == "") ? null : formatter.parse(value!);
    return validator!(intelligentCast<double>(number));
  }

  void _safeOnSaved(String? value, NumberFormat formatter) {
    if (onSaved == null) return;
    num? number = (value == "") ? null : formatter.parse(value!);
    onSaved!(intelligentCast<double>(number));
  }

  void _safeOnChanged(String? value, NumberFormat formatter) {
    if (onChanged == null) return;
    num? number = (value == "") ? null : formatter.parse(value!);
    onChanged!(intelligentCast<double>(number));
  }
}
