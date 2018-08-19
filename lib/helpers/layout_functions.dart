// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

Widget CardFieldLayout_EqualSpaced({
  @required List<Widget> children,
}) {
  return Row(
    children: children.map((c) => Expanded(child: c)).toList(),
  );
}
