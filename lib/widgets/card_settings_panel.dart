// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

/// This is the card wrapper that all the field controls are placed into
class CardSettings extends InheritedWidget {
  CardSettings({
    Key key,
    this.labelAlign,
    this.labelWidth,
    this.labelPadding,
    this.labelSuffix,
    this.contentAlign: TextAlign.left,
    this.padding: 8.0,
    this.cardElevation: 5.0,
    List<CardSettingsSection> children,
    bool showMaterialonIOS: false,
    this.shrinkWrap = false,
  }) : super(
          key: key,
          child: _buildChild(children, showMaterialonIOS, cardElevation,
              padding, shrinkWrap, false),
        );

  // constructor that wraps each section in it's own card
  CardSettings.sectioned({
    Key key,
    this.labelAlign,
    this.labelWidth,
    this.labelPadding,
    this.labelSuffix,
    this.contentAlign: TextAlign.left,
    this.padding: 8.0,
    this.cardElevation: 5.0,
    List<CardSettingsSection> children,
    bool showMaterialonIOS: false,
    this.shrinkWrap = false,
  }) : super(
          key: key,
          child: _buildChild(children, showMaterialonIOS, cardElevation,
              padding, shrinkWrap, true),
        );

  final TextAlign labelAlign;
  final double labelWidth;
  final double labelPadding;
  final String labelSuffix;
  final TextAlign contentAlign;
  final double padding;
  final double cardElevation;
  final bool shrinkWrap;

  static CardSettings of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CardSettings>();
  }

  // notify child widgets if a setting changes on the overall wrapper
  @override
  bool updateShouldNotify(CardSettings old) {
    if (labelAlign != old.labelAlign) return true;
    if (labelWidth != old.labelWidth) return true;
    if (labelPadding != old.labelPadding) return true;
    if (labelSuffix != old.labelSuffix) return true;
    if (contentAlign != old.contentAlign) return true;
    return false;
  }

  static Widget _buildChild(
      List<CardSettingsSection> children,
      bool showMaterialonIOS,
      double cardElevation,
      double padding,
      bool shrinkWrap,
      bool sectioned) {
    return (showCupertino(showMaterialonIOS))
        ? _buildCupertinoWrapper(children, shrinkWrap)
        : _buildMaterialWrapper(
            children, padding, cardElevation, shrinkWrap, sectioned);
  }

  static Widget _buildMaterialWrapper(List<CardSettingsSection> children,
      double padding, double cardElevation, bool shrinkWrap, bool sectioned) {
    if (sectioned) {
      return ListView(
        children: _buildSections(children, cardElevation, padding),
        shrinkWrap: shrinkWrap,
      );
    } else {
      return SafeArea(
        child: Container(
          padding: EdgeInsets.all(padding),
          child: Card(
            margin: EdgeInsets.all(0.0),
            elevation: cardElevation,
            child: ListView(
              children: children,
              shrinkWrap: shrinkWrap,
            ),
          ),
        ),
      );
    }
  }

  static Widget _buildCupertinoWrapper(
      List<CardSettingsSection> children, bool shrinkWrap) {
    return CupertinoSettings(
      items: children,
      shrinkWrap: shrinkWrap,
    );
  }

  static List<Widget> _buildSections(List<CardSettingsSection> sections,
      double cardElevation, double padding) {
    List<Widget> _children = <Widget>[];
    for (var row in sections) {
      _children.add(
        SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(padding, padding, padding, 0.0),
            child: Card(
              elevation: cardElevation,
              child: row.build(null),
            ),
          ),
        ),
      );
    }
    return _children;
  }
}

class CardSettingsSection extends StatelessWidget {
  CardSettingsSection({
    this.instructions,
    this.children,
    this.header,
    this.showMaterialonIOS = false,
  });

  final Widget header;
  final Widget instructions;
  final List<Widget> children;
  final bool showMaterialonIOS;

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = <Widget>[];
    if (showCupertino(showMaterialonIOS)) {
      if (header != null) _children.add(header);
      if (children != null) _children.addAll(children);
      if (instructions != null) _children.add(instructions);
    } else {
      if (header != null) _children.add(header);
      if (instructions != null) _children.add(instructions);
      if (children != null) _children.addAll(children);
    }

    return Column(children: _children);
  }
}
