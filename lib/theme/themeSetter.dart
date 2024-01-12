import 'package:flutter/material.dart';
import 'darkMode.dart';
import 'lightMode.dart';

class ThemeSetter extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

void toggleTheme(){
  if (_themeData == lightMode){
    themeData = darkMode;
  } else{
    themeData = lightMode;
  }
 }
}