// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

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
  })  : confirmWidget = confirmWidget ?? Text("OK"),
        cancelWidget = cancelWidget ?? Text("CANCEL");

  // Variables
  final List<String> items;
  final String initialValue;
  final Widget title;
  final EdgeInsets titlePadding;
  final Widget confirmWidget;
  final Widget cancelWidget;

  @override
  State<PickerDialog> createState() => _PickerDialogState(initialValue);
}

class _PickerDialogState extends State<PickerDialog> {
  _PickerDialogState(this.selectedValue);

  String selectedValue;

  void _handleValueChanged(String value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      titlePadding: widget.titlePadding,
      content: ScrollPicker(
        items: widget.items,
        initialValue: selectedValue,
        onChanged: _handleValueChanged,
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: widget.cancelWidget,
        ),
        FlatButton(
            onPressed: () => Navigator.of(context).pop(selectedValue),
            child: widget.confirmWidget),
      ],
    );
  }
}
