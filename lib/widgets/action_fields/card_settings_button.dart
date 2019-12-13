// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

/// This is a button widget for inclusion in the form.
class CardSettingsButton extends StatelessWidget {
  CardSettingsButton({
    this.label: 'Label',
    @required this.onPressed,
    this.visible: true,
    this.backgroundColor,
    this.textColor,
    this.bottomSpacing: 0.0,
    this.isDestructive = false,
    this.showMaterialonIOS = false,
  });

  final String label;
  final bool visible;
  final bool isDestructive;
  final Color backgroundColor;
  final Color textColor;
  final double bottomSpacing;
  final bool showMaterialonIOS;

  // Events
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle =
        Theme.of(context).textTheme.button.copyWith(color: textColor);

    if (visible) {
      if (Platform.isIOS && !showMaterialonIOS) {
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
        // return ListTile(
        //   title: CupertinoButton(
        //     color: backgroundColor ?? Theme.of(context).buttonColor,
        //     onPressed: onPressed,
        //     child: Text(
        //       label,
        //       style: buttonStyle,
        //     ),
        //   ),
        // );
      }
      return Container(
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
      );
    } else {
      return Container();
    }
  }
}
