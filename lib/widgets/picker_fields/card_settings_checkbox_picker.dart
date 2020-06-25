// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_attributes.dart';

/// This is a selection widget that allows an arbitrary list of options to be provided.
class CardSettingsCheckboxPicker extends FormField<List<String>>
    implements ICommonFieldProperties {
  CardSettingsCheckboxPicker({
    Key key,
    List<String> initialValues,
    FormFieldSetter<List<String>> onSaved,
    FormFieldValidator<List<String>> validator,
    bool autovalidate: false,
    this.enabled = true,
    this.onChanged,
    this.label = 'Select',
    this.visible = true,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.labelWidth,
    this.requiredIndicator,
    this.options,
    this.showMaterialonIOS,
  }) : super(
          key: key,
          initialValue: initialValues,
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<List<String>> field) =>
              (field as _CardSettingsCheckboxPickerState)._build(field.context),
        );

  @override
  final String label;

  @override
  final bool enabled;

  @override
  final TextAlign labelAlign;

  @override
  final double labelWidth;

  @override
  final TextAlign contentAlign;

  @override
  final Icon icon;

  @override
  final Widget requiredIndicator;

  final List<String> options;

  @override
  final bool visible;

  @override
  final ValueChanged<List<String>> onChanged;

  @override
  final bool showMaterialonIOS;

  @override
  _CardSettingsCheckboxPickerState createState() =>
      _CardSettingsCheckboxPickerState();
}

class _CardSettingsCheckboxPickerState extends FormFieldState<List<String>> {
  @override
  CardSettingsCheckboxPicker get widget =>
      super.widget as CardSettingsCheckboxPicker;

  void _showDialog(String label, List<String> options) {
    if (showCupertino(context, widget.showMaterialonIOS))
      _showCupertinoSelectPicker(options, label);
    else
      _showMaterialCheckboxPicker(options, label);
  }

  void _showMaterialCheckboxPicker(List<String> options, String label) {
    showMaterialCheckboxPicker(
      context: context,
      title: label,
      items: options,
      selectedItems: value,
      onChanged: (List<String> selectedValues) {
        if (selectedValues != null) {
          didChange(selectedValues);
          if (widget.onChanged != null) widget.onChanged(selectedValues);
        }
      },
    );
  }

  void _showCupertinoSelectPicker(List<String> options, String label) {
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
    ).then((selectedValues) {
      if (selectedValues != null) {
        didChange(selectedValues);
        if (widget.onChanged != null) widget.onChanged(selectedValues);
      }
    });
  }

  Widget _build(BuildContext context) {
    if (showCupertino(context, widget.showMaterialonIOS))
      return cupertinoSettingsMultiselect();
    else
      return materialSettingsMultiselect();
  }

  Widget cupertinoSettingsMultiselect() {
    return Container(
      child: widget?.visible == false
          ? null
          : GestureDetector(
              onTap: () {
                if (widget.enabled) _showDialog(widget?.label, widget?.options);
              },
              child: CSControl(
                nameWidget: Container(
                  width: widget?.labelWidth ??
                      CardSettings.of(context).labelWidth ??
                      120.0,
                  child: widget?.requiredIndicator != null
                      ? Text((widget?.label ?? "") + ' *')
                      : Text(widget?.label),
                ),
                contentWidget: Text(
                  value == null || value.isEmpty
                      ? "none selected"
                      : value.length == 1
                          ? "${value[0]}"
                          : "${value[0]} & ${value.length - 1} more",
                  style: contentStyle(context, value, widget.enabled),
                ),
                style: CSWidgetStyle(icon: widget?.icon),
              ),
            ),
    );
  }

  Widget materialSettingsMultiselect() {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog(widget?.label, widget?.options);
      },
      child: CardSettingsField(
        label: widget?.label,
        labelAlign: widget?.labelAlign,
        labelWidth: widget?.labelWidth,
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
                (s) => Chip(
                    label: Text(s,
                        style: contentStyle(context, value, widget.enabled))),
              )
              .toList(),
        ),
        pickerIcon: (widget.enabled) ? Icons.arrow_drop_down : null,
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
      style: TextStyle(
        fontFamily: '.SF UI Text',
        inherit: false,
        fontSize: 17.0 * MediaQuery.of(context).textScaleFactor,
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
