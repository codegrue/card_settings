// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// This helper widget manages a scrollable checkbox list inside a picker widget.
class CheckboxPicker extends StatefulWidget {
  CheckboxPicker(
      {Key key,
      @required this.items,
      @required this.initialValues,
      @required this.onChanged,
      this.itemHeight = defaultItemHeight,
      this.listViewWidth = defaultListviewWidth,
      this.numberOfVisibleItems = defaultNumberOfVisibleItems})
      : assert(items != null),
        listViewHeight = numberOfVisibleItems * itemHeight,
        super(key: key);

  // Constants
  static const double defaultItemHeight = 40.0;
  static const double defaultListviewWidth = 100.0;
  static const int defaultNumberOfVisibleItems = 10;

  // Events
  final ValueChanged<List<String>> onChanged;

  // Variables
  final List<String> items;
  final double itemHeight; // height of every list element in pixels
  final double listViewHeight;
  final int numberOfVisibleItems;
  final double listViewWidth;
  final List<String> initialValues;

  @override
  CheckboxPickerState createState() {
    return CheckboxPickerState(initialValues);
  }
}

class CheckboxPickerState extends State<CheckboxPicker> {
  CheckboxPickerState(this.selectedValues);

  final List<String> selectedValues;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return _listView(themeData);
  }

  Widget _listView(ThemeData themeData) {
    TextStyle defaultStyle = themeData.textTheme.body1;

    int itemCount = widget.items.length;

    return Container(
      height: widget.listViewHeight,
      width: widget.listViewWidth,
      child: Scrollbar(
        child: ListView.builder(
          itemExtent: widget.itemHeight,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              title: Text(
                widget.items[index],
                style: defaultStyle,
              ),
              value: selectedValues.contains(widget.items[index]),
              onChanged: (bool value) {
                setState(() {
                  if (value == true) {
                    selectedValues.add(widget.items[index]);
                  } else {
                    selectedValues.remove(widget.items[index]);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }
}
