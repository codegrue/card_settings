// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/widgets/card_settings_widget.dart';
import 'package:flutter/material.dart';

// Lays out multiple fields in a row
class CardFieldLayout extends StatelessWidget implements CardSettingsWidget {
  CardFieldLayout(
    this.children, {
    this.flexValues,
    this.visible: true,
    this.showMaterialonIOS,
  });

  final List<CardSettingsWidget> children;
  final List<int> flexValues;
  @override
  final bool showMaterialonIOS;
  @override
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) return null;

    int iterator = 0;

    return Row(
      children: children
          .map((c) => Flexible(
                child: c,
                flex: (flexValues == null) ? 1 : (flexValues[iterator++] ?? 1),
              ))
          .toList(),
    );
  }
}
