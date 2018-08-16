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
    this.requiredIndicator,
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
  final Icon icon;
  final Widget requiredIndicator;

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
                    _buildLabelRow(context),
                    _buildInlineContent(context),
                    _buildRightDecoration()
                  ],
                ),
                _buildRowContent()
              ],
            ),
          )
        : Container();
  }

  Widget _buildInlineContent(BuildContext context) {
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

  Widget _buildRowContent() {
    return (contentOnNewLine)
        ? Container(
            padding: EdgeInsets.only(top: 10.0),
            child: content,
          )
        : Container();
  }

  Widget _buildLabelRow(BuildContext context) {
    return Container(
      width: (contentOnNewLine) ? null : labelWidth,
      padding:
          EdgeInsets.only(right: CardSettings.of(context).labelPadding ?? 6.0),
      child: Row(
        children: <Widget>[
          _buildLeftIcon(context),
          _buildLabel(context),
          _buildRequiredIndicator(context),
          _buildLabelSuffix(context),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      label,
      style: _buildLabelStyle(context),
      textAlign: labelAlign ?? CardSettings.of(context).labelAlign,
    );
  }

  Widget _buildLabelSuffix(BuildContext context) {
    return Text(
      (CardSettings.of(context).labelSuffix == null)
          ? ''
          : CardSettings.of(context).labelSuffix,
      style: _buildLabelStyle(context),
    );
  }

  Widget _buildRequiredIndicator(BuildContext context) {
    if (requiredIndicator == null) return Container();

    if (requiredIndicator is Text) {
      var indicatorStyle = (requiredIndicator as Text).style;
      var style = _buildLabelStyle(context).merge(indicatorStyle);

      return Text(
        (requiredIndicator as Text).data,
        style: style,
      );
    }

    return requiredIndicator;
  }

  TextStyle _buildLabelStyle(BuildContext context) {
    TextStyle labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    );

    return labelStyle.merge(Theme.of(context).inputDecorationTheme.labelStyle);
  }

  Widget _buildLeftIcon(BuildContext context) {
    return (icon == null)
        ? Container()
        : Container(
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.only(right: 4.0),
            child: Icon(
              icon.icon,
              color: Theme.of(context).inputDecorationTheme.labelStyle.color,
            ),
          );
  }

  Widget _buildRightDecoration() {
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
