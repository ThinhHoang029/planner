import 'package:daily_planner1/widgets/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  // Thêm phương thức để thay đổi theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners(); // Gọi notifyListeners() để cập nhật trạng thái
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
