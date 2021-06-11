// example viewmodel for the form
import 'dart:typed_data';

import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PonyModel {
  String name = 'Twilight Sparkle';
  PickerModel type = ponyTypes[1]; //TODO, bind by value
  int age = 7;
  PickerModel gender = ponyGenders[1]; //TODO: "F";
  String coatColor = 'D19FE4';
  String maneColor = '273873';
  bool hasSpots = false;
  String spotColor = 'FF5198';
  String description =
      'An intelligent and dutiful scholar with an avid love of learning and skill in unicorn magic such as levitation, teleportation, and the creation of force fields.';
  List<String> hobbies = <String>[
    'flying',
    'singing',
    'exploring',
    'hiding',
    'coloring'
  ];
  double height = 3.5;
  int weight = 45;
  PickerModel style = ponyStyles[1]; // TODO: "MG";
  DateTime showDateTime = DateTime(2010, 10, 10, 20, 30);
  double ticketPrice = 65.99;
  int boxOfficePhone = 18005551212;
  String email = 'me@nowhere.org';
  String password = 'secret1';
  double rating = 0.25;
  Uint8List photo;
  Uint8List video = Uint8List(1024 * 1024 * 15);
  Uint8List audio = Uint8List(1024 * 4);
  Uint8List customFile = Uint8List(4);

  void loadMedia() async {
    photo = (await rootBundle.load('assets/twilight_sparkle.png'))
        .buffer
        .asUint8List();
  }
}

const List<String> allHobbies = <String>[
  'running',
  'flying',
  'coloring',
  'jumping',
  'eating',
  'hiding',
  'exploring',
  'singing',
  'dancing',
  'acting',
  'cleaning',
  'shopping',
  'sewing',
  'cooking',
];

const List<PickerModel> ponyTypes = <PickerModel>[
  PickerModel('Earth', code: 'E'),
  PickerModel('Unicorn', code: 'U'),
  PickerModel('Pegasi', code: 'P'),
  PickerModel('Alicorn', code: 'A'),
];

const List<PickerModel> ponyGenders = <PickerModel>[
  PickerModel('Male', code: 'M'),
  PickerModel('Female', code: 'F'),
];

const List<PickerModel> ponyStyles = <PickerModel>[
  PickerModel('Majestic', code: 'MG', icon: Icon(Icons.sort)),
  PickerModel('Scrawny', code: 'SC', icon: Icon(Icons.clear_all)),
  PickerModel('Sleek', code: 'SL', icon: Icon(Icons.swap_calls)),
];
