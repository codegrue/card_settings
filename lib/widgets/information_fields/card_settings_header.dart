// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../card_settings_panel.dart';
import '../card_settings_widget.dart';

/// This is a header to distinguish sections of the form.
class CardSettingsHeader extends StatelessWidget implements CardSettingsWidget {
  CardSettingsHeader({
    this.label: 'Label',
    this.labelAlign: TextAlign.left,
    this.height: 44.0,
    this.color,
    this.showMaterialonIOS,
    this.visible = true,
    this.child,
    this.fieldPadding,
  });

  /// the text for the header
  final String label;

  /// how to align the header text
  final TextAlign labelAlign;

  /// the height of the content
  final double height;

  /// the background color
  final Color? color;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// The child to place in the content, instead of the label
  final Widget? child;

  /// placed padding around the entire widget
  final EdgeInsetsGeometry? fieldPadding;

  @override
  Widget build(BuildContext context) {
    if (!visible) return Container();
    if (child != null) return child ?? Container();

    if (showCupertino(context, showMaterialonIOS))
      return _cupertinoHeader(context);
    else
      return _materialHeader(context);
  }

  Widget _cupertinoHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CSHeader(label),
        ),
      ],
    );
  }

  Widget _materialHeader(BuildContext context) {
    EdgeInsetsGeometry _fieldPadding = (fieldPadding ??
        CardSettings.of(context)?.fieldPadding ??
        EdgeInsets.only(left: 14.0, top: 8.0, right: 14.0, bottom: 8.0));

    return Container(
      margin: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).secondaryHeaderColor,
      ),
      height: height,
      padding: _fieldPadding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headline6,
              textAlign: labelAlign,
            ),
          ),
        ],
      ),
    );
  }
}
