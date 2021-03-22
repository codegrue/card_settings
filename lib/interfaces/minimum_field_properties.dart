import '../widgets/card_settings_widget.dart';

/// abstract class to ensure that all widgets implement the base
/// set of properties expected buy the settings panel wrapper
abstract class IMinimumFieldSettings implements CardSettingsWidget {
  @override
  final bool? showMaterialonIOS = null;
  @override
  final bool? visible = null;
}
