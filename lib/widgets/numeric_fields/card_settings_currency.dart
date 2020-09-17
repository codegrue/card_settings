// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a currency field.
class CardSettingsCurrency extends StatefulWidget
    implements ICommonFieldProperties {
  CardSettingsCurrency({
    Key key,
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
    this.locale,
  });

  @override
  final String label;

  @override
  final TextAlign labelAlign;

  @override
  final double labelWidth;

  @override
  final TextAlign contentAlign;

  final double initialValue;

  @override
  final Icon icon;

  @override
  final Widget requiredIndicator;

  final String currencySymbol;

  final String currencyName;

  final String decimalSeparator;

  final String thousandSeparator;

  final int maxLength;

  @override
  final bool visible;

  final bool enabled;

  final bool autofocus;

  final bool obscureText;

  final bool autocorrect;

  @override
  final bool autovalidate;

  @override
  final FormFieldValidator<double> validator;

  @override
  final FormFieldSetter<double> onSaved;

  @override
  final ValueChanged<double> onChanged;

  final TextEditingController controller;

  final FocusNode focusNode;

  final TextInputAction inputAction;

  final FocusNode inputActionNode;

  final TextInputType keyboardType;

  final TextStyle style;

  final bool maxLengthEnforced;

  final ValueChanged<String> onFieldSubmitted;

  final List<TextInputFormatter> inputFormatters;

  final Locale locale;

  @override
  final bool showMaterialonIOS;

  @override
  final EdgeInsetsGeometry fieldPadding;

  @override
  _CardSettingsCurrencyState createState() {
    return _CardSettingsCurrencyState();
  }
}

class _CardSettingsCurrencyState extends State<CardSettingsCurrency> {
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
    Locale myLocale = widget.locale ?? Localizations.localeOf(context);

    var pattern = "#,###.##";

    var formatter = NumberFormat(pattern, myLocale.languageCode);

    return CardSettingsText(
      showMaterialonIOS: widget?.showMaterialonIOS,
      fieldPadding: widget.fieldPadding,
      label: widget.label,
      labelAlign: widget.labelAlign,
      labelWidth: widget?.labelWidth,
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
      maxLengthEnforced: widget.maxLengthEnforced,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
    );
  }

  String _safeValidator(String value, NumberFormat formatter) {
    if (widget.validator == null) return null;
    var number = formatter.parse(value);
    return widget.validator(intelligentCast<double>(number));
  }

  void _safeOnSaved(String value, NumberFormat formatter) {
    if (widget.onSaved == null) return;
    var number = formatter.parse(value);
    widget.onSaved(intelligentCast<double>(number));
  }

  void _safeOnChanged(String value, NumberFormat formatter) {
    if (widget.onChanged == null) return;

    if (_moneyController != null) {
      widget.onChanged(_moneyController.numberValue);
    } else {
      var number = formatter.parse(value);
      widget.onChanged(intelligentCast<double>(number));
    }
  }
}
