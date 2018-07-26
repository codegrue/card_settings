import 'package:flutter/material.dart';

import 'ponyexample.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Card Settings Example',
      home: new PonyExample(),
      theme: Theme.of(context).copyWith(
        accentColor: Colors.indigo[400],
        backgroundColor: Colors.indigo[100],
        primaryColor: Colors.teal,
      ),
    );
  }
}


