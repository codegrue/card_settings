// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a selection widget that allows an arbitrary list of options to be provided.
class CardSettingsCheckboxPicker extends FormField<List<String>>
    implements ICommonFieldProperties {
  CardSettingsCheckboxPicker({
    Key? key,
    List<String>? initialValues,
    FormFieldSetter<List<String>>? onSaved,
    FormFieldValidator<List<String>>? validator,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    this.enabled = true,
    this.onChanged,
    this.label = 'Select',
    this.visible = true,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.labelWidth,
    this.requiredIndicator,
    required this.options,
    this.values,
    this.showMaterialonIOS,
    this.fieldPadding,
  })  : assert(values == null || options.length == values.length,
            "If you provide 'values', they need the same number as 'options'"),
        super(
          key: key,
          initialValue: initialValues,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<List<String>> field) =>
              (field as _CardSettingsCheckboxPickerState)._build(field.context),
        );

  /// The text to identify the field to the user
  @override
  final String label;

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// The alignment of the label paret of the field. Default is left.
  @override
  final TextAlign? labelAlign;

  /// The width of the field label. If provided overrides the global setting.
  @override
  final double? labelWidth;

  /// controls how the widget in the content area of the field is aligned
  @override
  final TextAlign? contentAlign;

  /// The icon to display to the left of the field content
  @override
  final Icon? icon;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// a list of options to display in the picker
  final List<String> options;

  /// a list of values for each option. If null, options are values.
  final List<String>? values;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Fires when the picked values are changed
  @override
  final ValueChanged<List<String>>? onChanged;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  @override
  _CardSettingsCheckboxPickerState createState() =>
      _CardSettingsCheckboxPickerState();
}

class _CardSettingsCheckboxPickerState extends FormFieldState<List<String>> {
  @override
  CardSettingsCheckboxPicker get widget =>
      super.widget as CardSettingsCheckboxPicker;

  List<String> values = List<String>.empty();
  List<String> options = List<String>.empty();

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
      values: values,
      selectedValues: value,
      onChanged: (List<String>? selectedValues) {
        if (selectedValues != null) {
          didChange(selectedValues);
          if (widget.onChanged != null) widget.onChanged!(selectedValues);
        }
      },
    );
  }

  void _showCupertinoSelectPicker(List<String> options, String label) {
    Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenSelect(
          initialItems: value!,
          options: options,
          label: label,
        ),
        fullscreenDialog: true,
      ),
    ).then((selectedValues) {
      if (selectedValues != null) {
        didChange(selectedValues);
        if (widget.onChanged != null) widget.onChanged!(selectedValues);
      }
    });
  }

  Widget _build(BuildContext context) {
    // make local mutable copies of values and options
    options = widget.options;

    // if values are not provided, copy the options over and use those
    values = widget.values ?? widget.options;

    if (showCupertino(context, widget.showMaterialonIOS))
      return _cupertinoSettingsMultiselect();
    else
      return _materialSettingsMultiselect();
  }

  Widget _cupertinoSettingsMultiselect() {
    final ls = labelStyle(context, widget.enabled);
    return Container(
      child: widget.visible == false
          ? null
          : GestureDetector(
              onTap: () {
                if (widget.enabled) _showDialog(widget.label, options);
              },
              child: CSControl(
                nameWidget: Container(
                  width: widget.labelWidth ??
                      CardSettings.of(context)?.labelWidth ??
                      120.0,
                  child: widget.requiredIndicator != null
                      ? Text(
                          (widget.label) + ' *',
                          style: ls,
                        )
                      : Text(
                          widget.label,
                          style: ls,
                        ),
                ),
                contentWidget: Text(
                  value == null || value!.isEmpty
                      ? "none selected"
                      : value!.length == 1
                          ? "${value![0]}"
                          : "${value![0]} & ${value!.length - 1} more",
                  style: contentStyle(context, value, widget.enabled),
                ),
                style: CSWidgetStyle(icon: widget.icon),
              ),
            ),
    );
  }

  Widget _materialSettingsMultiselect() {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) _showDialog(widget.label, options);
      },
      child: CardSettingsField(
        label: widget.label,
        labelAlign: widget.labelAlign,
        labelWidth: widget.labelWidth,
        enabled: widget.enabled,
        visible: widget.visible,
        icon: widget.icon,
        requiredIndicator: widget.requiredIndicator,
        errorText: errorText,
        contentOnNewLine: true,
        fieldPadding: widget.fieldPadding,
        content: Wrap(
          alignment: WrapAlignment.start,
          spacing: 4.0,
          runSpacing: 0.0,
          children: value!
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

class _FullScreenSelect extends StatefulWidget {
  _FullScreenSelect({
    required this.label,
    this.initialItems,
    required this.options,
  });

  final List<String>? initialItems;
  final List<String> options;
  final String label;
  @override
  _FullScreenSelectState createState() => _FullScreenSelectState();
}

class _FullScreenSelectState extends State<_FullScreenSelect> {
  List<String> _selected = [];

  @override
  void initState() {
    _selected = widget.initialItems ?? [];
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
          middle: Text('Select ' + widget.label),
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
          itemCount: widget.options.length,
          itemBuilder: (BuildContext context, int index) {
            final i = widget.options[index];
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
