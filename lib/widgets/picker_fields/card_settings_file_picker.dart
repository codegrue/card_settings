// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'dart:math';
import 'dart:typed_data';

import 'package:card_settings/card_settings.dart';
import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../../interfaces/common_field_properties.dart';

/// This is the file picker field
class CardSettingsFilePicker extends FormField<Uint8List>
    implements ICommonFieldProperties {
  CardSettingsFilePicker({
    Key? key,
    // bool autovalidate: false,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    FormFieldSetter<Uint8List>? onSaved,
    FormFieldValidator<Uint8List>? validator,
    Uint8List? initialValue,
    this.visible = true,
    this.label = 'File',
    this.enabled = true,
    String? unattachDialogTitle,
    this.unattachDialogCancel = 'Cancel',
    this.unattachDialogConfirm = 'Unattach',
    this.onChanged,
    this.contentAlign,
    this.maxThumbnailWidth = 180,
    this.maxThumbnailHeight = 180,
    this.icon,
    this.labelAlign,
    this.labelWidth,
    this.requiredIndicator,
    this.style,
    this.showMaterialonIOS,
    this.fieldPadding,
    this.fileType,
    this.allowedExtensions,
  })  : unattachDialogTitle = unattachDialogTitle ?? 'Unattach ' + label + "?",
        super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            // autovalidate: autovalidate,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<Uint8List> field) =>
                (field as _CardSettingsFilePickerState)._build(field.context));

  /// fires when the picker data is changed
  @override
  final ValueChanged<Uint8List?>? onChanged;

  /// The text to identify the field to the user
  @override
  final String label;

  /// The title of the dialog when a file is unattached
  final String unattachDialogTitle;

  /// The confirm label of the dialog when a file is unattached
  final String unattachDialogConfirm;

  /// The cancel label of the dialog when a file is unattached
  final String unattachDialogCancel;

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

  /// a restriction on the width growth of the thumbnail
  final double maxThumbnailWidth;

  /// a restriction on the height growth of the thumbnail
  final double maxThumbnailHeight;

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// the style of the label text
  final TextStyle? style;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// the type of the files allowed
  final FileType? fileType;

  /// a list of allowed file extensions
  final List<String>? allowedExtensions;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  @override
  _CardSettingsFilePickerState createState() => _CardSettingsFilePickerState();

  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }
}

class _CardSettingsFilePickerState extends FormFieldState<Uint8List> {
  @override
  CardSettingsFilePicker get widget => super.widget as CardSettingsFilePicker;

  Widget _build(BuildContext context) {
    String formattedValue = (value == null)
        ? ''
        : CardSettingsFilePicker.formatBytes(value!.length, 2);

    if (showCupertino(context, widget.showMaterialonIOS))
      return _buildCupertinoFilePicker(formattedValue);
    else
      return _buildMaterialFilePicker(formattedValue);
  }

  void onTap() {
    if (value == null) {
      showMaterialFilePicker(
        fileType: widget.fileType ?? FileType.any,
        allowedExtensions: widget.allowedExtensions,
        onChanged: (file) => setState(() {
          didChange(file.bytes);
          if (widget.onChanged != null) widget.onChanged!(file.bytes);
        }),
      );
    } else {
      _showUnattachDialog();
    }
  }

  void _showUnattachDialog() async {
    var theme = Theme.of(context);
    var showIOS = (theme.platform == TargetPlatform.iOS ||
        theme.platform == TargetPlatform.macOS);

    if (!showIOS) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              widget.unattachDialogTitle,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).textTheme.headline1?.color),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  widget.unattachDialogCancel,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(widget.unattachDialogConfirm),
                onPressed: () {
                  didChange(null);
                  if (widget.onChanged != null) widget.onChanged!(null);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      return showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(widget.unattachDialogTitle),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(widget.unattachDialogCancel),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text(widget.unattachDialogConfirm),
                onPressed: () {
                  didChange(null);
                  if (widget.onChanged != null) widget.onChanged!(null);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildCupertinoFilePicker(String formattedValue) {
    final ls = labelStyle(context, widget.enabled);
    return Container(
      child: widget.visible == false
          ? null
          : GestureDetector(
              onTap: () {
                if (widget.enabled) onTap();
              },
              child: CSControl(
                nameWidget: Container(
                  width: widget.labelWidth ??
                      CardSettings.of(context)!.labelWidth ??
                      120.0,
                  child: widget.requiredIndicator != null
                      ? Text(
                          (widget.label) + ' *',
                          style: ls,
                        )
                      : Text(widget.label, style: ls),
                ),
                contentWidget: _buildFieldContent(formattedValue),
                style: CSWidgetStyle(icon: widget.icon),
              ),
            ),
    );
  }

  Widget _buildMaterialFilePicker(String formattedValue) {
    return GestureDetector(
      onTap: () {
        if (widget.enabled) onTap();
      },
      child: CardSettingsField(
        label: widget.label,
        enabled: widget.enabled,
        labelAlign: widget.labelAlign,
        labelWidth: widget.labelWidth,
        visible: widget.visible,
        icon: widget.icon ?? Icon(Icons.attach_file),
        requiredIndicator: widget.requiredIndicator,
        errorText: errorText,
        fieldPadding: widget.fieldPadding,
        content: _buildFieldContent(formattedValue),
        pickerIcon: (widget.enabled)
            ? (value == null)
                ? Icons.attach_file
                : Icons.clear
            : null,
      ),
    );
  }

  Widget _buildFieldContent(String formattedValue) {
    var contentAlign =
        widget.contentAlign ?? CardSettings.of(context)?.contentAlign;

    var paddingAmt =
        showCupertino(context, widget.showMaterialonIOS) ? 10.0 : 0.0;

    if (widget.fileType == FileType.image && value != null) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.maxThumbnailWidth - paddingAmt,
            maxHeight: widget.maxThumbnailHeight,
            minHeight: 30,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: paddingAmt),
            alignment: (contentAlign == TextAlign.right)
                ? Alignment.topRight
                : Alignment.topLeft,
            child: Image.memory(value!),
          ));
    } else {
      return Text(
        formattedValue,
        style: contentStyle(context, value, widget.enabled),
        textAlign: contentAlign,
      );
    }
  }
}
