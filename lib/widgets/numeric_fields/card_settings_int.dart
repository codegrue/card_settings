// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../card_settings.dart';

/// This is a password field. It obscures the entered text.
class CardSettingsInt extends CardSettingsText {
  CardSettingsInt({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    String hintText,
    int initialValue: 0,
    Icon icon,
    Widget requiredIndicator,
    String unitLabel,
    int maxLength: 10,
    bool visible: true,
    bool enabled: true,
    bool autofocus: false,
    bool obscureText: false,
    bool autocorrect: false,
    bool autovalidate: false,
    FormFieldValidator<int> validator,
    FormFieldSetter<int> onSaved,
    ValueChanged<int> onChanged,
    TextEditingController controller,
    FocusNode focusNode,
    TextInputType keyboardType,
    TextStyle style,
    bool maxLengthEnforced: true,
    ValueChanged<String> onFieldSubmitted,
    List<TextInputFormatter> inputFormatters,
    bool showMaterialonIOS: false,
  }) : super(
          key: key,
          label: label,
          hintText: hintText,
          labelAlign: labelAlign,
          showMaterialonIOS: showMaterialonIOS,
          contentAlign: contentAlign,
          initialValue: initialValue?.toString(),
          unitLabel: unitLabel,
          icon: icon,
          requiredIndicator: requiredIndicator,
          maxLength: maxLength,
          visible: visible,
          enabled: enabled,
          autofocus: autofocus,
          obscureText: obscureText,
          autocorrect: autocorrect,
          autovalidate: autovalidate,
          validator: (value) {
            if (validator == null) return null;
            return validator(intelligentCast<int>(value));
          },
          onSaved: (value) {
            if (onSaved == null) return;
            onSaved(intelligentCast<int>(value));
          },
          onChanged: (value) {
            if (onChanged == null) return;
            onChanged(intelligentCast<int>(value));
          },
          controller: controller,
          focusNode: focusNode,
          keyboardType:
              keyboardType ?? TextInputType.numberWithOptions(decimal: false),
          style: style,
          maxLengthEnforced: maxLengthEnforced,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength),
            WhitelistingTextInputFormatter(RegExp("[0-9]+")),
          ],
        );
}
