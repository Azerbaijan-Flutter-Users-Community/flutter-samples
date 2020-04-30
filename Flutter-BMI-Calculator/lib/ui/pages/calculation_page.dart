import 'package:bmi_calculator/constants/localization_keys.dart';
import 'package:bmi_calculator/constants/routes.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:bmi_calculator/ui/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalculationPage extends StatefulWidget {
  @override
  _CalculationPageState createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  double _value = 150.0;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildGenderRow(),
            _buildHeightWidget(),
            _buildWeightWidget(),
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: SizeConfig.heightMultiplier *
                      7 *
                      SizeConfig.textScaleFactor),
              child: FlatButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  AppLocalizations.of(context)
                      .translate(LocalizationKeys.calculate),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRow() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildGenderWidget(isSelected: false),
            SizedBox(width: SizeConfig.widthMultiplier * 2.777),
            _buildGenderWidget(isMan: true, isSelected: false),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderWidget({bool isMan = false, bool isSelected = false}) {
    String iconPath;

    if (isMan)
      iconPath = isSelected ? 'assets/male_selected.svg' : 'assets/male.svg';
    else
      iconPath =
          isSelected ? 'assets/female_selected.svg' : 'assets/female.svg';

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).unselectedWidgetColor,
          borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(iconPath),
            Text(
              AppLocalizations.of(context).translate(
                  isMan ? LocalizationKeys.male : LocalizationKeys.female),
              style: isSelected
                  ? Theme.of(context).textTheme.subtitle
                  : Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeightWidget() {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).unselectedWidgetColor,
          borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
        ),
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate(
                LocalizationKeys.height,
              ),
              style: Theme.of(context).textTheme.subtitle,
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                  text: '${_value.round()} ',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                      fontSize: SizeConfig.widthMultiplier *
                          8.888 *
                          SizeConfig.textScaleFactor),
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context).translate(
                        LocalizationKeys.cm,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .copyWith(color: Colors.grey),
                    ),
                  ]),
            ),
            Expanded(
              child: Center(
                child: Slider(
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  max: 300,
                  min: 0.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightWidget() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        child: Row(
          children: <Widget>[
            _weightItem(
                AppLocalizations.of(context).translate(LocalizationKeys.kg)),
            SizedBox(width: SizeConfig.widthMultiplier * 2.777),
            _weightItem(
                AppLocalizations.of(context).translate(LocalizationKeys.gr)),
          ],
        ),
      ),
    );
  }

  Widget _weightItem(String type) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).unselectedWidgetColor,
          borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
        ),
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate(
                LocalizationKeys.weight,
              ),
              style: Theme.of(context).textTheme.subtitle,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(
                      text: '${_value.round()}\n',
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: SizeConfig.widthMultiplier *
                                8.888 *
                                SizeConfig.textScaleFactor,
                          ),
                      children: [
                        TextSpan(
                          text: type,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(color: Colors.grey),
                        ),
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
