import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:file_picker_cross/file_picker_cross.dart';

import 'plumbing/results.dart';
import 'plumbing/model.dart';

typedef LabelledValueChanged<T, U> = void Function(T label, U value);

class ExampleForm extends StatefulWidget {
  const ExampleForm(
    this.orientation,
    this.showMaterialonIOS,
    this.scaffoldKey, {
    this.onValueChanged,
    Key key,
  }) : super(key: key);

  final Orientation orientation;
  final bool showMaterialonIOS;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final LabelledValueChanged<String, dynamic> onValueChanged;

  @override
  ExampleFormState createState() => ExampleFormState();
}

class ExampleFormState extends State<ExampleForm> {
  PonyModel _ponyModel;

  bool loaded = false;

  @override
  void initState() {
    super.initState();

    initModel();
  }

  void initModel() async {
    _ponyModel = PonyModel();

    await _ponyModel.loadMedia();

    setState(() => loaded = true);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  // keys for fields
  // this is desirable because the fields may change order, in this example
  // when the screen is rotated, and this will preserve what state is
  // attached to what field.
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _typeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _ageKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _genderKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionlKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hobbiesKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _coatKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _maneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hasSpotsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _spotKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _heightKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _weightKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _photoKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _videoKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _audioKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _customFileKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _datetimeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _styleKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _timeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _priceKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _sliderKey = GlobalKey<FormState>();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Form(
        key: _formKey,
        child: (widget.orientation == Orientation.portrait)
            ? _buildPortraitLayout()
            : _buildLandscapeLayout(),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      showResults(context, _ponyModel);
    } else {
      showErrors(context);
      setState(() => _autoValidate = true);
    }
  }

