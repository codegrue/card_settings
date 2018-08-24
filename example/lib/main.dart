import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'results.dart';
import 'model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Settings Example',
      home: PonyExample(),
      theme: ThemeData(
        accentColor: Colors.indigo[400], // background color of card headers
        cardColor: Colors.white, // background color of fields
        backgroundColor: Colors.indigo[100], // color outside the card
        primaryColor: Colors.teal, // color of page header
        buttonColor: Colors.lightBlueAccent[100], // background color of buttons
        textTheme: TextTheme(
          button:
              TextStyle(color: Colors.deepPurple[900]), // style of button text
          subhead: TextStyle(color: Colors.grey[800]), // style of input text
        ),
      ),
    );
  }
}

class PonyExample extends StatefulWidget {
  @override
  _PonyExampleState createState() => _PonyExampleState();
}

class _PonyExampleState extends State<PonyExample> {
  final _ponyModel = PonyModel();

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // control state only works if the field order never changes.
  // to support orientation changes, we assign a unique key to each field
  // if you only have one orientation, the _formKey is sufficient
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _typeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _ageKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _descriptionlKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hobbiesKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _coatKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _maneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hasSpotsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _spotKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _heightKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _weightKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _timeKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _priceKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text("My Little Pony"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _savePressed,
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetPressed,
          )),
      body: Form(
        key: _formKey,
        child: Theme(
          data: Theme.of(context).copyWith(
            primaryTextTheme: TextTheme(
              title:
                  TextStyle(color: Colors.lightBlue[50]), // style for headers
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle:
                  TextStyle(color: Colors.indigo[400]), // style for labels
            ),
          ),
          child: NativeDeviceOrientationReader(
            builder: (context) {
              var orientation =
                  NativeDeviceOrientationReader.orientation(context);
              return (orientation == NativeDeviceOrientation.portraitUp)
                  ? _buildPortraitLayout()
                  : _buildLandscapeLayout();
            },
          ),
        ),
      ),
    );
  }

  /* CARDSETTINGS FOR EACH LAYOUT */

  CardSettings _buildPortraitLayout() {
    return CardSettings(
      children: <Widget>[
        CardSettingsHeader(label: 'Bio'),
        _buildCardSettingsText_Name(_nameKey),
        _buildCardSettingsListPicker_Type(_typeKey),
        _buildCardSettingsNumberPicker(_ageKey),
        _buildCardSettingsParagraph(_descriptionlKey, 5),
        _buildCardSettingsMultiselect(_hobbiesKey),
        CardSettingsHeader(label: 'Colors'),
        _buildCardSettingsColorPicker_Coat(_coatKey),
        _buildCardSettingsColorPicker_Mane(_maneKey),
        _buildCardSettingsSwitch_Spots(_hasSpotsKey),
        _buildCardSettingsColorPicker_Spot(_spotKey),
        CardSettingsHeader(label: 'Size'),
        _buildCardSettingsDouble_Height(_heightKey),
        _buildCardSettingsInt_Weight(_weightKey),
        CardSettingsHeader(label: 'First Show'),
        _buildCardSettingsInstructions(),
        _buildCardSettingsDatePicker(_dateKey),
        _buildCardSettingsTimePicker(_timeKey),
        _buildCardSettingsCurrency(_priceKey),
        _buildCardSettingsPhone(_phoneKey),
        CardSettingsHeader(label: 'Security'),
        _buildCardSettingsEmail(_emailKey),
        _buildCardSettingsPassword(_passwordKey),
        CardSettingsHeader(label: 'Actions'),
        _buildCardSettingsButton_Save(),
        _buildCardSettingsButton_Reset(),
        Container(height: 4.0)
      ],
    );
  }

  CardSettings _buildLandscapeLayout() {
    return CardSettings(
      labelPadding: 12.0,
      children: <Widget>[
        CardSettingsHeader(label: 'Bio'),
        _buildCardSettingsText_Name(_nameKey),
        CardFieldLayout_FractionallySpaced(children: <Widget>[
          _buildCardSettingsListPicker_Type(_typeKey),
          _buildCardSettingsNumberPicker(_ageKey, labelAlign: TextAlign.right),
        ], widthFactors: <double>[
          0.7,
          0.3
        ]),
        _buildCardSettingsParagraph(_descriptionlKey, 3),
        _buildCardSettingsMultiselect(_hobbiesKey),
        // note, different order than portrait to show state mapping
        CardSettingsHeader(label: 'Security'),
        CardFieldLayout_EqualSpaced(children: <Widget>[
          _buildCardSettingsEmail(_emailKey),
          _buildCardSettingsPassword(_passwordKey),
        ]),
        CardSettingsHeader(label: 'Colors'),
        CardFieldLayout_EqualSpaced(children: <Widget>[
          _buildCardSettingsColorPicker_Coat(_coatKey),
          _buildCardSettingsColorPicker_Mane(_maneKey),
        ]),
        CardFieldLayout_EqualSpaced(children: <Widget>[
          _buildCardSettingsSwitch_Spots(_hasSpotsKey),
          _buildCardSettingsColorPicker_Spot(_spotKey),
        ]),
        CardSettingsHeader(label: 'Size'),
        CardFieldLayout_EqualSpaced(children: <Widget>[
          _buildCardSettingsDouble_Height(_heightKey),
          _buildCardSettingsInt_Weight(_weightKey),
        ]),
        CardSettingsHeader(label: 'First Show'),
        _buildCardSettingsInstructions(),
        CardFieldLayout_EqualSpaced(children: <Widget>[
          _buildCardSettingsDatePicker(_dateKey),
          _buildCardSettingsTimePicker(_timeKey),
        ]),
        CardFieldLayout_EqualSpaced(children: <Widget>[
          _buildCardSettingsCurrency(_priceKey),
          _buildCardSettingsPhone(_phoneKey),
        ]),
        CardSettingsHeader(label: 'Actions'),
        CardFieldLayout_EqualSpaced(children: <Widget>[
          _buildCardSettingsButton_Save(),
          _buildCardSettingsButton_Reset(),
          _buildCardSettingsButton_Close(),
        ]),
        Container(height: 4.0)
      ],
    );
  }

  /* BUILDERS FOR EACH FIELD */

  CardSettingsButton _buildCardSettingsButton_Close() {
    return CardSettingsButton(
      label: 'CLOSE',
      onPressed: _closePressed,
      backgroundColor: Colors.greenAccent,
    );
  }

  CardSettingsButton _buildCardSettingsButton_Reset() {
    return CardSettingsButton(
      label: 'RESET',
      onPressed: _resetPressed,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
    );
  }

  CardSettingsButton _buildCardSettingsButton_Save() {
    return CardSettingsButton(
      label: 'SAVE',
      onPressed: _savePressed,
    );
  }

  CardSettingsPassword _buildCardSettingsPassword(Key key) {
    return CardSettingsPassword(
      key: key,
      icon: Icon(Icons.lock),
      initialValue: _ponyModel.password,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null) return 'Password is required.';
        if (value.length <= 6) return 'Must be more than 6 characters.';
        return null;
      },
      onSaved: (value) => _ponyModel.password = value,
      onChanged: (value) => _showSnackBar('Password', value),
    );
  }

  CardSettingsEmail _buildCardSettingsEmail(Key key) {
    return CardSettingsEmail(
      key: key,
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
      onChanged: (value) => _showSnackBar('Email', value),
    );
  }

  CardSettingsPhone _buildCardSettingsPhone(Key key) {
    return CardSettingsPhone(
      key: key,
      label: 'Box Office',
      initialValue: _ponyModel.boxOfficePhone,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null && value.toString().length != 10)
          return 'Incomplete number';
        return null;
      },
      onSaved: (value) => _ponyModel.boxOfficePhone = value,
      onChanged: (value) => _showSnackBar('Box Office', value),
    );
  }

  CardSettingsCurrency _buildCardSettingsCurrency(Key key) {
    return CardSettingsCurrency(
      key: key,
      label: 'Ticket Price',
      initialValue: _ponyModel.ticketPrice,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != null && value > 100) return 'No scalpers allowed!';
        return null;
      },
      onSaved: (value) => _ponyModel.ticketPrice = value,
      onChanged: (value) => _showSnackBar('Ticket Price', value),
    );
  }

  CardSettingsTimePicker _buildCardSettingsTimePicker(Key key) {
    return CardSettingsTimePicker(
      key: key,
      icon: Icon(Icons.access_time),
      label: 'Time',
      initialValue: TimeOfDay(
          hour: _ponyModel.showDateTime.hour,
          minute: _ponyModel.showDateTime.minute),
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustTime(value, _ponyModel.showDateTime),
      onChanged: (value) => _showSnackBar('Show Time', value),
    );
  }

  CardSettingsDatePicker _buildCardSettingsDatePicker(Key key) {
    return CardSettingsDatePicker(
      key: key,
      icon: Icon(Icons.calendar_today),
      label: 'Date',
      initialValue: _ponyModel.showDateTime,
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustDate(value, _ponyModel.showDateTime),
      onChanged: (value) => _showSnackBar('Show Date', value),
    );
  }

  CardSettingsInstructions _buildCardSettingsInstructions() {
    return CardSettingsInstructions(
      text: 'This is when this little horse got her big break',
    );
  }

  CardSettingsInt _buildCardSettingsInt_Weight(Key key) {
    return CardSettingsInt(
      key: key,
      label: 'Weight',
      unitLabel: 'lbs',
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
      onChanged: (value) => _showSnackBar('Weight', value),
    );
  }

  CardSettingsDouble _buildCardSettingsDouble_Height(Key key) {
    return CardSettingsDouble(
      key: key,
      label: 'Height',
      unitLabel: 'feet',
      initialValue: _ponyModel.height,
      onSaved: (value) => _ponyModel.height = value,
      onChanged: (value) => _showSnackBar('Height', value),
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Spot(Key key) {
    return CardSettingsColorPicker(
      key: key,
      label: 'Spot',
      initialValue: intelligentCast<Color>(_ponyModel.spotColor),
      visible: _ponyModel.hasSpots,
      onSaved: (value) => _ponyModel.spotColor = colorToString(value),
      onChanged: (value) => _showSnackBar('Spot', value),
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Spots(Key key) {
    return CardSettingsSwitch(
      key: key,
      label: 'Has Spots?',
      initialValue: _ponyModel.hasSpots,
      onChanged: (value) {
        setState(() => _ponyModel.hasSpots = value);
        _showSnackBar('Has Spots?', value);
      },
      onSaved: (value) => _ponyModel.hasSpots = value,
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Mane(Key key) {
    return CardSettingsColorPicker(
      key: key,
      label: 'Mane',
      initialValue: intelligentCast<Color>(_ponyModel.maneColor),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.computeLuminance() > .7) return 'This color is too light.';
        return null;
      },
      onSaved: (value) => _ponyModel.maneColor = colorToString(value),
      onChanged: (value) => _showSnackBar('Mane', value),
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Coat(Key key) {
    return CardSettingsColorPicker(
      key: key,
      label: 'Coat',
      initialValue: intelligentCast<Color>(_ponyModel.coatColor),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.computeLuminance() < .3)
          return 'This color is not cheery enough.';
        return null;
      },
      onSaved: (value) => _ponyModel.coatColor = colorToString(value),
      onChanged: (value) => _showSnackBar('Coat', value),
    );
  }

  CardSettingsMultiselect _buildCardSettingsMultiselect(Key key) {
    return CardSettingsMultiselect(
      key: key,
      label: 'Hobbies',
      initialValues: _ponyModel.hobbies,
      options: allHobbies,
      onSaved: (value) => _ponyModel.hobbies = value,
      onChanged: (value) => _showSnackBar('Hobbies', value),
    );
  }

  CardSettingsParagraph _buildCardSettingsParagraph(Key key, int lines) {
    return CardSettingsParagraph(
      key: key,
      label: 'Description',
      initialValue: _ponyModel.description,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.description = value,
      onChanged: (value) => _showSnackBar('Description', value),
    );
  }

  CardSettingsNumberPicker _buildCardSettingsNumberPicker(Key key,
      {TextAlign labelAlign}) {
    return CardSettingsNumberPicker(
      key: key,
      label: 'Age',
      labelAlign: labelAlign,
      initialValue: _ponyModel.age,
      min: 1,
      max: 30,
      validator: (value) {
        if (value == null) return 'Age is required.';
        if (value > 20) return 'No grown-ups allwed!';
        if (value < 3) return 'No Toddlers allowed!';
        return null;
      },
      onSaved: (value) => _ponyModel.age = value,
      onChanged: (value) => _showSnackBar('Age', value),
    );
  }

  CardSettingsListPicker _buildCardSettingsListPicker_Type(Key key) {
    return CardSettingsListPicker(
      key: key,
      label: 'Type',
      initialValue: _ponyModel.type,
      autovalidate: _autoValidate,
      options: <String>['Earth', 'Unicorn', 'Pegasi', 'Alicorn'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      onSaved: (value) => _ponyModel.type = value,
      onChanged: (value) => _showSnackBar('Type', value),
    );
  }

  CardSettingsText _buildCardSettingsText_Name(Key key) {
    return CardSettingsText(
      key: key,
      label: 'Name',
      initialValue: _ponyModel.name,
      requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name type is required.';
        return null;
      },
      onSaved: (value) => _ponyModel.name = value,
      onChanged: (value) => _showSnackBar('Name', value),
    );
  }

  /* EVENT HANDLERS */

  Future _savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      showResults(context, _ponyModel);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void _resetPressed() {
    _formKey.currentState.reset();
  }

  void _closePressed() {
    // This is just a placeholder to have a third button
  }

  void _showSnackBar(String label, dynamic value) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(label + ' = ' + value.toString()),
      ),
    );
  }
}
