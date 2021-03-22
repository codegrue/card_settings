// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';
import '../../interfaces/text_field_properties.dart';

/// This is a password field. It obscures the entered text.
class CardSettingsParagraph extends CardSettingsText
    implements ICommonFieldProperties, ITextFieldProperties {
  CardSettingsParagraph({
    Key? key,
    String label: 'Label',
    String? hintText,
    TextAlign? labelAlign,
    TextAlign contentAlign: TextAlign.left,
    String? initialValue,
    Icon? icon,
    Widget? requiredIndicator,
    int maxLength: 250,
    int numberOfLines: 7,
    bool contentOnNewLine: true,
    bool visible: true,
    bool enabled: true,
    bool showCounter: true,
    bool autofocus: false,
    bool obscureText: false,
    bool autocorrect: true,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputAction? inputAction,
    FocusNode? inputActionNode,
    TextInputType keyboardType = TextInputType.multiline,
    TextStyle? style,
    MaxLengthEnforcement? maxLengthEnforcement: MaxLengthEnforcement.enforced,
    ValueChanged<String>? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    bool? showMaterialonIOS,
    EdgeInsetsGeometry? fieldPadding,
  }) : super(
          key: key,
          label: label,
          labelAlign: labelAlign,
          hintText: hintText,
          contentAlign: contentAlign,
          showMaterialonIOS: showMaterialonIOS,
          fieldPadding: fieldPadding,
          initialValue: initialValue,
          contentOnNewLine: contentOnNewLine,
          maxLength: maxLength,
          icon: icon,
          requiredIndicator: requiredIndicator,
          numberOfLines: numberOfLines,
          showCounter: (enabled == true) ? showCounter : false,
          visible: visible,
          enabled: enabled,
          autofocus: autofocus,
          obscureText: obscureText,
          autocorrect: autocorrect,
          autovalidateMode: autovalidateMode,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          controller: controller,
          focusNode: focusNode,
          inputAction: inputAction,
          inputActionNode: inputActionNode,
          keyboardType: keyboardType,
          style: style,
          maxLengthEnforcement: maxLengthEnforcement,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
        );
}
