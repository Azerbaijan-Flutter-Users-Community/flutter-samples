import 'package:bmi_calculator/blocs/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageBloc extends BaseBloc {
  LanguageBloc() {
    // update values of [_currentLocale] according to stream's value
    _localeChangeSubject.stream.listen((bool isEnabled) {
      _localeSubject.add(isEnabled ? Locale('az') : Locale('en'));
    });
  }

  BehaviorSubject<Locale> _localeSubject = new BehaviorSubject<Locale>();
  BehaviorSubject<bool> _localeChangeSubject = new BehaviorSubject<bool>();

  Stream<Locale> get currentLocale => _localeSubject.stream;
  Stream<bool> get languageEnabled => _localeChangeSubject.stream;

  /// This method runs when the app is started
  void loadDefaultLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('language') == null) {
      _localeChangeSubject.add(false);
      return;
    }

    final language = prefs.getString('language');
    if (language == 'az')
      _localeChangeSubject.add(true);
    else
      _localeChangeSubject.add(false);
  }

  void changeLanguage(bool isEnabled) async {
    var prefs = await SharedPreferences.getInstance();

    if (isEnabled) {
      prefs.setString(
        'language',
        'az',
      );
      _localeChangeSubject.add(isEnabled);
    } else {
      prefs.setString(
        'language',
        'en',
      );
      _localeChangeSubject.add(isEnabled);
    }
  }

  @override
  void dispose() {
    Future.wait([
      _localeSubject.close(),
      _localeChangeSubject.close(),
    ]);
  }
}
