// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/checkbox_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';

/// This is a selection widget that allows an arbitrary list of options to be provided.
class CardSettingsMultiselect extends FormField<List<String>> {
  CardSettingsMultiselect({
    Key key,
    List<String> initialValues,
    FormFieldSetter<List<String>> onSaved,
    FormFieldValidator<List<String>> validator,
    bool autovalidate: false,
    this.onChanged,
    this.label = 'Label',
    this.visible = true,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.requiredIndicator,
    this.options,
    this.showMaterialIOS = false,
  }) : super(
          key: key,
          initialValue: initialValues,
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<List<String>> field) =>
              _CardSettingsMultiselectState().widget,
        );

  final String label;

  final TextAlign labelAlign;

  final TextAlign contentAlign;

  final Icon icon;

  final Widget requiredIndicator;

  final List<String> options;

  final bool visible;

  final ValueChanged<List<String>> onChanged;

  final bool showMaterialIOS;

  @override
  _CardSettingsMultiselectState createState() =>
      _CardSettingsMultiselectState();
}

class _CardSettingsMultiselectState extends FormFieldState<List<String>> {
  @override
  CardSettingsMultiselect get widget => super.widget as CardSettingsMultiselect;

  void _showDialog(String label, List<String> options) {
    if (Platform.isIOS && !widget.showMaterialIOS) {
      Navigator.push<List<String>>(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenSelect(
                initialItems: value,
                options: options,
                label: label,
              ),
          fullscreenDialog: true,
        ),
      ).then((value) {
        if (value != null) {
          didChange(value);
          if (widget.onChanged != null) widget.onChanged(value);
        }
      });
    } else {
      showDialog<List<String>>(
        context: context,
        builder: (BuildContext context) {
          return CheckboxDialog(
            items: options,
            title: 'Select ' + label,
            initialValues: value,
          );
        },
      ).then((value) {
        if (value != null) {
          didChange(value);
          if (widget.onChanged != null) widget.onChanged(value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && !widget.showMaterialIOS) {
      return Container(
        child: widget?.visible == false
            ? null
            : GestureDetector(
                onTap: () {
                  _showDialog(widget?.label, widget?.options);
                },
                child: CSControl(
                  widget?.requiredIndicator != null
                      ? (widget?.label ?? "") + ' *'
                      : widget?.label,
                  Text(value == null || value.isEmpty
                      ? "none selected"
                      : value.length == 1
                          ? "${value[0]}"
                          : "${value[0]} & ${value.length - 1} more"),
                  style: CSWidgetStyle(icon: widget?.icon),
                ),
              ),
      );
    }
    return GestureDetector(
      onTap: () {
        _showDialog(widget?.label, widget?.options);
      },
      child: CardSettingsField(
        label: widget?.label,
        labelAlign: widget?.labelAlign,
        visible: widget?.visible,
        icon: widget?.icon,
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        contentOnNewLine: true,
        content: Wrap(
          alignment: WrapAlignment.start,
          spacing: 4.0,
          runSpacing: 0.0,
          children: value
              .map(
                (s) => Chip(label: Text(s)),
              )
              .toList(),
        ),
        pickerIcon: Icons.arrow_drop_down,
      ),
    );
  }
}

class FullScreenSelect extends StatefulWidget {
  FullScreenSelect({this.label, this.initialItems, this.options});

  final List<String> initialItems;
  final List<String> options;
  final String label;
  @override
  _FullScreenSelectState createState() => _FullScreenSelectState();
}

class _FullScreenSelectState extends State<FullScreenSelect> {
  List<String> _selected = [];

  @override
  void initState() {
    _selected = widget?.initialItems ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontFamily: '.SF UI Text',
        inherit: false,
        fontSize: 17.0,
        color: CupertinoColors.black,
      ),
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          // We're specifying a back label here because the previous page is a
          // Material page. CupertinoPageRoutes could auto-populate these back
          // labels.
          previousPageTitle: 'Cupertino',
          middle: Text('Select ' + widget?.label),
          trailing: GestureDetector(
            child: Text(
              'Save',
              style: TextStyle(
                color: CupertinoColors.activeBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop(_selected);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: widget?.options?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final i = widget?.options[index];
            final bool select = _selected.contains(i);
            return ListTile(
              leading: select
                  ? const Icon(CupertinoIcons.check_mark)
                  : Icon(Icons.info, color: Colors.transparent),
              title: Text(i),
              onTap: () {
                setState(() {
                  if (select) {
                    _selected.remove(i);
                  } else {
                    _selected.add(i);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }
}
