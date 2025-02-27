import 'package:flutter/material.dart';
import 'package:geapp/themes/color.dart';

extension ThemeExtensions on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Color get scaffoldColor => TColor.background.main;
}

extension ScreenSizeExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenOrientation =>
      MediaQuery.of(this).orientation == Orientation.portrait
          ? screenHeight
          : screenWidth;
}

extension KeyboardVisibility on BuildContext {
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;
}
