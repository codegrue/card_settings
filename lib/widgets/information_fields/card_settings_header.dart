// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

/// This is a header to distinguish sections of the form.
class CardSettingsHeader extends StatelessWidget {
  CardSettingsHeader({
    this.label: 'Label',
    this.labelAlign: TextAlign.left,
    this.height: 44.0,
    this.color,
    this.showMaterialonIOS = false,
  });

  final String label;
  final TextAlign labelAlign;
  final double height;
  final Color color;
  final bool showMaterialonIOS;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && !showMaterialonIOS) {
      return CSHeader(label);
    }
    return Container(
      margin: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey
              : color ?? Theme.of(context).accentColor),
      height: height,
      padding: EdgeInsets.only(left: 14.0, top: 8.0, right: 14.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).primaryTextTheme.title,
              textAlign: labelAlign,
            ),
          ),
        ],
      ),
    );
  }
}
