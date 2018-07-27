import 'scroll_picker.dart';
import 'package:flutter/material.dart';

/// This is a support widget that returns an AlertDialog as a Widget.
/// It is designed to be used in the showDialog method of other fields.
class PickerDialog extends StatefulWidget {
  PickerDialog({
    this.title,
    this.items,
    this.initialValue,
    this.titlePadding,
    Widget confirmWidget,
    Widget cancelWidget,
  })  : confirmWidget = confirmWidget ?? new Text("OK"),
        cancelWidget = cancelWidget ?? new Text("CANCEL");

  // Variables
  final List<String> items;
  final String initialValue;
  final Widget title;
  final EdgeInsets titlePadding;
  final Widget confirmWidget;
  final Widget cancelWidget;

  @override
  State<PickerDialog> createState() => new _PickerDialogState(initialValue);
}

class _PickerDialogState extends State<PickerDialog> {
  _PickerDialogState(this.selectedValue);

  String selectedValue;

  _handleValueChanged(String value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: widget.title,
      titlePadding: widget.titlePadding,
      content: ScrollPicker(
        items: widget.items,
        initialValue: selectedValue,
        onChanged: _handleValueChanged,
      ),
      actions: [
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: widget.cancelWidget,
        ),
        new FlatButton(
            onPressed: () => Navigator.of(context).pop(selectedValue),
            child: widget.confirmWidget),
      ],
    );
  }
}
