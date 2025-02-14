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

extension NavigationExtensions on BuildContext {
  Future<dynamic> push(String page, [dynamic args]) async {
    return await Navigator.of(this).pushNamed(page, arguments: args);
  }

  void pushTo(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void pop([Object? result]) {
    Navigator.of(this).pop(result);
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}
