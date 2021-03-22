// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/widgets/card_settings_widget.dart';
import 'package:flutter/material.dart';

/// Lays out multiple fields in a row
class CardFieldLayout extends StatelessWidget implements CardSettingsWidget {
  CardFieldLayout(
    this.children, {
    this.flexValues,
    this.visible: true,
    this.showMaterialonIOS: false,
  });

  /// the field widgets to place into the layout
  final List<CardSettingsWidget> children;

  /// the values that control the relative widths of the layed out widgets
  final List<int>? flexValues;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool showMaterialonIOS;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) return Container();

    int iterator = 0;

    return Row(
      children: children
          .map((c) => Flexible(
                child: c,
                flex: (flexValues == null) ? 1 : (flexValues?[iterator++] ?? 1),
              ))
          .toList(),
    );
  }
}
