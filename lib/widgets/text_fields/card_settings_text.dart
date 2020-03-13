// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import '../../card_settings.dart';
import '../../models/common_card_field_attributes.dart';

/// This is a standard one line text entry  It's based on the [TextFormField] widget.
class CardSettingsText extends FormField<String>
    implements CommonCardFieldAttributes {
  CardSettingsText({
    Key key,
    String initialValue,
    bool autovalidate: false,
    bool enabled: true,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.maxLengthEnforced = true,
    this.inputMask,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.style,
    this.focusNode,
    this.label = 'Label',
    this.contentOnNewLine = false,
    this.maxLength = 20,
    this.numberOfLines = 1,
    this.showCounter = false,
    this.visible = true,
    this.autocorrect = true,
    this.obscureText = false,
    this.autofocus = false,
    this.contentAlign,
    this.hintText,
    this.icon,
    this.labelAlign,
    this.labelWidth,
    this.prefixText,
    this.requiredIndicator,
    this.unitLabel,
    this.showMaterialonIOS = false,
    this.showClearButtonIOS = OverlayVisibilityMode.never,
  })  : //assert(initialValue == null || controller == null),
        assert(keyboardType != null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(autovalidate != null),
        assert(textCapitalization != null),
        assert(maxLengthEnforced != null),
        assert(maxLength == null || maxLength > 0),
        assert(controller == null || inputMask == null),
        super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<String> field) =>
              (field as _CardSettingsTextState)._build(field.context),
        );

  final ValueChanged<String> onChanged;

  final TextEditingController controller;

  final String inputMask;

  final FocusNode focusNode;

  final TextInputType keyboardType;

  final TextCapitalization textCapitalization;

  final TextStyle style;

  final bool maxLengthEnforced;

  final ValueChanged<String> onFieldSubmitted;

  final List<TextInputFormatter> inputFormatters;

  @override
  final String label;

  @override
  final TextAlign labelAlign;

  @override
  final double labelWidth;

  @override
  final TextAlign contentAlign;

  final String unitLabel;

  @override
  final String prefixText;

  @override
  final String hintText;

  @override
  final Icon icon;

  final Widget requiredIndicator;

  final bool contentOnNewLine;

  final int maxLength;

  final int numberOfLines;

  final bool showCounter;

  final bool visible;

  final bool autofocus;

  final bool obscureText;

  final bool autocorrect;

  final bool showMaterialonIOS;

  ///Since the CupertinoTextField does not support onSaved, please use [onChanged] or [onFieldSubmitted] instead
  @override
  final FormFieldSetter<String> onSaved;

  ///In material mode this shows the validation text under the field
  ///In cupertino mode, it shows a [red] [Border] around the [CupertinoTextField]
  @override
  final FormFieldValidator<String> validator;

  final OverlayVisibilityMode showClearButtonIOS;

  @override
  _CardSettingsTextState createState() => _CardSettingsTextState();
}

class _CardSettingsTextState extends FormFieldState<String> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  CardSettingsText get widget => super.widget as CardSettingsText;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      if (widget.inputMask == null) {
        _controller = TextEditingController(text: widget.initialValue);
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
            TextEditingController.fromValue(oldWidget.controller.value);
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

  void _handleOnChanged(String _value) {
    if (this.value != _value) {
      didChange(_value);

      if (widget.onChanged != null) {
        widget.onChanged(_value);
      }
    }
  }

  Widget _build(BuildContext context) {
    if (Platform.isIOS && !widget.showMaterialonIOS) {
      return _buildCupertinoTextbox(context);
    } else {
      return _buildMaterialTextbox(context);
    }
  }

