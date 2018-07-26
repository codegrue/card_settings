import 'package:flutter/material.dart';
import 'CardSettingsField.dart';

class CardSettingsSwitch extends FormField<bool> {
  CardSettingsSwitch({
    Key key,
    String label: 'Label',
    String trueLabel: 'Yes',
    String falseLabel: 'No',
    bool initialValue: false,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    final ValueChanged<bool> onChanged,
  }) : super(
            key: key,
            initialValue: initialValue ?? '',
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> field) {
              final _CardSettingsSwitchState state = field;
              return CardSettingsField(
                label: label,
                visible: visible,
                errorText: field.errorText,
                content: Row(children: <Widget>[                  
                  Expanded(
                    child: Text(
                      state.value ? trueLabel : falseLabel,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      height: 20.0,
                      child: Switch(
                        value: state.value,
                        onChanged: (value) {
                          state.didChange(value);
                          onChanged(value);
                        },
                      ),
                    ),
                  ),
                ]),
              );
            });

  @override
  _CardSettingsSwitchState createState() => new _CardSettingsSwitchState();
}

class _CardSettingsSwitchState extends FormFieldState<bool> {}
