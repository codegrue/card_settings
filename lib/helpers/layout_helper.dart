// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

// Lays out multiple fields equally spaced in a row
Widget CardFieldLayout_EqualSpaced({
  @required List<Widget> children,
}) {
  return Row(
    children: children.map((c) => Expanded(child: c)).toList(),
  );
}

// Lays out multiple fields in a row with a user defined spacing
Widget CardFieldLayout_FractionallySpaced({
  @required List<Widget> children,
  @required List<double> widthFactors,
}) {
  assert(children.length == widthFactors.length);

  int iterator = 0;

  return Wrap(
    children: children
        .map((c) => FractionallySizedBox(
      child: c,
      widthFactor: widthFactors[iterator++],
    ))
        .toList(),
  );
}
