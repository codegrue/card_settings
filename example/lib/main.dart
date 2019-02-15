import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
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
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.lightBlue[50]), // style for headers
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.indigo[400]), // style for labels
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
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: (orientation == Orientation.portrait)
              ? _buildPortraitLayout()
              : _buildLandscapeLayout(),
        ),
      ),
    );
  }

  AppBar appBar() => AppBar(
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
        ),
      );

  /* CARDSETTINGS FOR EACH LAYOUT */

  CardSettings _buildPortraitLayout() {
    return CardSettings(
      children: <Widget>[
        CardSettingsHeader(label: 'Bio'),
        _buildCardSettingsText_Name(),
        _buildCardSettingsListPicker_Type(),
        _buildCardSettingsNumberPicker(),
        _buildCardSettingsParagraph(5),
        _buildCardSettingsMultiselect(),
        CardSettingsHeader(label: 'Colors'),
        _buildCardSettingsColorPicker_Coat(),
        _buildCardSettingsColorPicker_Mane(),
        _buildCardSettingsSwitch_Spots(),
        _buildCardSettingsColorPicker_Spot(),
        CardSettingsHeader(label: 'Size'),
        _buildCardSettingsDouble_Height(),
        _buildCardSettingsInt_Weight(),
        CardSettingsHeader(label: 'First Show'),
        _buildCardSettingsInstructions(),
        _buildCardSettingsDatePicker(),
        _buildCardSettingsTimePicker(),
        _buildCardSettingsCurrency(),
        _buildCardSettingsPhone(),
        CardSettingsHeader(label: 'Security'),
        _buildCardSettingsEmail(),
        _buildCardSettingsPassword(),
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
        _buildCardSettingsText_Name(),
        CardFieldLayout(
          <Widget>[
            _buildCardSettingsListPicker_Type(),
            _buildCardSettingsNumberPicker(labelAlign: TextAlign.right),
          ],
          flexValues: [2, 1],
        ),
        _buildCardSettingsParagraph(3),
        _buildCardSettingsMultiselect(),
        // note, different order than portrait to show state mapping
        CardSettingsHeader(label: 'Security'),
        CardFieldLayout(<Widget>[
          _buildCardSettingsEmail(),
          _buildCardSettingsPassword(),
        ]),
        CardSettingsHeader(label: 'Colors'),
        CardFieldLayout(<Widget>[
          _buildCardSettingsColorPicker_Coat(),
          _buildCardSettingsColorPicker_Mane(),
        ]),
        CardFieldLayout(<Widget>[
          _buildCardSettingsSwitch_Spots(),
          _buildCardSettingsColorPicker_Spot(),
        ]),
        CardSettingsHeader(label: 'Size'),
        CardFieldLayout(<Widget>[
          _buildCardSettingsDouble_Height(),
          _buildCardSettingsInt_Weight(),
        ]),
        CardSettingsHeader(label: 'First Show'),
        _buildCardSettingsInstructions(),
        CardFieldLayout(<Widget>[
          _buildCardSettingsDatePicker(),
          _buildCardSettingsTimePicker(),
        ]),
        CardFieldLayout(<Widget>[
          _buildCardSettingsCurrency(),
          _buildCardSettingsPhone(),
        ]),
        CardSettingsHeader(label: 'Actions'),
        CardFieldLayout(<Widget>[
          _buildCardSettingsButton_Save(),
          _buildCardSettingsButton_Reset(),
        ]),
        Container(height: 4.0)
      ],
    );
  }

  /* BUILDERS FOR EACH FIELD */

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
      onChanged: (value) => _showSnackBar('Password', value),
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
      onChanged: (value) => _showSnackBar('Email', value),
    );
  }

  CardSettingsPhone _buildCardSettingsPhone() {
    return CardSettingsPhone(
      key: _phoneKey,
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
      onChanged: (value) => _showSnackBar('Ticket Price', value),
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
      onChanged: (value) => _showSnackBar('Show Time', value),
    );
  }

  CardSettingsDatePicker _buildCardSettingsDatePicker() {
    return CardSettingsDatePicker(
      key: _dateKey,
      justDate: true,
      icon: Icon(Icons.calendar_today),
      label: 'Date',
      initialValue: _ponyModel.showDateTime,
      onSaved: (value) => _ponyModel.showDateTime =
          updateJustDate(value, _ponyModel.showDateTime),
      onChanged: (value) {
        setState(() {
          _ponyModel.showDateTime = value;
        });
        _showSnackBar('Show Date', _ponyModel.showDateTime);
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

  CardSettingsDouble _buildCardSettingsDouble_Height() {
    return CardSettingsDouble(
      key: _heightKey,
      label: 'Height',
      unitLabel: 'feet',
      initialValue: _ponyModel.height,
      onSaved: (value) => _ponyModel.height = value,
      onChanged: (value) => _showSnackBar('Height', value),
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Spot() {
    return CardSettingsColorPicker(
      key: _spotKey,
      label: 'Spot',
      initialValue: intelligentCast<Color>(_ponyModel.spotColor),
      visible: _ponyModel.hasSpots,
      onSaved: (value) => _ponyModel.spotColor = colorToString(value),
      onChanged: (value) => _showSnackBar('Spot', value),
    );
  }

  CardSettingsSwitch _buildCardSettingsSwitch_Spots() {
    return CardSettingsSwitch(
      key: _hasSpotsKey,
      label: 'Has Spots?',
      initialValue: _ponyModel.hasSpots,
      onChanged: (value) {
        setState(() => _ponyModel.hasSpots = value);
        _showSnackBar('Has Spots?', value);
      },
      onSaved: (value) => _ponyModel.hasSpots = value,
    );
  }

  CardSettingsColorPicker _buildCardSettingsColorPicker_Mane() {
    return CardSettingsColorPicker(
      key: _maneKey,
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
      onChanged: (value) => _showSnackBar('Coat', value),
    );
  }

  CardSettingsMultiselect _buildCardSettingsMultiselect() {
    return CardSettingsMultiselect(
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
      onChanged: (value) => _showSnackBar('Hobbies', value),
    );
  }

  CardSettingsParagraph _buildCardSettingsParagraph(int lines) {
    return CardSettingsParagraph(
      key: _descriptionlKey,
      label: 'Description',
      initialValue: _ponyModel.description,
      numberOfLines: lines,
      onSaved: (value) => _ponyModel.description = value,
      onChanged: (value) => _showSnackBar('Description', value),
    );
  }

  CardSettingsNumberPicker _buildCardSettingsNumberPicker(
      {TextAlign labelAlign}) {
    return CardSettingsNumberPicker(
      key: _ageKey,
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

  CardSettingsListPicker _buildCardSettingsListPicker_Type() {
    return CardSettingsListPicker(
      key: _typeKey,
      label: 'Type',
      initialValue: _ponyModel.type,
      hintText: 'Select One',
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

  CardSettingsText _buildCardSettingsText_Name() {
    return CardSettingsText(
      key: _nameKey,
      label: 'Name',
      hintText: 'something cute...',
      initialValue: _ponyModel.name,
      requiredIndicator: Text('*', style: TextStyle(color: Colors.red)),
      autovalidate: _autoValidate,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Name is required.';
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

  void _showSnackBar(String label, dynamic value) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(label + ' = ' + value.toString()),
      ),
    );
  }
}
