import 'package:flutter/material.dart';
import 'card_settings_field.dart';

class CardSettingsTimePicker extends FormField<TimeOfDay> {

  CardSettingsTimePicker({
    Key key,
    label: 'Label',
    initialValue,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<TimeOfDay> onSaved,
    FormFieldValidator<TimeOfDay> validator,
  }) : super(
            key: key,
            initialValue: initialValue ?? DateTime.now(),
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<TimeOfDay> field) {
              final _CardSettingsTimePickerState state = field;
              return GestureDetector(
                onTap: () {
                  state._showDialog();
                },
                child: CardSettingsField(
                  label: label,
                  visible: visible,
                  errorText: field.errorText,
                  content: Text(
                    state.value == null ? '' : state.value.format(field.context),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  pickerIcon: Icons.arrow_drop_down,
                ),
              );
            });

  @override
  _CardSettingsTimePickerState createState() =>
      new _CardSettingsTimePickerState();
}

class _CardSettingsTimePickerState extends FormFieldState<TimeOfDay> {
  @override
  CardSettingsTimePicker get widget => super.widget;

  void _showDialog() {
    showTimePicker(
      context: context,
      initialTime: value,
    ).then((value) {
      if (value != null) {
        didChange(value);
      }
    });
  }
}
