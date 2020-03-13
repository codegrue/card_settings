// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../card_settings.dart';

/// This is a currency field.
class CardSettingsCurrency extends StatefulWidget {
  CardSettingsCurrency({
    Key key,
    this.label: 'Label',
    this.labelAlign,
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

  final String label;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final double initialValue;

  final Icon icon;

  final Widget requiredIndicator;

  final String currencySymbol;

  final String currencyName;

  final String decimalSeparator;

  final String thousandSeparator;

  final int maxLength;

  final bool visible;

  final bool enabled;

  final bool autofocus;

  final bool obscureText;

  final bool autocorrect;

  final bool autovalidate;

  final FormFieldValidator<double> validator;

  final FormFieldSetter<double> onSaved;

  final ValueChanged<double> onChanged;

  final TextEditingController controller;

  final FocusNode focusNode;

  final TextInputType keyboardType;

  final TextStyle style;

  final bool maxLengthEnforced;

  final ValueChanged<String> onFieldSubmitted;

  final List<TextInputFormatter> inputFormatters;

  final bool showMaterialonIOS;

  @override
  CardSettingsCurrencyState createState() {
    return CardSettingsCurrencyState();
  }
}

class CardSettingsCurrencyState extends State<CardSettingsCurrency> {
  MoneyMaskedTextController _moneyController;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _moneyController = MoneyMaskedTextController(
          decimalSeparator: widget.decimalSeparator,
          thousandSeparator: widget.thousandSeparator);
      _moneyController.updateValue(widget.initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardSettingsText(
      showMaterialonIOS: widget?.showMaterialonIOS,
      label: widget.label,
      labelAlign: widget.labelAlign,
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
      autocorrect: widget.autocorrect,
      autovalidate: widget.autovalidate,
      validator: _safeValidator,
      onSaved: _safeOnSaved,
      onChanged: _safeOnChanged,
      controller: widget.controller ?? _moneyController,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType ??
          TextInputType.numberWithOptions(decimal: false),
      style: widget.style,
      maxLengthEnforced: widget.maxLengthEnforced,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
    );
  }

  String _safeValidator(String value) {
    if (widget.validator == null) return null;
    return widget.validator(intelligentCast<double>(value));
  }

  void _safeOnSaved(String value) {
    if (widget.onSaved == null) return;
    widget.onSaved(intelligentCast<double>(value));
  }

  void _safeOnChanged(String value) {
    if (widget.onChanged == null) return;
    if (_moneyController != null)
      widget.onChanged(_moneyController.numberValue);
    else
      widget.onChanged(intelligentCast<double>(value));
  }
}
