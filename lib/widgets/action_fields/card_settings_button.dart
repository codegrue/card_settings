// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../interfaces/minimum_field_properties.dart';

/// This is a button widget for inclusion in the form.
class CardSettingsButton extends StatelessWidget
    implements IMinimumFieldSettings {
  CardSettingsButton({
    this.label: 'Label',
    required this.onPressed,
    this.visible: true,
    this.backgroundColor,
    this.textColor,
    this.enabled = true,
    this.bottomSpacing: 0.0,
    this.isDestructive = false,
    this.showMaterialonIOS,
  });

  /// The text to place in the button
  final String label;

  /// tells the Ui the button is destructive. Helps select color.
  final bool isDestructive;

  /// The background color for normal buttons
  final Color? backgroundColor;

  /// The text color for normal buttons
  final Color? textColor;

  /// allows adding extra padding at the bottom
  final double bottomSpacing;

  /// If false, grays out the field and makes it unresponsive
  final bool enabled;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Fires when the button is pressed
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle =
        Theme.of(context).textTheme.button!.copyWith(color: textColor);

    if (visible) {
      if (showCupertino(context, showMaterialonIOS))
        return _showCuppertinoButton();
      else
        return _showMaterialButton(context, buttonStyle);
    } else {
      return Container();
    }
  }

  Widget _showMaterialButton(BuildContext context, TextStyle buttonStyle) {
    var fillColor = backgroundColor ?? Theme.of(context).buttonColor;
    if (!enabled) fillColor = Colors.grey;

    return Container(
      margin: EdgeInsets.only(
          top: 4.0, bottom: bottomSpacing, left: 4.0, right: 4.0),
      padding: EdgeInsets.all(0.0),
      color: fillColor,
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
        fillColor: fillColor,
        onPressed: (enabled)
            ? onPressed
            : null, // to disable, we need to not provide an onPressed function
      ),
    );
  }

  Widget _showCuppertinoButton() {
    return Container(
      child: visible == false
          ? null
          : CSButton(
              isDestructive
                  ? CSButtonType.DESTRUCTIVE
                  : CSButtonType.DEFAULT_CENTER,
              label,
              onPressed,
            ),
    );
  }
}
