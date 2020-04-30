import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/blocs/theme_bloc/theme_bloc.dart';
import 'package:bmi_calculator/constants/localization_keys.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  LanguageBloc _languageBloc;
  ThemeBloc _themeBloc;

  @override
  void initState() {
    _languageBloc = GetIt.instance.get<LanguageBloc>();
    _themeBloc = GetIt.instance.get<ThemeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate(LocalizationKeys.settings)),
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _languageBloc.languageEnabled,
            builder: (context, langSnapshot) {
              return SwitchListTile(
                activeColor: Colors.pinkAccent,
                value: langSnapshot.hasData ? langSnapshot.data : false,
                title: Text(AppLocalizations.of(context)
                    .translate(LocalizationKeys.languageSelection)),
                onChanged: (value) {
                  _languageBloc.changeLanguage(value);
                },
              );
            },
          ),
          Divider(
            height: 0,
          ),
          StreamBuilder<bool>(
            stream: _themeBloc.darkModeEnabled,
            builder: (context, themeSnapshot) {
              return SwitchListTile(
                activeColor: Colors.pinkAccent,
                value: themeSnapshot.hasData ? themeSnapshot.data : false,
                title: Text(AppLocalizations.of(context)
                    .translate(LocalizationKeys.darkMode)),
                onChanged: (value) {
                  _themeBloc.changeTheme(value);
                },
              );
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            title: Text(
                AppLocalizations.of(context).translate(LocalizationKeys.about)),
            onTap: () {},
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
