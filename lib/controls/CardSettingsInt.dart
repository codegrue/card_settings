import 'package:flutter/services.dart';

import '../helpers/Converters.dart';
import 'package:flutter/material.dart';
import 'CardSettingsField.dart';

class CardSettingsInt extends StatelessWidget {
  CardSettingsInt({
    this.label: 'Label',
    this.initialValue: 0.0,
    this.maxLength: 10,
    this.autovalidate: false,
    this.validator,
    this.onSaved,
    this.unitLabel,
    this.visible: true,
  });

  final String label;
  final double initialValue;
  final bool autovalidate;
  final String unitLabel;
  final int maxLength;
  final bool visible;

  // Events
  final FormFieldValidator<int> validator;
  final FormFieldSetter<int> onSaved;

  Widget build(BuildContext context) {
    return new CardSettingsField(
      label: label,
      visible: visible,
      unitLabel: unitLabel,
      content: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
        ),
        initialValue: initialValue?.toString() ?? '',
        autovalidate: autovalidate,
        validator: _safeValidator,
        onSaved: _safeOnSaved,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
          WhitelistingTextInputFormatter(RegExp("[0-9]+")),
        ],
      ),
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
