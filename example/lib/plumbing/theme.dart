import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'scaffold.dart';

class ExampleTheme extends StatelessWidget {
  const ExampleTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: _buildTheme(Brightness.light),
      dark: _buildTheme(Brightness.dark),
      builder: (context, theme) {
        return MaterialApp(
          title: 'Card Settings Example',
          theme: theme,
          home: ExampleScaffold(),
        );
      },
    );
  }
}

ThemeData _buildTheme(Brightness brightness) {
  if (brightness == Brightness.dark) {
    return ThemeData(
      primarySwatch: Colors.teal,
      brightness: brightness,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      backgroundColor: Colors.black,
      textTheme: GoogleFonts.paprikaTextTheme(TextTheme()),
      fontFamily: GoogleFonts.getFont('Paprika').fontFamily,
    );
  } else {
    return ThemeData(
      primaryColor: Colors.teal, // app header background
      secondaryHeaderColor: Colors.indigo[400], // card header background
      cardColor: Colors.white, // card field background
      backgroundColor: Colors.indigo[100], // app background color
      buttonColor: Colors.lightBlueAccent[100], // button background color
      textTheme: TextTheme(
        button: TextStyle(color: Colors.deepPurple[900]), // button text
        subtitle1: TextStyle(color: Colors.grey[800]), // input text
        headline6: TextStyle(color: Colors.white), // card header text
      ),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(color: Colors.lightBlue[50]), // app header text
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.indigo[400]), // style for labels
      ),
      fontFamily: GoogleFonts.getFont('Paprika').fontFamily,
      // cardTheme: CardTheme(
      //   shape: RoundedRectangleBorder(
      //     side: BorderSide(width: 2, color: Colors.orange),
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),
    );
  }
}
