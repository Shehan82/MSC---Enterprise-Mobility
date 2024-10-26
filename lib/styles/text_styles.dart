import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle mainMenuButtonTextStyle(Color textColor) {
    return TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: textColor);
  }

  static TextStyle alphabetButtonTextStyle(Color textColor, double fontSize) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor);
  }
}
