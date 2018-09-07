// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

// Lays out multiple fields in a row
class CardFieldLayout extends StatelessWidget {
  CardFieldLayout(this.children, {this.flexValues});

  final List<Widget> children;
  final List<int> flexValues;

  @override
  Widget build(BuildContext context) {
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
