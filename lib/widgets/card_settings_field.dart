// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';

/// This is the basic layout of a field in a CardSettings view. Typcially, it
/// will not be used directly.
class CardSettingsField extends StatelessWidget {
  CardSettingsField({
    this.label: 'Label',
    this.content,
    this.icon,
    this.pickerIcon,
    this.labelWidth = 120.0,
    this.contentOnNewLine = false,
    this.unitLabel,
    this.errorText,
    this.visible: true,
    this.labelAlign,
  });

  final String label;
  final String unitLabel;
  final Widget content;
  final IconData pickerIcon;
  final double labelWidth;
  final bool contentOnNewLine;
  final String errorText;
  final bool visible;
  final TextAlign labelAlign;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return (visible)
        ? Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1.0, color: Theme.of(context).dividerColor)),
            ),
            padding: EdgeInsets.all(14.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildLeftDecoration(),
                    buildLabel(context),
                    buildInlineContent(context),
                    buildRightDecoration()
                  ],
                ),
                buildRowContent()
              ],
            ),
          )
        : Container();
  }

  Widget buildInlineContent(BuildContext context) {
    var decoratedContent = content;
    if (content is TextField || content is TextFormField) {
      // do nothing, these already have built in InputDecorations
    } else {
      // wrap in a decorator to show validation errors
      final InputDecoration decoration = const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
              errorText: errorText,
              contentPadding: EdgeInsets.all(0.0),
              border: InputBorder.none);

      decoratedContent = InputDecorator(decoration: decoration, child: content);
    }

    return Expanded(child: contentOnNewLine ? Text('') : decoratedContent);
  }

  Widget buildRowContent() {
    return (contentOnNewLine)
        ? Container(
            padding: EdgeInsets.only(top: 10.0),
            child: content,
          )
        : Container();
  }

  Widget buildLabel(BuildContext context) {
    String labelSuffix = (CardSettings.of(context).labelSuffix == null)
        ? ''
        : CardSettings.of(context).labelSuffix;

    TextStyle labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    );

    return Container(
      width: labelWidth,
      padding:
          EdgeInsets.only(right: CardSettings.of(context).labelPadding ?? 6.0),
      child: Text(
        label + labelSuffix,
        style:
            labelStyle.merge(Theme.of(context).inputDecorationTheme.labelStyle),
        textAlign: labelAlign ?? CardSettings.of(context).labelAlign,
      ),
    );
  }

  Widget buildLeftDecoration() {
    return (icon == null)
        ? Container()
        : Container(
            width: 20.0,
            child: icon,
          );
  }

  Widget buildRightDecoration() {
    return (pickerIcon != null || unitLabel != null)
        ? Container(
            alignment: Alignment.centerRight,
            child: (pickerIcon != null)
                ? Icon(pickerIcon)
                : Text(
                    unitLabel,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
          )
        : Container();
  }
}
