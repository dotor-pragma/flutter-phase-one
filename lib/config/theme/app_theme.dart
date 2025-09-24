import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.tealAccent,
  Colors.indigoAccent,
  Colors.pinkAccent,
  Colors.limeAccent,
  Colors.deepPurpleAccent,
  Colors.orangeAccent,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
    : assert(
        selectedColor >= 0 && selectedColor < colorList.length,
        '🎨 Selected color is out of range',
      );

  ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: colorList[selectedColor]),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );
  }
}
