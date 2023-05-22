import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'scaffold.dart';

class ExampleTheme extends StatelessWidget {
  const ExampleTheme({
    Key? key,
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
          home: const ExampleScaffold(),
        );
      },
    );
  }
}

ThemeData _buildTheme(Brightness brightness) {
  if (brightness == Brightness.dark) {
    return ThemeData.dark();
  } else {
    return ThemeData(
      primaryColor: Colors.teal, // app header background
      secondaryHeaderColor: Colors.indigo[400], // card header background
      cardColor: Colors.white, // app background color
      textTheme: TextTheme(
        labelLarge: TextStyle(color: Colors.deepPurple[900]), // button text
        titleMedium: TextStyle(color: Colors.grey[800]), // input text
        titleLarge: const TextStyle(color: Colors.white), // card header text
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.indigo[100]!), // button background color
          foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white), // button text color
        ),
      ),
      primaryTextTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.lightBlue[50]), // app header text
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.indigo[400]), // style for labels
      ),
      //fontFamily: GoogleFonts.getFont('Paprika').fontFamily, colorScheme: ColorScheme(background: Colors.indigo[100]),
      // cardTheme: CardTheme(
      //   shape: RoundedRectangleBorder(
      //     side: BorderSide(width: 2, color: Colors.orange),
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),
    );
  }
}
