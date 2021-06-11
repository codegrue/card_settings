// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

/// Package for building card based settings forms
library card_settings;

export 'helpers/converter_functions.dart';
export 'widgets/action_fields/card_settings_button.dart';
export 'widgets/card_field_layout.dart';
export 'widgets/card_settings_widget.dart';
export 'widgets/card_settings_field.dart';
export 'widgets/card_settings_panel.dart';
export 'widgets/information_fields/card_settings_header.dart';
export 'widgets/information_fields/card_settings_instructions.dart';
export 'widgets/numeric_fields/card_settings_currency.dart';
export 'widgets/numeric_fields/card_settings_double.dart';
export 'widgets/numeric_fields/card_settings_int.dart';
export 'widgets/numeric_fields/card_settings_switch.dart';
export 'widgets/picker_fields/card_settings_color_picker.dart';
export 'widgets/picker_fields/card_settings_date_picker.dart';
export 'widgets/picker_fields/card_settings_file_picker.dart';
export 'widgets/picker_fields/card_settings_list_picker.dart';
export 'widgets/picker_fields/card_settings_radio_picker.dart';
export 'widgets/picker_fields/card_settings_selection_picker.dart';
export 'widgets/picker_fields/card_settings_checkbox_picker.dart';
export 'widgets/picker_fields/card_settings_number_picker.dart';
export 'widgets/picker_fields/card_settings_time_picker.dart';
export 'widgets/picker_fields/card_settings_datetime_picker.dart';
export 'widgets/text_fields/card_settings_email.dart';
export 'widgets/text_fields/card_settings_paragraph.dart';
export 'widgets/text_fields/card_settings_password.dart';
export 'widgets/text_fields/card_settings_phone.dart';
export 'widgets/text_fields/card_settings_text.dart';
export 'widgets/numeric_fields/card_settings_slider.dart';
export 'widgets/card_settings_widget.dart';

//export 'package:flutter_material_pickers/flutter_material_pickers.dart'show PickerModel;
export 'models/picker_model.dart';

/// this is the default height for the cupertino scroll wheel
const double kCupertinoPickerSheetHeight = 216.0;

/// this is the default height for a single item in cupertino picker
const double kCupertinoPickerItemHeight = 32.0;