  Container _buildCupertinoTextbox(BuildContext context) {
    bool hasError = false;
    if (widget.validator != null) {
      String errorMessage = widget.validator(value);
      hasError = (errorMessage != null);
    }

    final _child = Container(
      child: CupertinoTextField(
        prefix: widget?.prefixText == null ? null : Text(widget.prefixText),
        suffix: widget?.unitLabel == null ? null : Text(widget.unitLabel),
        controller: _effectiveController,

        focusNode: widget?.focusNode,
        keyboardType: widget?.keyboardType,
        textCapitalization: widget?.textCapitalization,
        style: widget?.style ?? Theme.of(context).textTheme.subhead,
        decoration: hasError
            ? BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              )
            : BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: CupertinoColors.lightBackgroundGray,
                    style: BorderStyle.solid,
                    width: 0.0,
                  ),
                  bottom: BorderSide(
                    color: CupertinoColors.lightBackgroundGray,
                    style: BorderStyle.solid,
                    width: 0.0,
                  ),
                  left: BorderSide(
                    color: CupertinoColors.lightBackgroundGray,
                    style: BorderStyle.solid,
                    width: 0.0,
                  ),
                  right: BorderSide(
                    color: CupertinoColors.lightBackgroundGray,
                    style: BorderStyle.solid,
                    width: 0.0,
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
        clearButtonMode: widget?.showClearButtonIOS,
        placeholder: widget?.hintText,
        textAlign: widget?.contentAlign ?? TextAlign.end,
        autofocus: widget?.autofocus ?? false,
        obscureText: widget?.obscureText ?? false,
        autocorrect: widget?.autocorrect ?? true,
        maxLengthEnforced: widget?.maxLengthEnforced ?? false,
        maxLines: widget?.numberOfLines,
        maxLength: (widget?.showCounter ?? false)
            ? widget?.maxLength
            : null, // if we want counter use default behavior
        onChanged: _handleOnChanged,
        onSubmitted: widget?.onFieldSubmitted,
        inputFormatters: widget?.inputFormatters ??
            [
              // if we don't want the counter, use this maxLength instead
              LengthLimitingTextInputFormatter(widget?.maxLength)
            ],
        enabled: widget?.enabled,
      ),
    );
    return Container(
      child: widget?.visible == false
          ? null
          : widget?.contentOnNewLine == true
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CSControl(
                      nameWidget: widget?.requiredIndicator != null
                          ? Text((widget?.label ?? "") + ' *')
                          : Text(widget?.label),
                      contentWidget: Container(),
                      style: CSWidgetStyle(icon: widget?.icon),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: _child,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? null
                          : CupertinoColors.white,
                    ),
                    Container(
                      padding: widget?.showCounter ?? false
                          ? EdgeInsets.all(5.0)
                          : null,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? null
                          : CupertinoColors.white,
                      child: widget?.showCounter ?? false
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "${_controller?.text?.length ?? 0}/${widget?.maxLength}",
                                  style: TextStyle(
                                    color: CupertinoColors.inactiveGray,
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CSControl(
                      nameWidget: widget?.requiredIndicator != null
                          ? Text((widget?.label ?? "") + ' *')
                          : Text(widget?.label),
                      contentWidget: Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: _child,
                        ),
                      ),
                      style: CSWidgetStyle(icon: widget?.icon),
                    ),
                    Container(
                      padding: widget?.showCounter ?? false
                          ? EdgeInsets.all(5.0)
                          : null,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? null
                          : CupertinoColors.white,
                      child: widget?.showCounter ?? false
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "${_controller?.text?.length ?? 0}/${widget?.maxLength}",
                                  style: TextStyle(
                                    color: CupertinoColors.inactiveGray,
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                  ],
                ),
    );
  }

  CardSettingsField _buildMaterialTextbox(BuildContext context) {
    return CardSettingsField(
      label: widget.label,
      labelAlign: widget?.labelAlign,
      labelWidth: widget.labelWidth,
      visible: widget?.visible,
      unitLabel: widget?.unitLabel,
      icon: widget?.icon,
      requiredIndicator: widget?.requiredIndicator,
      contentOnNewLine: widget?.contentOnNewLine ?? false,
      content: TextField(
        controller: _effectiveController,
        focusNode: widget?.focusNode,
        keyboardType: widget?.keyboardType,
        textCapitalization: widget?.textCapitalization,
        style: widget?.style ?? Theme.of(context).textTheme.subhead,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          border: InputBorder.none,
          errorText: errorText,
          prefixText: widget?.prefixText,
          hintText: widget?.hintText,
          isDense: true,
        ),
        textAlign:
            widget?.contentAlign ?? CardSettings.of(context).contentAlign,
        autofocus: widget?.autofocus ?? false,
        obscureText: widget?.obscureText ?? false,
        autocorrect: widget?.autocorrect ?? true,
        maxLengthEnforced: widget?.maxLengthEnforced ?? false,
        maxLines: widget?.numberOfLines,
        maxLength: (widget?.showCounter ?? false)
            ? widget?.maxLength
            : null, // if we want counter use default behavior
        onChanged: _handleOnChanged,
        onSubmitted: widget?.onFieldSubmitted,
        inputFormatters: widget?.inputFormatters ??
            [
              // if we don't want the counter, use this maxLength instead
              LengthLimitingTextInputFormatter(widget?.maxLength)
            ],
        enabled: widget?.enabled,
      ),
    );
  }
}
