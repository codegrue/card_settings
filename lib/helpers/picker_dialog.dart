// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'scroll_picker.dart';
import 'package:flutter/material.dart';

// Constants
const double _kPickerHeaderPortraitHeight = 60.0;
const double _kPickerHeaderLandscapeWidth = 168.0;
const double _kPickerPortraitWidth = 330.0;
const double _kPickerLandscapeWidth = 400.0;
const double _kDialogActionBarHeight = 52.0;

/// This is a support widget that returns an AlertDialog as a Widget.
/// It is designed to be used in the showDialog method of other fields.
class PickerDialog extends StatefulWidget {
  PickerDialog({
    this.title,
    this.items,
    this.initialValue,
    Widget confirmWidget,
    Widget cancelWidget,
  })  : confirmWidget = confirmWidget ?? Text("OK"),
        cancelWidget = cancelWidget ?? Text("CANCEL");

  // Variables
  final List<String> items;
  final String initialValue;
  final String title;
  final Widget confirmWidget;
  final Widget cancelWidget;

  @override
  State<PickerDialog> createState() => _PickerDialogState(initialValue);
}

class _PickerDialogState extends State<PickerDialog> {
  _PickerDialogState(this.selectedValue);

  String selectedValue;

  MaterialLocalizations localizations;
  ThemeData theme;
  final GlobalKey _pickerKey = GlobalKey();

  void _handleValueChanged(String value) {
    setState(() => selectedValue = value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    assert(context != null);
    final Widget actions = ButtonTheme.bar(
      child: Container(
        height: _kDialogActionBarHeight,
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text(localizations.cancelButtonLabel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(localizations.okButtonLabel),
              onPressed: () => Navigator.of(context).pop(selectedValue),
            ),
          ],
        ),
      ),
    );
    return Dialog(
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          assert(orientation != null);
          assert(context != null);
          final Widget picker = ScrollPicker(
            key: _pickerKey,
            items: widget.items,
            initialValue: selectedValue,
            onChanged: _handleValueChanged,
            listViewWidth: (orientation == Orientation.portrait)
                ? _kPickerPortraitWidth
                : _kPickerLandscapeWidth,
            numberOfVisibleItems: (orientation == Orientation.portrait) ? 7 : 5,
          );
          final Widget header = Container(
            color: theme.primaryColor,
            height: (orientation == Orientation.portrait)
                ? _kPickerHeaderPortraitHeight
                : null,
            width: (orientation == Orientation.landscape)
                ? _kPickerHeaderLandscapeWidth
                : null,
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            padding: EdgeInsets.all(20.0),
          );
          switch (orientation) {
            case Orientation.portrait:
              return SizedBox(
                width: _kPickerPortraitWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    header,
                    Container(
                      color: theme.dialogBackgroundColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          picker,
                          actions,
                        ],
                      ),
                    ),
                  ],
                ),
              );
            case Orientation.landscape:
              return SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    header,
                    Container(
                      color: theme.dialogBackgroundColor,
                      width: _kPickerLandscapeWidth,
                      child: Column(
                        children: <Widget>[
                          picker,
                          Expanded(child: Container()),
                          actions,
                        ],
                      ),
                    )
                  ],
                ),
              );
          }
          return null;
        },
      ),
    );
  }
}
