import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../example.dart';

class ExampleScaffold extends StatefulWidget {
  const ExampleScaffold({Key? key}) : super(key: key);

  @override
  _ExampleScaffoldState createState() => _ExampleScaffoldState();
}

class _ExampleScaffoldState extends State<ExampleScaffold> {
  bool _showMaterialonIOS = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ExampleFormState> _formWidgetKey =
      GlobalKey<ExampleFormState>();

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    final form = ExampleForm(orientation, _showMaterialonIOS, _scaffoldKey,
        key: _formWidgetKey, onValueChanged: showSnackBar);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("My Little Pony"),
        actions: <Widget>[
          IconButton(
            icon: Theme.of(context).brightness == Brightness.dark
                ? const Icon(Icons.brightness_7)
                : const Icon(Icons.brightness_4),
            onPressed: () => AdaptiveTheme.of(context).toggleThemeMode(),
          ),
          _cupertinoSwitchButton(),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: (_formWidgetKey.currentState == null)
                ? null
                : _formWidgetKey.currentState!.savePressed,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: (_formWidgetKey.currentState == null)
              ? null
              : _formWidgetKey.currentState!.resetPressed,
        ),
      ),
      body: form,
    );
  }

  void showSnackBar(String label, dynamic value) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
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
                  ? const FaIcon(FontAwesomeIcons.apple)
                  : const Icon(Icons.android),
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
