import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/constants/localization_keys.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CalculationPage extends StatefulWidget {
  @override
  _CalculationPageState createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  LanguageBloc languageBloc;
  bool isEnabled = false;

  @override
  void initState() {
    languageBloc = GetIt.instance.get<LanguageBloc>();

    languageBloc.currentLocale.listen((locale) {
      print('curent: ${locale.languageCode}');
    });

    languageBloc.languageEnabled.listen((isEnabled) {
      print('isEnabled: $isEnabled');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context)
                  .translate(LocalizationKeys.calculator_page)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isEnabled = !isEnabled;
          languageBloc.changeLanguage(isEnabled);
        },
        child: Icon(Icons.view_stream),
      ),
    );
  }

  @override
  void dispose() {
    languageBloc.dispose();
    super.dispose();
  }
}
