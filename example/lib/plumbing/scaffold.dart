import 'dart:io';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../example.dart';

class ExampleScaffold extends StatefulWidget {
  @override
  _ExampleScaffoldState createState() => _ExampleScaffoldState();
}

class _ExampleScaffoldState extends State<ExampleScaffold> {
  bool _showMaterialonIOS = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ExampleFormState> _formStateKey =
      GlobalKey<ExampleFormState>();

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    final form = ExampleForm(orientation, _showMaterialonIOS, _scaffoldKey,
        key: _formStateKey, onValueChanged: showSnackBar);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("My Little Pony"),
        actions: <Widget>[
          IconButton(
            icon: Theme.of(context).brightness == Brightness.dark
                ? Icon(Icons.brightness_7)
                : Icon(Icons.brightness_4),
            onPressed: () => DynamicTheme.of(context).setBrightness(
                Theme.of(context).brightness == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark),
          ),
          _cupertinoSwitchButton(),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: null, //_formStateKey.currentState.savePressed,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: null, //_formStateKey.currentState.resetPressed,
        ),
      ),
      body: form,
    );
  }

  void showSnackBar(String label, dynamic value) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(label + ' = ' + value.toString()),
      ),
    );
  }

  Widget _cupertinoSwitchButton() {
    // dont show this button on web
    if (kIsWeb) return Container();

    return Container(
      child: Platform.isIOS
          ? IconButton(
              icon: (_showMaterialonIOS)
                  ? FaIcon(FontAwesomeIcons.apple)
                  : Icon(Icons.android),
              onPressed: () {
                setState(() {
                  _showMaterialonIOS = !_showMaterialonIOS;
                });
              },
            )
          : null,
    );
  }
}
