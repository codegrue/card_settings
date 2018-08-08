// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../card_settings.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

/// This is a phone number field. It's designed for US numbers
class CardSettingsPhone extends StatelessWidget {
  CardSettingsPhone({
    Key key,
    this.label: 'Label',
    this.labelAlign,
    this.contentAlign,
    this.initialValue,
    this.maxLength,
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
  final int initialValue;
  final int maxLength;
  final bool visible;
  final bool enabled;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final bool autovalidate;
  final FormFieldValidator<int> validator;
  final FormFieldSetter<int> onSaved;
  final VoidCallback onEditingComplete;
  final ValueChanged<int> onChanged;
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

  Widget build(BuildContext context) {
    return CardSettingsText(
      key: key,
      label: label,
      labelAlign: labelAlign,
      contentAlign: contentAlign,
      initialValue: initialValue.toString(),
      maxLength: maxLength,
      visible: visible,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      autocorrect: autocorrect,
      autovalidate: autovalidate,
      validator: _safeValidator,
      onSaved: _safeOnSaved,
      onEditingComplete: onEditingComplete,
      onChanged: _safeOnChanged,
      controller: _composeController,
      focusNode: focusNode,
      keyboardType:
          keyboardType ?? TextInputType.numberWithOptions(decimal: false),
      textInputAction: textInputAction,
      style: style,
      maxLengthEnforced: maxLengthEnforced,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
    );
  }

  TextEditingController get _composeController {
    if (controller != null) return controller;
    var maskController = MaskedTextController(mask: '(000) 000-0000');
    maskController.updateText(initialValue.toString());
    return maskController;
  }

  String _safeValidator(value) {
    if (validator == null) return null;
    return validator(intelligentCast<int>(value));
  }

  void _safeOnSaved(value) {
    if (onSaved == null) return;
    onSaved(intelligentCast<int>(value));
  }

  void _safeOnChanged(value) {
    if (onChanged == null) return;
    onChanged(_getValue(value));
  }

  int _getValue(value) {
    //if (controller is MaskedTextController)
    //return (controller as MaskedTextController).value;
    return intelligentCast<int>(value);
  }
}
