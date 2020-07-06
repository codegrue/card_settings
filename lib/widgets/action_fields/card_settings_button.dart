// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../Interfaces/common_row_properties.dart';

/// This is a button widget for inclusion in the form.
class CardSettingsButton extends StatelessWidget
    implements ICommonRowProperties {
  CardSettingsButton({
    this.label: 'Label',
    @required this.onPressed,
    this.visible: true,
    this.backgroundColor,
    this.textColor,
    this.enabled = true,
    this.bottomSpacing: 0.0,
    this.isDestructive = false,
    this.showMaterialonIOS,
  });

  final String label;

  final bool isDestructive;
  final Color backgroundColor;
  final Color textColor;
  final double bottomSpacing;
  final bool enabled;
  @override
  final bool showMaterialonIOS;
  @override
  final bool visible;

  // Events
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle =
        Theme.of(context).textTheme.button.copyWith(color: textColor);

    if (visible) {
      if (showCupertino(context, showMaterialonIOS))
        return showCuppertinoButton();
      else
        return showMaterialButton(context, buttonStyle);
    } else {
      return Container();
    }
  }

  Widget showMaterialButton(BuildContext context, TextStyle buttonStyle) {
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

  Widget showCuppertinoButton() {
    return Container(
      child: visible == false
          ? null
          : CSButton(
              isDestructive
                  ? CSButtonType.DESTRUCTIVE
                  : CSButtonType.DEFAULT_CENTER,
              label,
              (enabled)
                  ? onPressed
                  : null, // to disable, we need to not provide an onPressed function
            ),
    );
  }
}
