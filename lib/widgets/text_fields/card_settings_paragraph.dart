// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../card_settings.dart';

/// This is a password field. It obscures the entered text.
class CardSettingsParagraph extends CardSettingsText {
  CardSettingsParagraph({
    Key key,
    String label: 'Label',
    String hintText ,
    TextAlign labelAlign,
    TextAlign contentAlign: TextAlign.left,
    String initialValue,
    Icon icon,
    Widget requiredIndicator,
    int maxLength: 250,
    int numberOfLines: 7,
    bool contentOnNewLine: true,
    bool visible: true,
    bool enabled: true,
    bool showCounter: true,
    bool autofocus: false,
    bool obscureText: false,
    bool autocorrect: true,
    bool autovalidate: false,
    FormFieldValidator<String> validator,
    FormFieldSetter<String> onSaved,
    ValueChanged<String> onChanged,
    TextEditingController controller,
    FocusNode focusNode,
    TextInputType keyboardType = TextInputType.multiline,
    TextStyle style,
    bool maxLengthEnforced: true,
    ValueChanged<String> onFieldSubmitted,
    List<TextInputFormatter> inputFormatters,
    bool showMaterialonIOS: false,
  }) : super(
          key: key,
          label: label,
          labelAlign: labelAlign,
          hintText : hintText,
          contentAlign: contentAlign,
          showMaterialonIOS: showMaterialonIOS,
          initialValue: initialValue,
          contentOnNewLine: contentOnNewLine,
          maxLength: maxLength,
          icon: icon,
          requiredIndicator: requiredIndicator,
          numberOfLines: numberOfLines,
          showCounter: showCounter,
          visible: visible,
          enabled: enabled,
          autofocus: autofocus,
          obscureText: obscureText,
          autocorrect: autocorrect,
          autovalidate: autovalidate,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: style,
          maxLengthEnforced: maxLengthEnforced,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
        );
}
