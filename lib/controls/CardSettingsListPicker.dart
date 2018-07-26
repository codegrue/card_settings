import '../helpers/PickerDialog.dart';
import 'package:flutter/material.dart';
import 'CardSettingsField.dart';

class CardSettingsListPicker extends FormField<String> {
  final String label;
  final List<String> options;
  final String initialValue;

  CardSettingsListPicker({
    Key key,
    this.label: 'Label',
    this.initialValue,
    this.options,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
  }) : super(
            key: key,
            initialValue: initialValue ?? '',
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> field) {
              final _CardSettingsListPickerState state = field;
              return GestureDetector(
                onTap: () {
                  state._showDialog();
                },
                child: CardSettingsField(
                  label: label,
                  visible: visible,
                  errorText: field.errorText,
                  content: Text(
                    state.value ?? '',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  pickerIcon: Icons.arrow_drop_down,
                ),
              );
            });

  @override
  _CardSettingsListPickerState createState() =>
      new _CardSettingsListPickerState();
}

class _CardSettingsListPickerState extends FormFieldState<String> {
  @override
  CardSettingsListPicker get widget => super.widget;

  void _showDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return new PickerDialog(
          items: widget.options,
          title: Text('Select ' + widget.label),
          initialValue: value,
        );
      },
    ).then((value) {
      if (value != null) {
        didChange(value);
      }
    });
  }
}
