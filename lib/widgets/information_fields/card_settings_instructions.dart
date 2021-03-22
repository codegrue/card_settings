// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../card_settings_panel.dart';
import '../card_settings_widget.dart';

/// This is a read only section of text
class CardSettingsInstructions extends StatelessWidget
    implements CardSettingsWidget {
  CardSettingsInstructions({
    this.text: 'Instructions here...',
    this.backgroundColor,
    this.textColor,
    this.showMaterialonIOS,
    this.visible = true,
    this.fieldPadding,
  });

  /// The text for the instructions
  final String text;

  /// the color for the background
  final Color? backgroundColor;

  /// The color of the text
  final Color? textColor;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// padding to place around then entire field
  final EdgeInsetsGeometry? fieldPadding;

  @override
  Widget build(BuildContext context) {
    if (!visible) return Container();

    TextStyle textStyle = Theme.of(context)
        .primaryTextTheme
        .caption!
        .copyWith(color: textColor ?? Theme.of(context).accentColor);
    if (showCupertino(context, showMaterialonIOS)) {
      return Container(
        padding: EdgeInsets.only(top: 8.0, left: 8.0),
        child: Text(
          text,
          style: TextStyle(color: CupertinoColors.inactiveGray),
        ),
        // color: CupertinoColors.lightBackgroundGray,
      );
    } else
      return _materialInstruction(context, textStyle);
  }

  Widget _materialInstruction(BuildContext context, TextStyle textStyle) {
    EdgeInsetsGeometry _fieldPadding = (fieldPadding ??
        CardSettings.of(context)?.fieldPadding ??
        EdgeInsets.all(14.0));

    return Container(
      margin: EdgeInsets.all(0.0),
      decoration:
          BoxDecoration(color: backgroundColor ?? Theme.of(context).cardColor),
      padding: _fieldPadding,
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
