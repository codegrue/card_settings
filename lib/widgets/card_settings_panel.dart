// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/card_settings.dart';
import 'package:card_settings/helpers/platform_functions.dart';
import 'package:card_settings/widgets/card_settings_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import 'information_fields/card_settings_header.dart';
import 'information_fields/card_settings_instructions.dart';

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
    this.showMaterialonIOS: false,
    this.shrinkWrap = false,
    this.cardless = false,
    this.divider,
  }) : super(
          key: key,
          child: CardSettingsContent(
            children: children,
            showMaterialonIOS: showMaterialonIOS,
            cardElevation: cardElevation,
            padding: padding,
            shrinkWrap: shrinkWrap,
            sectioned: false,
            cardless: cardless,
          ),
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
    this.showMaterialonIOS: false,
    this.shrinkWrap = true,
    this.cardless = false,
    this.divider,
  }) : super(
          key: key,
          child: CardSettingsContent(
            children: children,
            showMaterialonIOS: showMaterialonIOS,
            cardElevation: cardElevation,
            padding: padding,
            shrinkWrap: shrinkWrap,
            sectioned: true,
            cardless: cardless,
          ),
        );

  final TextAlign labelAlign;
  final double labelWidth;
  final double labelPadding;
  final String labelSuffix;
  final TextAlign contentAlign;
  final double padding;
  final double cardElevation;
  final bool shrinkWrap;
  final bool showMaterialonIOS;
  final bool cardless;
  final Divider divider;

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
}

class CardSettingsContent extends StatelessWidget {
  const CardSettingsContent({
    Key key,
    @required this.children,
    @required this.showMaterialonIOS,
    @required this.cardElevation,
    @required this.padding,
    @required this.shrinkWrap,
    @required this.sectioned,
    @required this.cardless,
  }) : super(key: key);

  final List<CardSettingsSection> children;
  final bool showMaterialonIOS;
  final double cardElevation;
  final double padding;
  final bool shrinkWrap;
  final bool sectioned;
  final bool cardless;

  @override
  Widget build(BuildContext context) {
    return (showCupertino(null, showMaterialonIOS))
        ? _buildCupertinoWrapper()
        : _buildMaterialWrapper(context);
  }

  Widget _buildCupertinoWrapper() {
    return CupertinoSettings(
      items: children,
      shrinkWrap: shrinkWrap,
    );
  }

  Widget _buildMaterialWrapper(BuildContext context) {
    if (sectioned) {
      return SafeArea(
        child: ListView(
          children: _buildMaterialSections(context),
          shrinkWrap: shrinkWrap,
        ),
      );
    } else {
      var childList = ListView(children: children);

      return SafeArea(
        child: Container(
          padding: EdgeInsets.all(padding),
          child: (cardless)
              ? Container(
                  margin: EdgeInsets.all(0.0),
                  child: childList,
                )
              : Card(
                  margin: EdgeInsets.all(0.0),
                  clipBehavior: Theme.of(context).cardTheme.clipBehavior ??
                      Clip.antiAlias,
                  elevation: cardElevation,
                  child: childList,
                ),
        ),
      );
    }
  }

  List<Widget> _buildMaterialSections(BuildContext context) {
    List<Widget> _children = <Widget>[];
    for (var row in children) {
      _children.add(
        Container(
          padding: EdgeInsets.fromLTRB(padding, padding, padding, 0.0),
          child: (cardless)
              ? Container(
                  child: row.build(context),
                )
              : Card(
                  clipBehavior: Theme.of(context).cardTheme.clipBehavior ??
                      Clip.antiAlias,
                  elevation: cardElevation,
                  child: row.build(context),
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
    this.showMaterialonIOS,
    this.divider,
  });

  final CardSettingsHeader header;
  final CardSettingsInstructions instructions;
  final List<CardSettingsWidget> children;
  final bool showMaterialonIOS;
  final Divider divider;

  @override
  Widget build(BuildContext context) {
    var _divider = divider ??
        CardSettings.of(context).divider ??
        Divider(
          thickness: 1.0,
          color: Theme.of(context).dividerColor,
        );

    List<Widget> _children = <Widget>[];
    if (showCupertino(context, showMaterialonIOS)) {
      if (header != null) _children.add(header);
      if (children != null) _children.addAll(children);
      if (instructions != null) _children.add(instructions);
    } else {
      if (header != null) _children.add(header);
      if (instructions != null) _children.add(instructions);

      if (children != null) {
        var visibleChildren = children.where((c) => c.visible);
        for (var child in visibleChildren) {
          _children.add(child);

          var addDivider = true;
          if (child is CardSettingsButton)
            addDivider = false; // don't put divider between buttons
          if (child == visibleChildren.last)
            addDivider = false; // don't put a divider after the last item
          if (addDivider) _children.add(_divider);
        }
      }
    }

    //return Column(children: _children);

    return Column(
      children: _children,
    );
  }
}
