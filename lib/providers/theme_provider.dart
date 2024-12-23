import 'package:flutter/material.dart';
import 'package:folheando/core/themes/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider with ChangeNotifier {
  static const themeKey = 'theme_mode';
  ThemeMode _themeMode;

  ThemeProvider() : _themeMode = ThemeMode.light {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeData get theme => _themeMode == ThemeMode.dark 
    ? AppThemes.darkTheme 
    : AppThemes.lightTheme;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(themeKey);
    
    if (savedTheme != null) {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, _themeMode == ThemeMode.dark ? 'dark' : 'light');
    
    notifyListeners();
  }
}
