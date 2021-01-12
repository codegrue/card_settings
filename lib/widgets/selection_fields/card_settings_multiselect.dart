// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/widgets/picker_fields/card_settings_checkbox_picker.dart';
import 'package:flutter/material.dart';

/// This is a selection widget that allows an arbitrary list of options to be provided.
@Deprecated(
    'Replaced with CardSettingsCheckboxPicker. Will be removed in the 2.0.0 release')
class CardSettingsMultiselect extends CardSettingsCheckboxPicker {
  CardSettingsMultiselect({
    Key key,
    List<String> initialValues,
    FormFieldSetter<List<String>> onSaved,
    FormFieldValidator<List<String>> validator,
    // bool autovalidate: false,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    ValueChanged<List<String>> onChanged,
    String label = 'Select',
    bool visible = true,
    TextAlign contentAlign,
    Icon icon,
    TextAlign labelAlign,
    Widget requiredIndicator,
    List<String> options,
    bool showMaterialonIOS = false,
    EdgeInsetsGeometry fieldPadding,
  }) : super(
          key: key,
          initialValues: initialValues,
          onSaved: onSaved,
          validator: validator,
          // autovalidate:autovalidate,
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
          label: label,
          visible: visible,
          contentAlign: contentAlign,
          icon: icon,
          labelAlign: labelAlign,
          requiredIndicator: requiredIndicator,
          options: options,
          showMaterialonIOS: showMaterialonIOS,
          fieldPadding: fieldPadding,
        );
}
