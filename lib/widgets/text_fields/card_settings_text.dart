// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../../card_settings.dart';

/// This is a standard one line text entry field. It's based on the [TextFormField] widget.
class CardSettingsText extends FormField<String> {
  CardSettingsText({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    String initialValue,
    String unitLabel,
    String prefixText,
    bool contentOnNewLine: false,
    int maxLength: 20,
    int numberOfLines: 1,
    bool showCounter: false,
    bool visible: true,
    bool enabled: true,
    bool autofocus: false,
    bool obscureText: false,
    bool autocorrect: true,
    bool autovalidate: false,
    FormFieldValidator<String> validator,
    FormFieldSetter<String> onSaved,
    VoidCallback onEditingComplete,
    this.onChanged,
    this.controller,
    FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction = TextInputAction.done,
    TextStyle style,
    bool maxLengthEnforced: true,
    ValueChanged<String> onFieldSubmitted,
    List<TextInputFormatter> inputFormatters,
    this.inputMask,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
  })  : //assert(initialValue == null || controller == null),
        assert(keyboardType != null),
        assert(textInputAction != null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(autovalidate != null),
        assert(maxLengthEnforced != null),
        assert(scrollPadding != null),
        assert(maxLength == null || maxLength > 0),
        assert(controller == null || inputMask == null),
        super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<String> field) {
            final _CardSettingsTextState state = field;
            return CardSettingsField(
              label: label,
              labelAlign: labelAlign,
              visible: visible,
              unitLabel: unitLabel,
              contentOnNewLine: contentOnNewLine,
              content: TextField(
                controller: state._effectiveController,
                focusNode: focusNode,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                style: style,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  border: InputBorder.none,
                  errorText: field.errorText,
                  prefixText: prefixText,
                ),
                textAlign:
                    contentAlign ?? CardSettings.of(field.context).contentAlign,
                textCapitalization: textCapitalization,
                autofocus: autofocus,
                obscureText: obscureText,
                autocorrect: autocorrect,
                maxLengthEnforced: maxLengthEnforced,
                maxLines: numberOfLines,
                maxLength: (showCounter)
                    ? maxLength
                    : null, // if we want counter use default behavior
                onChanged: state._handleOnChanged,
                onEditingComplete: onEditingComplete,
                onSubmitted: onFieldSubmitted,
                inputFormatters: inputFormatters ??
                    [
                      // if we don't want the counter, use this maxLength instead
                      LengthLimitingTextInputFormatter(maxLength)
                    ],
                enabled: enabled,
                scrollPadding: scrollPadding,
                keyboardAppearance: keyboardAppearance,
              ),
            );
          },
        );

  final ValueChanged<String> onChanged;

  final TextEditingController controller;

  final String inputMask;

  @override
  _CardSettingsTextState createState() => new _CardSettingsTextState();
}

class _CardSettingsTextState extends FormFieldState<String> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  CardSettingsText get widget => super.widget;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      if (widget.inputMask == null) {
        _controller = new TextEditingController(text: widget.initialValue);
      } else {
        _controller = MaskedTextController(
            mask: widget.inputMask, text: widget.initialValue);
      }
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CardSettingsText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            new TextEditingController.fromValue(oldWidget.controller.value);
      if (widget.controller != null) {
        setValue(widget.controller.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  void _handleOnChanged(value) {
    if (this.value != value) {
      didChange(value);
      widget.onChanged(value);
    }
  }
}
