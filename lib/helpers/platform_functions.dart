import 'dart:io';
import 'package:flutter/foundation.dart';

bool showCupertino(bool showMaterialonIOS) {
  // don't show on web
  if (kIsWeb) return false;

  // is we are on iOS and don't want material, show it
  if (Platform.isIOS && !showMaterialonIOS) return true;

  // material by default
  return false;
}
