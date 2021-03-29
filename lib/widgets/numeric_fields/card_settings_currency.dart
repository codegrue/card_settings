// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a currency field.
class CardSettingsCurrency extends StatefulWidget
    implements ICommonFieldProperties {
  CardSettingsCurrency({
    Key? key,
    this.label: 'Label',
    this.labelAlign,
    this.labelWidth,
    this.contentAlign,
    this.initialValue: 0.0,
    this.icon,
    this.requiredIndicator,
    this.currencySymbol: '\$',
    this.currencyName: 'USD',
    this.decimalSeparator: '.',
    this.thousandSeparator: ',',
    this.maxLength: 16,
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
    this.fieldPadding,
    this.locale,
  });

  /// The text to identify the field to the user
  @override
  final String label;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  /// controls how the widget in the content area of the field is aligned
  @override
  final TextAlign? contentAlign;

  /// The initial value to display
  final double initialValue;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// The symbol to use for the currency
  final String currencySymbol;

  /// the name of the currency. E.g. USD
  final String currencyName;

  /// the character to use for decimal separation
  final String decimalSeparator;

  /// the character to use for the thousands place.
  final String thousandSeparator;

  /// The maxinum length of the value in characters
  final int maxLength;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// If false, grays out the field and makes it unresponsive
  final bool enabled;

  final bool autofocus;

  final bool obscureText;

  @override
  final AutovalidateMode autovalidateMode;

  @override
  final FormFieldValidator<double>? validator;

  @override
  final FormFieldSetter<double>? onSaved;

  @override
  final ValueChanged<double?>? onChanged;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final TextInputAction? inputAction;

  final FocusNode? inputActionNode;

  final TextInputType? keyboardType;

  final TextStyle? style;

  final MaxLengthEnforcement? maxLengthEnforcement;

  final ValueChanged<String>? onFieldSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final Locale? locale;

  // Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  // provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  @override
  _CardSettingsCurrencyState createState() {
    return _CardSettingsCurrencyState();
  }
}

class _CardSettingsCurrencyState extends State<CardSettingsCurrency> {
  MoneyMaskedTextController? _moneyController;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _moneyController = MoneyMaskedTextController(
          decimalSeparator: widget.decimalSeparator,
          thousandSeparator: widget.thousandSeparator);
      _moneyController!.updateValue(widget.initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = widget.locale ?? Localizations.localeOf(context);

    var pattern = "#,###.##";

    var formatter = NumberFormat(pattern, myLocale.languageCode);

    return CardSettingsText(
      showMaterialonIOS: widget.showMaterialonIOS,
      fieldPadding: widget.fieldPadding,
      label: widget.label,
      labelAlign: widget.labelAlign,
      labelWidth: widget.labelWidth,
      contentAlign: widget.contentAlign,
      initialValue: widget.initialValue.toString(),
      unitLabel: widget.currencyName,
      prefixText: widget.currencySymbol,
      icon: widget.icon,
      requiredIndicator: widget.requiredIndicator,
      maxLength: widget.maxLength,
      visible: widget.visible,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      autovalidateMode: widget.autovalidateMode,
      validator: (val) => _safeValidator(val, formatter),
      onSaved: (val) => _safeOnSaved(val, formatter),
      onChanged: (val) => _safeOnChanged(val, formatter),
      controller: widget.controller ?? _moneyController,
      focusNode: widget.focusNode,
      inputAction: widget.inputAction,
      inputActionNode: widget.inputActionNode,
      keyboardType: widget.keyboardType ??
          TextInputType.numberWithOptions(decimal: false),
      style: widget.style,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
    );
  }

  String? _safeValidator(String? value, NumberFormat formatter) {
    if (widget.validator == null) return null;
    num? number = (value == "") ? null : formatter.parse(value!);
    return widget.validator!(intelligentCast<double>(number));
  }

  void _safeOnSaved(String? value, NumberFormat formatter) {
    if (widget.onSaved == null) return;
    num? number = (value == "") ? null : formatter.parse(value!);
    widget.onSaved!(intelligentCast<double>(number));
  }

  void _safeOnChanged(String? value, NumberFormat formatter) {
    if (widget.onChanged == null) return;

    if (_moneyController != null) {
      widget.onChanged!(_moneyController!.numberValue);
    } else {
      num? number = (value == "") ? null : formatter.parse(value!);
      widget.onChanged!(intelligentCast<double>(number));
    }
  }
}
