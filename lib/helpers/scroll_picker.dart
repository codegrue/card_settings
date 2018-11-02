// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// This helper widget manages the scrollable content inside a picker widget.
class ScrollPicker extends StatelessWidget {
  ScrollPicker(
      {Key key,
      @required this.items,
      @required String initialValue,
      @required this.onChanged,
      this.itemHeight = defaultItemHeight,
      this.numberOfVisibleItems = defaultNumberOfVisibleItems})
      : assert(items != null),
        assert(numberOfVisibleItems % 2 != 0), // must be odd number
        selectedValue = initialValue,
        numberOfPaddingRows = ((numberOfVisibleItems - 1) ~/ 2),
        scrollController = ScrollController(
          initialScrollOffset: items.contains(initialValue)
              ? items.indexOf(initialValue) * itemHeight
              : 0.0,
        ),
        listViewHeight = numberOfVisibleItems * itemHeight,
        super(key: key);

  // Constants
  static const double defaultItemHeight = 50.0;
  static const int defaultNumberOfVisibleItems = 7;

  // Events
  final ValueChanged<String> onChanged;

  // Variables
  final List<String> items;
  final double itemHeight; // height of every list element in pixels
  final double listViewHeight;
  final int numberOfVisibleItems;
  final int numberOfPaddingRows;

  ///width of list view in pixels
  final ScrollController scrollController;

  ///ScrollController used for integer list
  final String selectedValue;

  ///main widget
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return _listView(themeData);
  }

  Widget _listView(ThemeData themeData) {
    TextStyle defaultStyle = themeData.textTheme.body1;
    TextStyle selectedStyle =
        themeData.textTheme.headline.copyWith(color: themeData.accentColor);

    int itemCount = items.length + numberOfPaddingRows * 2;

    return NotificationListener(
      child: SizedBox(
        height: listViewHeight,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            ListView.builder(
              controller: scrollController,
              itemExtent: itemHeight,
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                bool isPaddingRow = index < numberOfPaddingRows ||
                    index >= itemCount - numberOfPaddingRows;

                String value =
                    (isPaddingRow) ? null : items[index - numberOfPaddingRows];

                //define special style for selected (middle) element
                final TextStyle itemStyle =
                    (value == selectedValue) ? selectedStyle : defaultStyle;

                return isPaddingRow
                    ? Container() //empty items for padding rows
                    : GestureDetector(
                        onTap: () {
                          _itemTapped(index);
                        },
                        child: Container(
                          color: Colors
                              .transparent, // seems to be necessary to allow touches outside the item text
                          child: Center(
                            child: Text(value, style: itemStyle),
                          ),
                        ),
                      );
              },
            ),
            Center(
              child: Container(
                height: defaultItemHeight,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: themeData.accentColor, width: 1.0),
                    bottom:
                        BorderSide(color: themeData.accentColor, width: 1.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onNotification: _onNotification,
    );
  }

  void _itemTapped(int itemIndex) {
    int selectedIndex = itemIndex - numberOfPaddingRows;
    _changeSelectedItem(selectedIndex);
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      if (_userStoppedScrolling(notification, scrollController)) {
        int indexOfMiddleElement =
            (notification.metrics.pixels + listViewHeight / 2) ~/ itemHeight -
                numberOfPaddingRows;
        _changeSelectedItem(indexOfMiddleElement);
      }
    }
    return true;
  }

  void _changeSelectedItem(int itemIndex) {
    // update value with selected item
    String newValue = items[itemIndex];
    if (newValue != selectedValue) {
      onChanged(newValue);
    }

    // animate to and center on the selected item
    scrollController.animateTo(itemIndex * itemHeight,
        duration: Duration(seconds: 1), curve: ElasticOutCurve());
  }

  // indicates if user has stopped scrolling so we can center value in the middle
  bool _userStoppedScrolling(
    Notification notification,
    ScrollController scrollController,
  ) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }
}
