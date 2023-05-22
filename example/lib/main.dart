import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'plumbing/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ExampleTheme();
  }
}
