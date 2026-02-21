import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    update();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", _themeMode == ThemeMode.dark);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool("isDarkMode") ?? false;

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    update();
  }
}