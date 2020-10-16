import 'package:flutter/material.dart';

class AppThemeData {
  ThemeData get materialTheme {
    return ThemeData(
      primaryColor: Colors.pink[450],
      primarySwatch: Colors.pink[450],
      buttonColor: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Colors.pink[300],
          focusColor: Colors.red,
          hoverColor: Colors.black,
          splashColor: Colors.yellow,
          elevation: 4,
          focusElevation: 5,
          hoverElevation: 3,
          disabledElevation: 3,
          highlightElevation: 3
      ),
    );
  }
}