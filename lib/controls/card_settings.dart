import 'package:flutter/material.dart';

class CardSettings extends StatefulWidget {
  CardSettings({this.children});

  final List<Widget> children;

  @override
  _CardSettingState createState() => new _CardSettingState();
}

class _CardSettingState extends State<CardSettings> {

  Widget build(BuildContext context) {
    return new SingleChildScrollView( //Container(
      padding: EdgeInsets.all(12.0),    
      child: Card(
        elevation: 5.0,
        child: new Column(
          children: widget.children
        ),
      )
    );
  }

}

