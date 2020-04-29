import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/blocs/lang_bloc/theme_bloc.dart';
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
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _languageBloc.languageEnabled,
            builder: (context, langSnapshot) {
              return SwitchListTile(
                value: langSnapshot.hasData ? langSnapshot.data : false,
                activeColor: Theme.of(context).primaryColor,
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
                value: themeSnapshot.hasData ? themeSnapshot.data : false,
                activeColor: Theme.of(context).primaryColorDark,
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
            title: Text('About'),
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
