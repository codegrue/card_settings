import 'dart:async';
import 'package:flutter/material.dart';
import 'package:card_settings/card_settings.dart';
import 'package:intl/intl.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Card Settings Example',
      home: new PonyExample(),
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

// example viewmodel for the form
class PonyModel {
  String name = 'Twilight Sparkle';
  String type = 'Unicorn';
  int age = 7;
  String coatColor = 'D19FE4';
  String maneColor = '273873';
  bool hasSpots = false;
  String spotColor = 'FF5198';
  String description =
      'An intelligent and dutiful scholar with an avid love of learning and skill in unicorn magic such as levitation, teleportation, and the creation of force fields.';
  double height = 3.5;
  int weight = 45;
  DateTime showDateTime = DateTime(2010, 10, 10, 20, 30);
  double ticketPrice = 65.99;
  String email = 'me@nowhere.org';
  String password = 'secret';
}

class PonyExample extends StatefulWidget {
  @override
  _PonyExampleState createState() => _PonyExampleState();
}

class _PonyExampleState extends State<PonyExample> {
  final _ponyModel = PonyModel();

  bool _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          child: CardSettings(
            children: <Widget>[
              CardSettingsHeader(label: 'Bio'),
              CardSettingsText(
                label: 'Name',
                initialValue: _ponyModel.name,
                autovalidate: _autoValidate,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Name type is required.';
                },
                onSaved: (value) => _ponyModel.name = value,
                onChanged: (value) => _showSnackBar('Name', value),
              ),
              CardSettingsListPicker(
                label: 'Type',
                labelAlign: TextAlign.left,
                initialValue: _ponyModel.type,
                autovalidate: _autoValidate,
                options: <String>['Earth', 'Unicorn', 'Pegasi', 'Alicorn'],
                validator: (String value) {
                  if (value == null || value.isEmpty)
                    return 'You must pick a type.';
                },
                onSaved: (value) => _ponyModel.type = value,
                onChanged: (value) => _showSnackBar('Type', value),
              ),
              CardSettingsNumberPicker(
                label: 'Age',
                initialValue: _ponyModel.age,
                min: 1,
                max: 30,
                validator: (value) {
                  if (value == null) return 'Age is required.';
                  if (value > 20) return 'No grown-ups allwed!';
                  if (value < 3) return 'No Toddlers allowed!';
                },
                onSaved: (value) => _ponyModel.age = value,
                onChanged: (value) => _showSnackBar('Age', value),
              ),
              CardSettingsParagraph(
                label: 'Description',
                initialValue: _ponyModel.description,
                numberOfLines: 5,
                onSaved: (value) => _ponyModel.description = value,
                onChanged: (value) => _showSnackBar('Description', value),
              ),
              CardSettingsHeader(label: 'Colors'),
              CardSettingsColorPicker(
                label: 'Coat',
                initialValue: intelligentCast<Color>(_ponyModel.coatColor),
                validator: (value) {
                  if (value.computeLuminance() < .3)
                    return 'This color is not cheery enough.';
                },
                onSaved: (value) => _ponyModel.coatColor = colorToString(value),
                onChanged: (value) => _showSnackBar('Coat', value),
              ),
              CardSettingsColorPicker(
                label: 'Mane',
                initialValue: intelligentCast<Color>(_ponyModel.maneColor),
                validator: (value) {
                  if (value.computeLuminance() > .7)
                    return 'This color is too light.';
                },
                onSaved: (value) => _ponyModel.maneColor = colorToString(value),
                onChanged: (value) => _showSnackBar('Mane', value),
              ),
              CardSettingsSwitch(
                label: 'Has Spots?',
                initialValue: _ponyModel.hasSpots,
                onChanged: (value) {
                  setState(() => _ponyModel.hasSpots = value);
                  _showSnackBar('Has Spots?', value);
                },
                onSaved: (value) => _ponyModel.hasSpots = value,
              ),
              CardSettingsColorPicker(
                label: 'Spot',
                initialValue: intelligentCast<Color>(_ponyModel.spotColor),
                visible: _ponyModel.hasSpots,
                onSaved: (value) => _ponyModel.spotColor = colorToString(value),
                onChanged: (value) => _showSnackBar('Spot', value),
              ),
              CardSettingsHeader(label: 'Size'),
              CardSettingsDouble(
                label: 'Height',
                unitLabel: 'feet',
                initialValue: _ponyModel.height,
                onSaved: (value) => _ponyModel.height = value,
                onChanged: (value) => _showSnackBar('Height', value),
              ),
              CardSettingsInt(
                label: 'Weight',
                unitLabel: 'lbs',
                initialValue: _ponyModel.weight,
                validator: (value) {
                  if (value != null) {
                    if (value > 70) return 'You won\'t fly at the weight.';
                    if (value < 10) return 'Cmon, you are not a feather.';
                  }
                },
                onSaved: (value) => _ponyModel.weight = value,
                onChanged: (value) => _showSnackBar('Weight', value),
              ),
              CardSettingsHeader(label: 'First Show'),
              CardSettingsInstructions(
                text: 'This is when this little horse got her big break',
              ),
              CardSettingsDatePicker(
                label: 'Show Date',
                initialValue: _ponyModel.showDateTime,
                onSaved: (value) => _ponyModel.showDateTime =
                    updateJustDate(value, _ponyModel.showDateTime),
                onChanged: (value) => _showSnackBar('Show Date', value),
              ),
              CardSettingsTimePicker(
                label: 'Show Time',
                initialValue: TimeOfDay(
                    hour: _ponyModel.showDateTime.hour,
                    minute: _ponyModel.showDateTime.minute),
                onSaved: (value) => _ponyModel.showDateTime =
                    updateJustTime(value, _ponyModel.showDateTime),
                onChanged: (value) => _showSnackBar('Show Time', value),
              ),
              CardSettingsCurrency(
                label: 'Ticket Price',
                initialValue: _ponyModel.ticketPrice,
                // validator: (value) {
                //   if (value != null && value > 100)
                //     return 'No scalpers allowed!';
                // },
                //\onSaved: (value) => _ponyModel.ticketPrice = value,
                onChanged: (value) => _showSnackBar('Ticket Price', value),
              ),
              CardSettingsHeader(label: 'Security'),
              CardSettingsEmail(
                initialValue: _ponyModel.email,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Email is required.';
                  if (!value.contains('@'))
                    return "Email not formatted correctly.";
                },
                onSaved: (value) => _ponyModel.email = value,
                onChanged: (value) => _showSnackBar('Email', value),
              ),
              CardSettingsPassword(
                initialValue: _ponyModel.password,
                validator: (value) {
                  if (value == null) return 'Password is required.';
                  if (value.length <= 6)
                    return 'Must be more than 6 characters.';
                },
                onSaved: (value) => _ponyModel.password = value,
                onChanged: (value) => _showSnackBar('Password', value),
              ),
              CardSettingsHeader(label: 'Actions'),
              CardSettingsButton(
                label: 'SAVE',
                onPressed: _savePressed,
              ),
              CardSettingsButton(
                label: 'RESET',
                onPressed: _resetPressed,
                bottomSpacing: 4.0,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _savePressed() async {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _showResults();
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void _resetPressed() {
    _formKey.currentState.reset();
  }

  void _showSnackBar(String label, value) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(label + ' = ' + value.toString()),
      ),
    );
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Updated Results'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildRow('Name', _ponyModel.name),
                _buildRow('Type', _ponyModel.type),
                _buildRow('Age', _ponyModel.age),
                Text(_ponyModel.description),
                _buildRow('CoatColor', _ponyModel.coatColor),
                _buildRow('ManeColor', _ponyModel.maneColor),
                _buildRow('HasSpots', _ponyModel.hasSpots),
                _buildRow('SpotColor', _ponyModel.spotColor),
                _buildRow('Height', _ponyModel.height),
                _buildRow('Weight', _ponyModel.weight),
                _buildRow('ShowDate',
                    DateFormat.yMd().format(_ponyModel.showDateTime)),
                _buildRow('ShowTime',
                    DateFormat.jm().format(_ponyModel.showDateTime)),
                _buildRow('Price', _ponyModel.ticketPrice),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(String name, dynamic value) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '$name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(value.toString()),
          ],
        ),
        Container(height: 12.0),
      ],
    );
  }
}
