// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:io';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';

// Constants
const double _kPickerHeaderPortraitHeight = 60.0;
const double _kPickerPortraitWidth = 330.0;
const double _kPickerPortraitHeight = 500.0;
const double _kPickerLandscapeWidth = 530.0;
const double _kPickerLandscapeHeight = 300.0;
const double _kDialogActionBarHeight = 52.0;

/// This is the color picker field
class CardSettingsColorPicker extends FormField<Color> {
  CardSettingsColorPicker({
    Key key,
    bool autovalidate: false,
    FormFieldSetter<Color> onSaved,
    FormFieldValidator<Color> validator,
    Color initialValue = Colors.green,
    this.onChanged,
    this.visible = true,
    this.contentAlign,
    this.icon,
    this.labelAlign,
    this.requiredIndicator,
    this.label = "Label",
    this.showMaterialIOS = false,
  }) : super(
            key: key,
            initialValue: initialValue ?? Colors.black,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<Color> field) =>
                _CardSettingsColorPickerState().widget);

  final ValueChanged<Color> onChanged;

  final TextAlign labelAlign;

  /// here for consistency, but does nothing.
  final TextAlign contentAlign;

  final Icon icon;

  final Widget requiredIndicator;

  final String label;

  final bool visible;

  final bool showMaterialIOS;

  @override
  _CardSettingsColorPickerState createState() =>
      _CardSettingsColorPickerState();
}

class _CardSettingsColorPickerState extends FormFieldState<Color> {
  @override
  CardSettingsColorPicker get widget => super.widget as CardSettingsColorPicker;

  void _showDialog(String title) {
    if (Platform.isIOS && !widget.showMaterialIOS) {
      Navigator.push<Color>(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenColorPicker(
                initialColor: value,
                label: title,
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
      Color _pickerColor = value;

      showDialog<Color>(
        context: context,
        builder: (BuildContext context) {
          Widget header = Container(
            color: Theme.of(context).primaryColor,
            height: _kPickerHeaderPortraitHeight,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            padding: EdgeInsets.all(20.0),
          );

          Widget picker = Container(
            child: ColorPicker(
              pickerColor: _pickerColor,
              onColorChanged: (color) => _pickerColor = color,
              colorPickerWidth: MediaQuery.of(context).size.width,
              enableLabel: true,
              pickerAreaHeightPercent: 0.7,
            ),
          );

          final Widget actions = ButtonTheme.bar(
            child: Container(
              height: _kDialogActionBarHeight,
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(_pickerColor),
                  ),
                ],
              ),
            ),
          );

          return SafeArea(
            child: Dialog(
              child: OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
                  assert(orientation != null);
                  assert(context != null);
                  return SizedBox(
                    width: (orientation == Orientation.portrait)
                        ? _kPickerPortraitWidth
                        : _kPickerLandscapeWidth,
                    height: (orientation == Orientation.portrait)
                        ? _kPickerPortraitHeight
                        : _kPickerLandscapeHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        header,
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              picker,
                              actions,
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
      return GestureDetector(
        onTap: () {
          _showDialog("Color for " + widget?.label);
        },
        child: CSControl(
          widget?.requiredIndicator != null
              ? (widget?.label ?? "") + ' *'
              : widget?.label,
          Container(
            height: 20.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: value,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          style: CSWidgetStyle(icon: widget?.icon),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        _showDialog("Color for " + widget?.label);
      },
      child: CardSettingsField(
        label: widget?.label,
        labelAlign: widget?.labelAlign,
        visible: widget?.visible,
        icon: widget?.icon,
        requiredIndicator: widget?.requiredIndicator,
        errorText: errorText,
        content: Container(
          height: 20.0,
          decoration: BoxDecoration(
            color: value,
          ),
        ),
      ),
    );
  }
}

class FullScreenColorPicker extends StatefulWidget {
  FullScreenColorPicker({this.initialColor, this.label});

  final Color initialColor;
  final String label;
  @override
  _FullScreenColorPickerState createState() => _FullScreenColorPickerState();
}

class _FullScreenColorPickerState extends State<FullScreenColorPicker> {
  Color _pickerColor = Colors.white;
  @override
  void initState() {
    _pickerColor = widget?.initialColor ?? Colors.white;
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
          middle: Text(widget?.label ?? ""),
          trailing: GestureDetector(
            child: Text(
              'Save',
              style: TextStyle(
                color: CupertinoColors.activeBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pop(_pickerColor);
            },
          ),
        ),
        body: ColorPicker(
          pickerColor: _pickerColor,
          onColorChanged: (color) => _pickerColor = color,
          colorPickerWidth: MediaQuery.of(context).size.width,
          enableLabel: true,
          // pickerAreaHeightPercent: 0.7,
        ),
      ),
    );
  }
}