  void resetPressed() {
    setState(() => loaded = false);

    initModel();

    _formKey.currentState.reset();
  }

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
      showMaterialonIOS: widget.showMaterialonIOS,
      labelWidth: 150,
      contentAlign: TextAlign.right,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Bio',
          ),
          children: <Widget>[
            _buildCardSettingsText_Name(),
            _buildCardSettingsListPicker_Type(),
            _buildCardSettingsRadioPicker_Gender(),
            _buildCardSettingsNumberPicker_Age(),
            _buildCardSettingsParagraph_Description(5),
            _buildCardSettingsCheckboxPicker_Hobbies(),
            _buildCardSettingsDateTimePicker_Birthday(),
            _buildCardSettingsText_Disabled()
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Colors',
          ),
          children: <Widget>[
            _buildCardSettingsColorPicker_Coat(),
            _buildCardSettingsColorPicker_Mane(),
            _buildCardSettingsSwitch_Spots(),
            _buildCardSettingsColorPicker_Spot(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Size',
          ),
          children: <Widget>[
            _buildCardSettingsDouble_Height(),
            _buildCardSettingsInt_Weight(),
            _buildCardSettingsSelectionPicker_Style(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'First Show',
          ),
          instructions: _buildCardSettingsInstructions(),
          children: <Widget>[
            _buildCardSettingsDatePicker(),
            _buildCardSettingsPhotoPicker(),
            _buildCardSettingsVideoPicker(),
            _buildCardSettingsMusicPicker(),
            _buildCardSettingsFileCustomPicker(),
            _buildCardSettingsTimePicker(),
            _buildCardSettingsCurrency(),
            _buildCardSettingsPhone(),
            _buildCardSettingsDouble_Slider(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Security',
          ),
          children: <Widget>[
            _buildCardSettingsEmail(),
            _buildCardSettingsPassword(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Actions',
          ),
          children: <Widget>[
            _buildCardSettingsButton_Save(),
            _buildCardSettingsButton_Reset(),
          ],
        ),
      ],
    );
  }

  CardSettings _buildLandscapeLayout() {
    return CardSettings.sectioned(
      showMaterialonIOS: widget.showMaterialonIOS,
      labelPadding: 12.0,
      children: <CardSettingsSection>[
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Bio',
          ),
          children: <Widget>[
            _buildCardSettingsText_Name(),
            _buildCardSettingsListPicker_Type(),
            CardFieldLayout(
              <Widget>[
                _buildCardSettingsRadioPicker_Gender(),
                _buildCardSettingsNumberPicker_Age(labelAlign: TextAlign.right),
              ],
              flexValues: [2, 1],
            ),
            _buildCardSettingsParagraph_Description(3),
            _buildCardSettingsCheckboxPicker_Hobbies(),
            _buildCardSettingsDateTimePicker_Birthday(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Security',
          ),
          children: <Widget>[
            CardFieldLayout(<Widget>[
              _buildCardSettingsEmail(),
              _buildCardSettingsPassword(),
            ]),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Colors',
          ),
          children: <Widget>[
            CardFieldLayout(<Widget>[
              _buildCardSettingsColorPicker_Coat(),
              _buildCardSettingsColorPicker_Mane(),
            ]),
            CardFieldLayout(<Widget>[
              _buildCardSettingsSwitch_Spots(),
              _buildCardSettingsColorPicker_Spot(),
            ]),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Size',
          ),
          children: <Widget>[
            CardFieldLayout(<Widget>[
              _buildCardSettingsDouble_Height(),
              _buildCardSettingsInt_Weight(),
              _buildCardSettingsSelectionPicker_Style(),
            ]),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'First Show',
          ),
          children: <Widget>[
            _buildCardSettingsInstructions(),
            CardFieldLayout(<Widget>[
              _buildCardSettingsDatePicker(),
              _buildCardSettingsPhotoPicker(),
            ]),
            CardFieldLayout(<Widget>[
              _buildCardSettingsVideoPicker(),
              _buildCardSettingsMusicPicker(),
            ]),
            CardFieldLayout(<Widget>[
              _buildCardSettingsFileCustomPicker(),
              _buildCardSettingsTimePicker(),
            ]),
            CardFieldLayout(<Widget>[
              _buildCardSettingsCurrency(),
              _buildCardSettingsPhone(),
            ]),
            _buildCardSettingsDouble_Slider(),
          ],
        ),
        CardSettingsSection(
          header: CardSettingsHeader(
            label: 'Actions',
          ),
          children: <Widget>[
            CardFieldLayout(<Widget>[
              _buildCardSettingsButton_Save(),
              _buildCardSettingsButton_Reset(),
            ]),
          ],
        ),
      ],
    );
  }

  CardSettingsButton _buildCardSettingsButton_Reset() {
    return CardSettingsButton(
      label: 'RESET',
      isDestructive: true,
      onPressed: resetPressed,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  CardSettingsButton _buildCardSettingsButton_Save() {
    return CardSettingsButton(
      label: 'SAVE',
      backgroundColor: Colors.green,
      onPressed: savePressed,
    );
  }

  CardSettingsPassword _buildCardSettingsPassword() {
    return CardSettingsPassword(
      key: _passwordKey,
      icon: Icon(Icons.lock),
      initialValue: _ponyModel.password,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null) return 'Password is required.';
        if (value.length <= 6) return 'Must be more than 6 characters.';
        return null;
      },
      onSaved: (value) => _ponyModel.password = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.password = value;
        });
        widget.onValueChanged('Password', value);
      },
    );
  }

  CardSettingsEmail _buildCardSettingsEmail() {
    return CardSettingsEmail(
      key: _emailKey,
      icon: Icon(Icons.person),
      initialValue: _ponyModel.email,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Email is required.';
        if (!value.contains('@'))
          return "Email not formatted correctly."; // use regex in real application
        return null;
      },
      onSaved: (value) => _ponyModel.email = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.email = value;
        });
        widget.onValueChanged('Email', value);
      },
    );
  }

  CardSettingsPhone _buildCardSettingsPhone() {
    return CardSettingsPhone(
      key: _phoneKey,
      label: 'Box Office',
      initialValue: _ponyModel.boxOfficePhone,
      autovalidate: _autoValidate,
      validator: (value) {
        return null;
      },
      onSaved: (value) => _ponyModel.boxOfficePhone = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.boxOfficePhone = value;
        });
        widget.onValueChanged('Box Office', value);
      },
    );
  }

  CardSettingsCurrency _buildCardSettingsCurrency() {
    return CardSettingsCurrency(
      key: _priceKey,
      label: 'Ticket Price',
      initialValue: _ponyModel.ticketPrice,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null && value > 100) return 'No scalpers allowed!';
        return null;
      },
      onSaved: (value) => _ponyModel.ticketPrice = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.ticketPrice = value;
        });
        widget.onValueChanged('Ticket Price', value);
      },
    );
  }

  CardSettingsTimePicker _buildCardSettingsTimePicker() {
    return CardSettingsTimePicker(
      key: _timeKey,
      icon: Icon(Icons.access_time),
      label: 'Time',
      initialValue: TimeOfDay(
          hour: _ponyModel.showDateTime.hour,
          minute: _ponyModel.showDateTime.minute),
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustTime(value, _ponyModel.showDateTime),
      onChanged: (value) {
        setState(() {
          _ponyModel.showDateTime =
              updateJustTime(value, _ponyModel.showDateTime);
        });
        widget.onValueChanged('Show Time', value);
      },
    );
  }

  CardSettingsDatePicker _buildCardSettingsDatePicker() {
    return CardSettingsDatePicker(
      key: _dateKey,
      icon: Icon(Icons.calendar_today),
      label: 'Date',
      dateFormat: DateFormat.yMMMMd(),
      initialValue: _ponyModel.showDateTime,
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustDate(value, _ponyModel.showDateTime),
      onChanged: (value) {
        setState(() {
          _ponyModel.showDateTime = value;
        });
        widget.onValueChanged(
            'Show Date', updateJustDate(value, _ponyModel.showDateTime));
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsPhotoPicker() {
    return CardSettingsFilePicker(
      key: _photoKey,
      icon: Icon(Icons.photo),
      label: 'Photo',
      fileType: FileTypeCross.image,
      initialValue: _ponyModel.photo,
      onSaved: (value) => _ponyModel.photo = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.photo = value;
        });
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsVideoPicker() {
    return CardSettingsFilePicker(
      key: _videoKey,
      icon: Icon(Icons.video_library),
      label: 'Video',
      fileType: FileTypeCross.video,
      initialValue: _ponyModel.video,
      onSaved: (value) => _ponyModel.video = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.video = value;
        });
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsMusicPicker() {
    return CardSettingsFilePicker(
      key: _audioKey,
      icon: Icon(Icons.music_note),
      label: 'Audio',
      fileType: FileTypeCross.audio,
      initialValue: _ponyModel.audio,
      onSaved: (value) => _ponyModel.audio = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.audio = value;
        });
      },
    );
  }

  CardSettingsFilePicker _buildCardSettingsFileCustomPicker() {
    return CardSettingsFilePicker(
      key: _customFileKey,
      icon: Icon(Icons.insert_drive_file),
      label: 'Custom file',
      fileType: FileTypeCross.custom,
      fileExtension: '.jpg,.mp4',
      initialValue: _ponyModel.customFile,
      onSaved: (value) => _ponyModel.customFile = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.customFile = value;
        });
      },
    );
  }

  CardSettingsDateTimePicker _buildCardSettingsDateTimePicker_Birthday() {
    return CardSettingsDateTimePicker(
      key: _datetimeKey,
      icon: Icon(Icons.card_giftcard, color: Colors.yellow[700]),
      label: 'Birth day',
      initialValue: _ponyModel.showDateTime,
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustDate(value, _ponyModel.showDateTime),
      onChanged: (value) {
        setState(() {
          _ponyModel.showDateTime = value;
        });
        widget.onValueChanged(
            'Show Date', updateJustDate(value, _ponyModel.showDateTime));
      },
    );
  }

  CardSettingsInstructions _buildCardSettingsInstructions() {
    return CardSettingsInstructions(
      text: 'This is when this little horse got her big break',
    );
  }

  CardSettingsInt _buildCardSettingsInt_Weight() {
    return CardSettingsInt(
      key: _weightKey,
      label: 'Weight',
      unitLabel: '(lbs)',
      initialValue: _ponyModel.weight,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null) {
          if (value > 70) return 'You won\'t fly at the weight.';
          if (value < 10) return 'Cmon, you are not a feather.';
        }
        return null;
      },
      onSaved: (value) => _ponyModel.weight = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.weight = value;
        });
        widget.onValueChanged('Weight', value);
      },
    );
  }

  CardSettingsDouble _buildCardSettingsDouble_Height() {
    return CardSettingsDouble(
      key: _heightKey,
      label: 'Height',
      unitLabel: '(ft)',
      decimalDigits: 2,
      locale: Locale('fr'), // force french mode to simulate localization
      initialValue: _ponyModel.height,
      onSaved: (value) => _ponyModel.height = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.height = value;
        });
        widget.onValueChanged('Height', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Spot() {
    return CardSettingsColorPicker(
      key: _spotKey,
      label: 'Spot',
      pickerType: CardSettingsColorPickerType.block,
      initialValue: intelligentCast<Color>(_ponyModel.spotColor),
      visible: _ponyModel.hasSpots,
      onSaved: (value) => _ponyModel.spotColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.type = colorToString(value);
        });
        widget.onValueChanged('Spot', value);
      },
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Spots() {
    return CardSettingsSwitch(
      key: _hasSpotsKey,
      label: 'Has spots?',
      initialValue: _ponyModel.hasSpots,
      onSaved: (value) => _ponyModel.hasSpots = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.hasSpots = value;
        });
        widget.onValueChanged('Has Spots?', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Mane() {
    return CardSettingsColorPicker(
      key: _maneKey,
      label: 'Mane',
      initialValue: intelligentCast<Color>(_ponyModel.maneColor),
      autovalidate: _autoValidate,
      pickerType: CardSettingsColorPickerType.material,
      validator: (value) {
        if (value.computeLuminance() > .7) return 'This color is too light.';
        return null;
      },
      onSaved: (value) => _ponyModel.maneColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.maneColor = colorToString(value);
        });
        widget.onValueChanged('Mane', value);
      },
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Coat() {
    return CardSettingsColorPicker(
      key: _coatKey,
      label: 'Coat',
      initialValue: intelligentCast<Color>(_ponyModel.coatColor),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.computeLuminance() < .3)
          return 'This color is not cheery enough.';
        return null;
      },
      onSaved: (value) => _ponyModel.coatColor = colorToString(value),
      onChanged: (value) {
        setState(() {
          _ponyModel.coatColor = colorToString(value);
        });
        widget.onValueChanged('Coat', value);
      },
    );
  }

  CardSettingsCheckboxPicker _buildCardSettingsCheckboxPicker_Hobbies() {
    return CardSettingsCheckboxPicker(
      key: _hobbiesKey,
      label: 'Hobbies',
      initialValues: _ponyModel.hobbies,
      options: allHobbies,
      autovalidate: _autoValidate,
      validator: (List<String> value) {
        if (value == null || value.isEmpty)
          return 'You must pick at least one hobby.';

        return null;
      },
      onSaved: (value) => _ponyModel.hobbies = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.hobbies = value;
        });
        widget.onValueChanged('Hobbies', value);
      },
    );
  }

  CardSettingsParagraph _buildCardSettingsParagraph_Description(int lines) {
    return CardSettingsParagraph(
      key: _descriptionlKey,
      label: 'Description',
      initialValue: _ponyModel.description,
      numberOfLines: lines,
      focusNode: _descriptionNode,
      onSaved: (value) => _ponyModel.description = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.description = value;
        });
        widget.onValueChanged('Description', value);
      },
    );
  }

  CardSettingsNumberPicker _buildCardSettingsNumberPicker_Age(
      {TextAlign labelAlign}) {
    return CardSettingsNumberPicker(
      key: _ageKey,
      label: 'Age',
      labelAlign: labelAlign,
      initialValue: _ponyModel.age,
      min: 1,
      max: 17,
      stepInterval: 2,
      validator: (value) {
        if (value == null) return 'Age is required.';
        if (value > 20) return 'No grown-ups allwed!';
        if (value < 3) return 'No Toddlers allowed!';
        return null;
      },
      onSaved: (value) => _ponyModel.age = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.age = value;
        });
        widget.onValueChanged('Age', value);
      },
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Type() {
    return CardSettingsListPicker(
      key: _typeKey,
      label: 'Type',
      initialValue: _ponyModel.type,
      hintText: 'Select One',
      autovalidate: _autoValidate,
      options: <String>['Earth', 'Unicorn', 'Pegasi', 'Alicorn'],
      values: <String>['E', 'U', 'P', 'A'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.type = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.type = value;
        });
        widget.onValueChanged('Type', value);
      },
    );
  }

  CardSettingsText _buildCardSettingsText_Name() {
    return CardSettingsText(
      key: _nameKey,
      label: 'Name',
      hintText: 'something cute...',
      initialValue: _ponyModel.name,
      requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      focusNode: _nameNode,
      inputAction: TextInputAction.next,
      inputActionNode: _descriptionNode,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name is required.';
        return null;
      },
      onSaved: (value) => _ponyModel.name = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.name = value;
        });
        widget.onValueChanged('Name', value);
      },
    );
  }

  CardSettingsText _buildCardSettingsText_Disabled() {
    return CardSettingsText(
      label: 'Disabled',
      hintText: 'something disabled...',
      enabled: false,
    );
  }

  CardSettingsRadioPicker _buildCardSettingsRadioPicker_Gender() {
    return CardSettingsRadioPicker(
      key: _genderKey,
      label: 'Gender',
      initialValue: _ponyModel.gender,
      hintText: 'Select One',
      autovalidate: _autoValidate,
      options: <String>['Male', 'Female'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a gender.';
        return null;
      },
      onSaved: (value) => _ponyModel.gender = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.gender = value;
        });
        widget.onValueChanged('Gender', value);
      },
    );
  }

  CardSettingsSelectionPicker _buildCardSettingsSelectionPicker_Style() {
    return CardSettingsSelectionPicker(
      key: _styleKey,
      label: 'Style',
      initialValue: _ponyModel.style,
      hintText: 'Select One',
      autovalidate: _autoValidate,
      options: <String>['Majestic', 'Scrawny', 'Sleek'],
      icons: <Icon>[
        Icon(Icons.sort),
        Icon(Icons.clear_all),
        Icon(Icons.swap_calls),
      ],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a style.';
        return null;
      },
      onSaved: (value) => _ponyModel.style = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.style = value;
        });
        widget.onValueChanged('Style', value);
      },
    );
  }

  CardSettingsSlider _buildCardSettingsDouble_Slider() {
    return CardSettingsSlider(
      key: _sliderKey,
      label: 'Rating',
      initialValue: _ponyModel.rating,
      autovalidate: _autoValidate,
      validator: (double value) {
        if (value == null) return 'You must pick a rating.';
        return null;
      },
      onSaved: (value) => _ponyModel.rating = value,
      onChanged: (value) {
        setState(() {
          _ponyModel.rating = value;
        });
        widget.onValueChanged('Rating', value);
      },
    );
  }
}
