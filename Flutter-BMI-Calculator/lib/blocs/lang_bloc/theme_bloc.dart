import 'package:bmi_calculator/blocs/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends BaseBloc {
  BehaviorSubject<ThemeMode> _themeSubject = new BehaviorSubject<ThemeMode>();
  BehaviorSubject<bool> _themeChangeSubject = new BehaviorSubject<bool>();

  ThemeBloc() {
    _themeChangeSubject.stream.listen((bool isEnabled) {
      print('good listener');
      _themeSubject.add(isEnabled ? ThemeMode.dark : ThemeMode.light);
    });
  }

  Stream<ThemeMode> get currentThemeMode => _themeSubject.stream;
  Stream<bool> get darkModeEnabled => _themeChangeSubject.stream;

  /// This method runs when the app is started
  void loadDefaultTheme() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('theme') == null) {
      _themeChangeSubject.add(false);
      return;
    }

    final isDarkModeEnabled = prefs.getBool('theme');
    if (isDarkModeEnabled)
      _themeChangeSubject.add(true);
    else
      _themeChangeSubject.add(false);
  }

  void changeTheme(bool isEnabled) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool('theme', isEnabled);
    _themeChangeSubject.add(isEnabled);
  }

  @override
  void dispose() {
    _themeSubject?.close();
    _themeChangeSubject?.close();
  }
}
