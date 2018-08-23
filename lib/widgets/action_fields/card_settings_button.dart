// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// This is a button widget for inclusion in the form.
class CardSettingsButton extends StatelessWidget {
  CardSettingsButton({
    this.label: 'Label',
    @required this.onPressed,
    this.visible: true,
    this.backgroundColor,
    this.textColor,
    this.bottomSpacing: 0.0,
  });

  final String label;
  final bool visible;
  final Color backgroundColor;
  final Color textColor;
  final double bottomSpacing;

  // Events
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle =
        Theme.of(context).textTheme.button.copyWith(color: textColor);

    return (visible)
        ? Container(
            margin: EdgeInsets.only(
                top: 4.0, bottom: bottomSpacing, left: 4.0, right: 4.0),
            padding: EdgeInsets.all(0.0),
            color: backgroundColor ?? Theme.of(context).buttonColor,
            child: RawMaterialButton(
              padding: EdgeInsets.all(0.0),
              elevation: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    label,
                    style: buttonStyle,
                  ),
                ],
              ),
              fillColor: backgroundColor ?? Theme.of(context).buttonColor,
              onPressed: onPressed,
            ),
          )
        : Container();
  }
}
