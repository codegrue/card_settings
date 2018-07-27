import 'package:flutter/material.dart';

import 'card_settings_list_picker.dart';
import '../helpers/Converters.dart';

class CardSettingsNumberPicker extends StatelessWidget {
  CardSettingsNumberPicker({
    this.label: 'Label',
    this.initialValue,
    @required this.min,
    @required this.max,
    this.autovalidate: false,
    this.validator,
    this.onSaved,
    this.visible: true,
  }) : assert(min < max);

  // Variables
  final String label;
  final int initialValue;
  final int min;
  final int max;
  final bool autovalidate;
  final bool visible;

  // Events
  final FormFieldValidator<int> validator;
  final FormFieldSetter<int> onSaved;

  @override
  Widget build(BuildContext context) {
    return new CardSettingsListPicker(
      label: this.label,
      visible: visible,
      initialValue: initialValue?.toString(),
      options:
          new List<String>.generate(max - min + 1, (i) => (i + min).toString()),
      autovalidate: autovalidate,
      validator: _safeValidator,
      onSaved: _safeOnSaved,
    );
  }

  String _safeValidator(value) {
    if (validator == null) return null;
    return validator(intelligentCast<int>(value));
  }

  void _safeOnSaved(value) {
    if (onSaved == null) return;
    onSaved(intelligentCast<int>(value));
  }
}
