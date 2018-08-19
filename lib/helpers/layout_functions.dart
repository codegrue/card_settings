// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// This allows two fields to be in a single row
Widget CardFieldLayout_TwoEqual({
  @required Widget child1,
  @required Widget child2,
}) {
  return Row(
    children: <Widget>[
      Expanded(
        child: child1,
      ),
      Expanded(
        child: child2,
      ),
    ],
  );
}

/// This allows three fields to be in a single row
Widget CardFieldLayout_ThreeEqual({
  @required Widget child1,
  @required Widget child2,
  @required Widget child3,
}) {
  return Row(
    children: <Widget>[
      Expanded(
        child: child1,
      ),
      Expanded(
        child: child2,
      ),
      Expanded(
        child: child3,
      ),
    ],
  );
}
