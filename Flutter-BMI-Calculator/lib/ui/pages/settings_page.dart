import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/blocs/theme_bloc/theme_bloc.dart';
import 'package:bmi_calculator/constants/localization_keys.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:bmi_calculator/ui/widgets/language_dialog.dart';
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
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .translate(LocalizationKeys.languageSelection),
              style: Theme.of(context).textTheme.subtitle,
            ),
            onTap: () => showDialog(
              context: context,
              builder: (context) => LanguageDialog(),
            ),
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
                title: Text(
                    AppLocalizations.of(context)
                        .translate(LocalizationKeys.darkMode),
                    style: Theme.of(context).textTheme.subtitle),
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
                AppLocalizations.of(context).translate(LocalizationKeys.about),
                style: Theme.of(context).textTheme.subtitle),
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationName: 'BMI Calculator',
                  applicationVersion: 'v2.0.4',
                  applicationIcon: Image.asset('assets/bmi.png'),
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate(LocalizationKeys.about_app),
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)
                          .translate(LocalizationKeys.developer_info),
                    ),
                  ]);
            },
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
