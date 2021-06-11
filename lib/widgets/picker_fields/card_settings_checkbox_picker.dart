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
class CardSettingsCheckboxPicker<T> extends FormField<List<T>>
    implements ICommonFieldProperties {
  CardSettingsCheckboxPicker({
    Key? key,
    List<T>? initialItems,
    FormFieldSetter<List<T>>? onSaved,
    FormFieldValidator<List<T>>? validator,
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
    required this.items,
    this.showMaterialonIOS,
    this.fieldPadding,
  }) : super(
          key: key,
          initialValue: initialItems,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<List<T>> field) =>
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

  /// a list of items to display in the picker
  final List<T> items;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Fires when the picked values are changed
  @override
  final ValueChanged<List<T>>? onChanged;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  @override
  _CardSettingsCheckboxPickerState<T> createState() =>
      _CardSettingsCheckboxPickerState<T>();
}

class _CardSettingsCheckboxPickerState<T> extends FormFieldState<List<T>> {
  @override
  CardSettingsCheckboxPicker<T> get widget =>
      super.widget as CardSettingsCheckboxPicker<T>;

  List<T> items = List<T>.empty();

  void _showDialog(String label) {
    if (showCupertino(context, widget.showMaterialonIOS))
      _showCupertinoSelectPicker(label);
    else
      _showMaterialCheckboxPicker(label);
  }

  void _showMaterialCheckboxPicker(String label) {
    showMaterialCheckboxPicker(
      context: context,
      title: label,
      items: items,
      selectedItems: value,
      onChanged: (List<T>? selectedItems) {
        if (selectedItems != null) {
          didChange(selectedItems);
          if (widget.onChanged != null) widget.onChanged!(selectedItems);
        }
      },
    );
  }

  void _showCupertinoSelectPicker(String label) {
    Navigator.push<List<T>>(
      context,
      MaterialPageRoute(
        builder: (context) => _CupertinoSelect(
          initialItems: value!,
          items: items,
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
    items = widget.items;

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
                if (widget.enabled) _showDialog(widget.label);
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
        if (widget.enabled) _showDialog(widget.label);
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
                    label: Text(s.toString(),
                        style: contentStyle(context, value, widget.enabled))),
              )
              .toList(),
        ),
        pickerIcon: (widget.enabled) ? Icons.arrow_drop_down : null,
      ),
    );
  }
}

class _CupertinoSelect<T> extends StatefulWidget {
  _CupertinoSelect({
    required this.label,
    this.initialItems,
    required this.items,
  });

  final List<T>? initialItems;
  final List<T> items;
  final String label;

  @override
  _CupertinoSelectState<T> createState() => _CupertinoSelectState<T>();
}

class _CupertinoSelectState<T> extends State<_CupertinoSelect<T>> {
  List<T> _selected = [];

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
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            T i = widget.items[index];
            final bool select = _selected.contains(i);
            return ListTile(
              leading: select
                  ? const Icon(CupertinoIcons.check_mark)
                  : Icon(Icons.info, color: Colors.transparent),
              title: Text(i.toString()),
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
