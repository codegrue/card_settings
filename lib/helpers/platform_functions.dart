import 'dart:io';
import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool showCupertino(BuildContext context, bool showMaterialonIOS) {
  // don't show on web
  if (kIsWeb) return false;

  // if not specified, set showMaterialOnIOS to parent CardSettings value
  if (showMaterialonIOS == null) {
    if (context != null)
      showMaterialonIOS = CardSettings.of(context).showMaterialonIOS;
    else
      showMaterialonIOS = false;
  }

  // is we are on iOS and don't want material, show it
  if (Platform.isIOS && !showMaterialonIOS) return true;

  // material by default
  return false;
}
