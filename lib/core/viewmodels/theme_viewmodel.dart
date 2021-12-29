import 'package:flutter/material.dart';
import 'package:mybooks/core/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ThemeViewModel extends BaseViewModel {
  ThemeData _selectedTheme = lightTheme;
  late SharedPreferences prefs;
  ThemeData get getTheme => _selectedTheme;

  Future<void> changeTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (_selectedTheme == darkTheme) {
      _selectedTheme = lightTheme;
      await prefs.setBool("isDark", false);
    } else {
      _selectedTheme = darkTheme;
      await prefs.setBool("isDark", true);
    }
//notifying all the listeners(consumers) about the change.
    notifyListeners();
  }
}
