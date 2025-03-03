import 'package:flutter/material.dart';

class TColor {
  static final text = TextColors();
  static final error = ErrorColors();
  static final button = ButtonColors();
  static final primary = PrimaryColors();
  static final background = BackgroundColors();
}

class TextColors {
  final Color primary = const Color.fromARGB(255, 255, 255, 255);
  final Color secondary = const Color.fromARGB(255, 200, 200, 200);
}

class PrimaryColors {
  final Color dark = const Color.fromARGB(200, 45, 80, 200);
  final Color light = const Color.fromARGB(255, 45, 80, 200);
}

class ErrorColors {
  final Color main = const Color.fromRGBO(244, 67, 54, 1);
}

class BackgroundColors {
  final Color main = const Color.fromARGB(255, 31, 34, 41);
  final Color light = const Color.fromARGB(255, 36, 39, 47);
  final Color border = const Color.fromARGB(255, 55, 58, 66);
  final Color success = const Color.fromARGB(255, 15, 146, 70);
}

class ButtonColors {
  final Color primary = PrimaryColors().light;
}
