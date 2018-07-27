import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// This helper widget managed the scrollable content inside a picker widget.
class ScrollPicker extends StatelessWidget {
  static const double DEFAULT_ITEM_HEIGHT = 50.0;
  static const double DEFAULT_LISTVIEW_WIDTH = 100.0;
  static const int DEFAULT_NUMBER_OF_VISIBLE_ITEMS = 5;

  ///constructor for integer number picker
  ScrollPicker(
      {Key key,
      @required this.items,
      @required String initialValue,
      @required this.onChanged,
      this.itemHeight = DEFAULT_ITEM_HEIGHT,
      this.listViewWidth = DEFAULT_LISTVIEW_WIDTH,
      this.numberOfVisibleItems = DEFAULT_NUMBER_OF_VISIBLE_ITEMS})
      : assert(items != null),
        assert(numberOfVisibleItems % 2 != 0), // must be odd number
        selectedValue = initialValue,
        numberOfPaddingRows = ((numberOfVisibleItems - 1) ~/ 2),
        scrollController = new ScrollController(
          initialScrollOffset: items.indexOf(initialValue) * itemHeight,
        ),
        _listViewHeight = numberOfVisibleItems * itemHeight,
        super(key: key);

  // Events
  final ValueChanged<String> onChanged;

  // Variables
  final List<String> items;
  final double itemHeight; // height of every list element in pixels
  final double
      _listViewHeight; //view will always contain only 3 elements of list in pixels
  final int numberOfVisibleItems;
  final int numberOfPaddingRows;
  final double listViewWidth;

  ///width of list view in pixels
  final ScrollController scrollController;

  ///ScrollController used for integer list
  final String selectedValue;

  ///Currently selected integer value

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

    return new NotificationListener(
      child: new Container(
        height: _listViewHeight,
        width: listViewWidth,
        child: new ListView.builder(
          controller: scrollController,
          itemExtent: itemHeight,
          itemCount: itemCount,
          cacheExtent: _calculateCacheExtent(itemCount),
          itemBuilder: (BuildContext context, int index) {
            bool isPaddingRow = index < numberOfPaddingRows ||
                index >= itemCount - numberOfPaddingRows;

            String value =
                (isPaddingRow) ? null : items[index - numberOfPaddingRows];

            //define special style for selected (middle) element
            final TextStyle itemStyle =
                (value == selectedValue) ? selectedStyle : defaultStyle;

            return isPaddingRow
                ? new Container() //empty first and last element
                : new Center(
                    child: new Text(value, style: itemStyle),
                  );
          },
        ),
      ),
      onNotification: _onNotification,
    );
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int indexOfMiddleElement =
          (notification.metrics.pixels + _listViewHeight / 2) ~/ itemHeight -
              numberOfPaddingRows;

      if (_userStoppedScrolling(notification, scrollController)) {
        centerSelectedItemAnimation(indexOfMiddleElement);
      }

      //update selection
      String newValue = items[indexOfMiddleElement];
      if (newValue != selectedValue) {
        onChanged(newValue);
      }
    }
    return true;
  }

  centerSelectedItemAnimation(int indexToSelect) {
    scrollController.animateTo(indexToSelect * itemHeight,
        duration: new Duration(seconds: 1), curve: new ElasticOutCurve());
  }

  ///There was a bug, when if there was small integer range, e.g. from 1 to 5,
  ///When user scrolled to the top, whole listview got displayed.
  ///To prevent this we are calculating cacheExtent by our own so it gets smaller if number of items is smaller
  double _calculateCacheExtent(int itemCount) {
    double cacheExtent = 350.0; //default cache extent
    // if ((itemCount - 2) * DEFAULT_ITEM_HEIGHT <= cacheExtent) {
    //   cacheExtent = ((itemCount - 3) * DEFAULT_ITEM_HEIGHT);
    // }
    return cacheExtent;
  }

  // indicates if user has stopped scrolling so we can center value in the middle
  bool _userStoppedScrolling(
      Notification notification, ScrollController scrollController) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }
}
