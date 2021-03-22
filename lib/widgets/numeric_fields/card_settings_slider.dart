// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/platform_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';

import '../../card_settings.dart';
import '../../interfaces/common_field_properties.dart';

/// This is a field that allows a boolean to be set via a switch widget.
class CardSettingsSlider extends FormField<double>
    implements ICommonFieldProperties {
  CardSettingsSlider({
    Key? key,
    bool autovalidate: false,
    AutovalidateMode autovalidateMode: AutovalidateMode.onUserInteraction,
    FormFieldSetter<double>? onSaved,
    FormFieldValidator<double>? validator,
    double initialValue = 0.0,
    this.enabled = true,
    this.visible = true,
    this.label = 'Label',
    this.requiredIndicator,
    this.labelAlign,
    this.labelWidth,
    this.icon,
    this.contentAlign,
    this.onChanged,
    this.onChangedStart,
    this.onChangedEnd,
    this.min,
    this.max,
    this.divisions,
    this.showMaterialonIOS,
    this.fieldPadding,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            // autovalidate: autovalidate,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<double> field) =>
                (field as _CardSettingsSliderState)._build(field.context));

  /// The text to identify the field to the user
  @override
  final String label;

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

  /// If false the field is grayed out and unresponsive
  @override
  final bool enabled;

  /// A widget to show next to the label if the field is required
  @override
  final Widget? requiredIndicator;

  @override
  final ValueChanged<double>? onChanged;

  final ValueChanged<double>? onChangedEnd;

  final ValueChanged<double>? onChangedStart;

  /// If false hides the widget on the card setting panel
  @override
  final bool visible;

  /// Force the widget to use Material style on an iOS device
  @override
  final bool? showMaterialonIOS;

  /// provides padding to wrap the entire field
  @override
  final EdgeInsetsGeometry? fieldPadding;

  /// how many divisions to have between min and max
  final int? divisions;

  /// The value at the minimum position
  final double? min;

  /// The value at the maximum position
  final double? max;

  @override
  _CardSettingsSliderState createState() => _CardSettingsSliderState();
}

class _CardSettingsSliderState extends FormFieldState<double> {
  @override
  CardSettingsSlider get widget => super.widget as CardSettingsSlider;

  Widget _build(BuildContext context) {
    if (showCupertino(context, widget.showMaterialonIOS))
      return _cupertinoSettingsSlider();
    else
      return _materialSettingsSlider();
  }

  Widget _cupertinoSettingsSlider() {
    final ls = labelStyle(context, widget.enabled);
    return Container(
      child: widget.visible == false
          ? null
          : CSControl(
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
              contentWidget: CupertinoSlider(
                value: value!,
                divisions: widget.divisions,
                min: widget.min ?? 0,
                max: widget.max ?? 1,
                onChangeEnd: widget.onChangedEnd,
                onChangeStart: widget.onChangedStart,
                onChanged: (widget.enabled)
                    ? (value) {
                        didChange(value);
                        if (widget.onChanged != null) widget.onChanged!(value);
                      }
                    : null, // to disable, we need to not provide an onChanged function
              ),
              style: CSWidgetStyle(icon: widget.icon),
            ),
    );
  }

  Widget _materialSettingsSlider() {
    return CardSettingsField(
      label: widget.label,
      labelAlign: widget.labelAlign,
      labelWidth: widget.labelWidth,
      visible: widget.visible,
      enabled: widget.enabled,
      icon: widget.icon,
      requiredIndicator: widget.requiredIndicator,
      errorText: errorText,
      fieldPadding: widget.fieldPadding,
      content: Row(children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(0.0),
            child: Container(
              height: 20.0,
              child: SliderTheme(
                data: SliderThemeData(
                  trackShape: _CustomTrackShape(),
                ),
                child: Slider(
                  activeColor: Theme.of(context).primaryColor,
                  value: value!,
                  divisions: widget.divisions,
                  min: widget.min ?? 0,
                  max: widget.max ?? 1,
                  onChangeEnd: widget.onChangedEnd,
                  onChangeStart: widget.onChangedStart,
                  onChanged: (widget.enabled)
                      ? (value) {
                          didChange(value);
                          if (widget.onChanged != null)
                            widget.onChanged!(value);
                        }
                      : null, // to disable, we need to not provide an onChanged function
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// https://github.com/flutter/flutter/issues/37057
class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 10;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
