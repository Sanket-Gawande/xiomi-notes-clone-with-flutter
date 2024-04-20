import 'package:flutter/material.dart';
import 'package:mi_notes/theme/config.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData theme = lightMode;

  void toggleTheme() {
    if (theme == lightMode) {
      theme = darkMode;
    } else {
      theme = lightMode;
    }
    notifyListeners();
  }
}
