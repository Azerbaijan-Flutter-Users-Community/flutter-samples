import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/constants/localization_keys.dart';
import 'package:bmi_calculator/constants/routes.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:bmi_calculator/ui/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class CalculationPage extends StatefulWidget {
  @override
  _CalculationPageState createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)
              .translate(LocalizationKeys.bmiCalculator),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(settings),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(AppLocalizations.of(context)
                    .translate(LocalizationKeys.gender)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _gender(isSelected: true),
                    SizedBox(width: SizeConfig.widthMultiplier * 2.777),
                    _gender(isMan: true, isSelected: false),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gender({bool isMan = false, bool isSelected = false}) {
    String iconPath;

    if (isMan)
      iconPath = isSelected ? 'assets/male_selected.svg' : 'assets/male.svg';
    else
      iconPath =
          isSelected ? 'assets/female_selected.svg' : 'assets/female.svg';

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).focusColor
            : Theme.of(context).unselectedWidgetColor,
        border: Border.all(
          color: isSelected ? Colors.deepPurple : Colors.transparent,
          width: SizeConfig.widthMultiplier * 0.7,
        ),
        borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 7.777),
      ),
      height: SizeConfig.widthMultiplier * 33.333,
      width: SizeConfig.widthMultiplier * 33.333 * SizeConfig.textScaleFactor,
      child: Center(
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
