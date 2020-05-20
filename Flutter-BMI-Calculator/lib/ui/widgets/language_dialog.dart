import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/constants/localization_keys.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LanguageDialog extends StatefulWidget {
  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  int group = 1;
  LanguageBloc _languageBloc;

  @override
  void initState() {
    _languageBloc = GetIt.instance.get<LanguageBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)
            .translate(LocalizationKeys.languageSelection),
        style: Theme.of(context).textTheme.subtitle,
      ),
      content: StreamBuilder<bool>(
        stream: _languageBloc.languageEnabled,
        builder: (context, languageSnapshot) {
          group =
              languageSnapshot.hasData ? (languageSnapshot.data ? 0 : 1) : -1;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile(
                value: 0,
                groupValue: group,
                title: Text(
                  AppLocalizations.of(context)
                      .translate(LocalizationKeys.azerbaijani),
                  style: Theme.of(context).textTheme.subtitle,
                ),
                onChanged: (value) => _languageBloc.changeLanguage(true),
                activeColor: Theme.of(context).accentColor,
              ),
              RadioListTile(
                title: Text(
                  AppLocalizations.of(context)
                      .translate(LocalizationKeys.english),
                  style: Theme.of(context).textTheme.subtitle,
                ),
                onChanged: (value) => _languageBloc.changeLanguage(false),
                groupValue: group,
                value: 1,
                activeColor: Theme.of(context).accentColor,
              ),
            ],
          );
        },
      ),
    );
  }
}
