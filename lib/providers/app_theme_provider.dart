import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode theme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) {
    if (theme == newTheme) {
      return;
    }
    theme = newTheme;
    notifyListeners();
  }
}
