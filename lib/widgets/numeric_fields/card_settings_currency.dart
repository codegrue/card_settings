// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../card_settings.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

/// This is a currency field.
class CardSettingsCurrency extends StatefulWidget {
  CardSettingsCurrency({
    Key key,
    this.label: 'Label',
    this.labelAlign,
    this.contentAlign,
    this.initialValue: 0.0,
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
    this.onEditingComplete,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.style,
    this.maxLengthEnforced: true,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
  });

  final String label;
  final TextAlign labelAlign;
  final TextAlign contentAlign;
  final double initialValue;
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
  final VoidCallback onEditingComplete;
  final ValueChanged<double> onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle style;
  final bool maxLengthEnforced;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;

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
      label: widget.label,
      labelAlign: widget.labelAlign,
      contentAlign: widget.contentAlign,
      initialValue: widget.initialValue.toString(),
      unitLabel: widget.currencyName,
      prefixText: widget.currencySymbol,
      maxLength: widget.maxLength,
      visible: widget.visible,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      autovalidate: widget.autovalidate,
      validator: _safeValidator,
      onSaved: _safeOnSaved,
      onEditingComplete: widget.onEditingComplete,
      onChanged: _safeOnChanged,
      controller: widget.controller ?? _moneyController,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType ??
          TextInputType.numberWithOptions(decimal: false),
      textInputAction: widget.textInputAction,
      style: widget.style,
      maxLengthEnforced: widget.maxLengthEnforced,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
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
