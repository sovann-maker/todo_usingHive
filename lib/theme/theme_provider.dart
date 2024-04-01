import 'package:flutter/material.dart';
import 'package:todo/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleDarkTheme() {
    themeData = darkMode;
  }

  void toggleLightTheme() {
    themeData = lightMode;
  }
}
