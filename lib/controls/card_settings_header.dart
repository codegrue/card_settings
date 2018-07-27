import 'package:flutter/material.dart';

/// This is a header to distinguish sections of the form.
class CardSettingsHeader extends StatelessWidget {
  CardSettingsHeader({
    this.label: 'Label',
    this.height: 44.0,
    this.color,
  });

  final String label;
  final double height;
  final Color color;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0.0),
      decoration:
          new BoxDecoration(color: color ?? Theme.of(context).accentColor),
      height: height,
      padding: EdgeInsets.only(left: 14.0, top: 8.0, right: 14.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Text(label, style: Theme.of(context).primaryTextTheme.title),
        ],
      ),
    );
  }
}
