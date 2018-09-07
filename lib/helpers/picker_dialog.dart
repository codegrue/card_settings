// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'scroll_picker.dart';
import 'package:flutter/material.dart';

// Constants
const double _kPickerHeaderPortraitHeight = 60.0;
const double _kDialogActionBarHeight = 50.0;
const double _kDialogMargin = 30.0;

/// This is a support widget that returns an Dialog with a picker as a Widget.
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

    return Dialog(
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          assert(orientation != null);
          assert(context != null);

          // calculate nunmber of items to show based on the vertical
          // space the picker will have
          var height =
              MediaQuery.of(context).size.height - (_kDialogMargin * 2);
          double spaceForPicker = height -
              _kDialogActionBarHeight -
              ((orientation == Orientation.portrait)
                  ? _kPickerHeaderPortraitHeight
                  : 0);
          int numberOfItems =
              (spaceForPicker / ScrollPicker.defaultItemHeight).floor();
          if (numberOfItems.isEven) numberOfItems--;

          final Widget picker = Container(
            child: Center(
              child: ScrollPicker(
                key: _pickerKey,
                items: widget.items,
                initialValue: selectedValue,
                onChanged: _handleValueChanged,
                numberOfVisibleItems: numberOfItems,
              ),
            ),
          );

          final Widget header = Container(
            color: theme.primaryColor,
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

          final Widget actions = ButtonTheme.bar(
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
          );

          switch (orientation) {
            case Orientation.portrait:
              return SizedBox(
                //width: width,
                //height: height,
                child: Container(
                  color: theme.dialogBackgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      header,
                      Expanded(child: picker),
                      actions,
                    ],
                  ),
                ),
              );
            case Orientation.landscape:
              return SizedBox(
                //width: width,
                //height: height,
                child: Row(
                  children: <Widget>[
                    header,
                    Expanded(
                      child: Container(
                        color: theme.dialogBackgroundColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(child: picker),
                            actions,
                          ],
                        ),
                      ),
                    ),
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
