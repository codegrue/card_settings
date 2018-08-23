import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model.dart';

void showResults(BuildContext context, PonyModel model) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Updated Results'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildResultsRow('Name', model.name),
              _buildResultsRow('Type', model.type),
              _buildResultsRow('Age', model.age),
              _buildResultsRow('Description', model.description,
                  linebreak: true),
              _buildResultsRow('Hobbies', model.hobbies, linebreak: true),
              _buildResultsRow('CoatColor', model.coatColor),
              _buildResultsRow('ManeColor', model.maneColor),
              _buildResultsRow('HasSpots', model.hasSpots),
              _buildResultsRow('SpotColor', model.spotColor),
              _buildResultsRow('Height', model.height),
              _buildResultsRow('Weight', model.weight),
              _buildResultsRow(
                  'ShowDate', DateFormat.yMd().format(model.showDateTime)),
              _buildResultsRow(
                  'ShowTime', DateFormat.jm().format(model.showDateTime)),
              _buildResultsRow('Phone', model.boxOfficePhone),
              _buildResultsRow('Price', model.ticketPrice),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _buildResultsRow(String name, dynamic value, {bool linebreak: false}) {
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
          _buildValueInline(value, linebreak),
        ],
      ),
      _buildValueOnOwnRow(value, linebreak),
      Container(height: 12.0),
    ],
  );
}

Widget _buildValueInline(dynamic value, bool linebreak) {
  return (linebreak) ? Container() : Text(value.toString());
}

Widget _buildValueOnOwnRow(dynamic value, bool linebreak) {
  return (linebreak) ? Text(value.toString()) : Container();
}
