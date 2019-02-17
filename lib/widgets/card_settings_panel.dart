// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

/// This is the card wrapper that all the field controls are placed into
class CardSettings extends InheritedWidget {
  CardSettings({
    Key key,
    this.labelAlign,
    this.labelPadding,
    this.labelSuffix,
    this.contentAlign: TextAlign.left,
    this.padding: 12.0,
    this.cardElevation: 5.0,
    List<Widget> children,
  }) : super(
          key: key,
          child: Platform.isIOS
              ? CupertinoSettings(children)
              : SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  child: SafeArea(
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      elevation: cardElevation,
                      child: Column(children: children),
                    ),
                  ),
                ),
        );

  CardSettings.sectioned({
    Key key,
    this.labelAlign,
    this.labelPadding,
    this.labelSuffix,
    this.contentAlign: TextAlign.left,
    this.padding: 12.0,
    this.cardElevation: 5.0,
    List<CardSettingsSection> children,
  }) : super(
          key: key,
          child: Platform.isIOS
              ? CupertinoSettings(_buildSections(children))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  child: SafeArea(
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      elevation: cardElevation,
                      child: Column(children: _buildSections(children)),
                    ),
                  ),
                ),
        );

  final TextAlign labelAlign;
  final double labelPadding;
  final String labelSuffix;
  final TextAlign contentAlign;
  final double padding;
  final double cardElevation;

  static CardSettings of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CardSettings) as CardSettings;
  }

  @override
  bool updateShouldNotify(CardSettings old) {
    if (labelAlign != old.labelAlign) return true;
    if (labelPadding != old.labelPadding) return true;
    if (labelSuffix != old.labelSuffix) return true;
    if (contentAlign != old.contentAlign) return true;
    return false;
  }

  static List<Widget> _buildSections(List<CardSettingsSection> sections) {
    List<Widget> _children = <Widget>[];
    for (var row in sections) {
      _children.addAll(row.build());
    }
    return _children;
  }
}

class CardSettingsSection {
  CardSettingsSection({
    this.instructions,
    this.children,
    this.header,
  });

  final Widget header;
  final Widget instructions;
  final List<Widget> children;

  List<Widget> build() {
    List<Widget> _children = <Widget>[];
    if (Platform.isIOS) {
      if (header != null) _children.add(header);
      if (children != null) _children.addAll(children);
      if (instructions != null) _children.add(instructions);
    } else {
      if (header != null) _children.add(header);
      if (instructions != null) _children.add(instructions);
      if (children != null) _children.addAll(children);
    }

    return _children?.map((c) => SafeArea(child: c))?.toList();
  }
}
