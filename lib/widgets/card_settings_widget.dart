import 'package:flutter/material.dart';

/// abstract class to ensure that all widgets implement the base
/// set of properties expected by the settings panel wrapper
abstract class CardSettingsWidget extends Widget {
  final bool? showMaterialonIOS = null;
  final bool? visible = null;
}
