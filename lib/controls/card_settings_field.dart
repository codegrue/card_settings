// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// This is the basic layout of a field in a CardSettings view. Typcially, it
/// will not be used directly.
class CardSettingsField extends StatelessWidget {
  CardSettingsField({
    this.label: 'Label',
    this.content,
    this.showIcon: false,
    this.pickerIcon,
    this.contentPaddingAdjustment = 0.0,
    this.contentOnNewLine = false,
    this.unitLabel,
    this.errorText,
    this.visible: true,
  });

  final String label;
  final String unitLabel;
  final Widget content;
  final bool showIcon;
  final IconData pickerIcon;
  final double contentPaddingAdjustment;
  final bool contentOnNewLine;
  final String errorText;
  final bool visible;

  Widget build(BuildContext context) {
    return (visible)
        ? Container(
            decoration: new BoxDecoration(
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
                    buildLabel(),
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
    // if content is not a TextFormField, add a decorator to show validation errors
    var wrappedContent = content;
    if (wrappedContent is! TextFormField) {
      final InputDecoration effectiveDecoration = const InputDecoration()
          .applyDefaults(Theme.of(context).inputDecorationTheme)
          .copyWith(
              errorText: errorText,
              contentPadding: EdgeInsets.all(0.0),
              border: InputBorder.none);

      wrappedContent =
          InputDecorator(decoration: effectiveDecoration, child: content);
    }

    return Expanded(child: contentOnNewLine ? Text('') : wrappedContent);
  }

  Widget buildRowContent() {
    return (contentOnNewLine)
        ? Container(
            padding: EdgeInsets.only(top: 10.0),
            child: content,
          )
        : Container();
  }

  Widget buildLabel() {
    return Container(
      width: 120.0 - contentPaddingAdjustment,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildLeftDecoration() {
    return (showIcon)
        ? Container(
            width: 20.0,
            child: Text('X'),
          )
        : Container();
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
