// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../card_settings.dart';

/// This is a password field. It obscures the entered text.
class CardSettingsDouble extends CardSettingsText {
  CardSettingsDouble({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    double initialValue: 0.0,
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
    FormFieldValidator<double> validator,
    FormFieldSetter<double> onSaved,
    ValueChanged<double> onChanged,
    TextEditingController controller,
    FocusNode focusNode,
    TextInputType keyboardType,
    TextStyle style,
    bool maxLengthEnforced: true,
    ValueChanged<String> onFieldSubmitted,
    List<TextInputFormatter> inputFormatters,
    bool showMaterialIOS: false,

    ///Shows a [red] [Border] around the [CupertinoTextField] since the [validator] does not exist
    bool showErrorIOS: false,
  }) : super(
          key: key,
          label: label,
          showMaterialIOS: showMaterialIOS,
          labelAlign: labelAlign,
          contentAlign: contentAlign,
          initialValue: initialValue.toString(),
          unitLabel: unitLabel,
          icon: icon,
          requiredIndicator: requiredIndicator,
          maxLength: maxLength,
          visible: visible,
          enabled: enabled,
          autofocus: autofocus,
          obscureText: obscureText,
          showErrorIOS: showErrorIOS,
          autocorrect: autocorrect,
          autovalidate: autovalidate,
          validator: (value) {
            if (validator == null) return null;
            return validator(intelligentCast<double>(value));
          },
          onSaved: (value) {
            if (onSaved == null) return;
            onSaved(intelligentCast<double>(value));
          },
          onChanged: (value) {
            if (onChanged == null) return;
            onChanged(intelligentCast<double>(value));
          },
          controller: controller,
          focusNode: focusNode,
          keyboardType:
              keyboardType ?? TextInputType.numberWithOptions(decimal: true),
          style: style,
          maxLengthEnforced: maxLengthEnforced,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength),
            WhitelistingTextInputFormatter(RegExp("[0-9]+.?[0-9]*")),
          ],
        );
}
