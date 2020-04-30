import 'package:bmi_calculator/blocs/calculator_bloc/calculator_bloc.dart';
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
  CalculatorBloc _calculatorBloc;

  @override
  void initState() {
    _calculatorBloc = new CalculatorBloc();
    super.initState();
  }

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
        child: Stack(
          children: <Widget>[
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    StreamBuilder<bool>(
                      stream: _calculatorBloc.isMaleSelected,
                      builder: (context, genderSnapshot) {
                        return _buildGenderRow(genderSnapshot.data ?? false);
                      },
                    ),
                    StreamBuilder<double>(
                      stream: _calculatorBloc.height,
                      builder: (context, heightSnapshot) {
                        return _buildHeightWidget(heightSnapshot.data ?? 0);
                      },
                    ),
                    _buildWeightWidget(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRow(bool isManSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildGenderWidget(isMan: false, isSelected: !isManSelected),
          SizedBox(width: SizeConfig.widthMultiplier * 2.777),
          _buildGenderWidget(isMan: true, isSelected: isManSelected),
        ],
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
      child: GestureDetector(
        onTap: () => _calculatorBloc
            .onGenderSelected(isMan ? Gender.MALE : Gender.FEMALE),
        child: Container(
          height: SizeConfig.heightMultiplier * 25 * SizeConfig.textScaleFactor,
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
      ),
    );
  }

  Widget _buildHeightWidget(double value) {
    return Container(
      width: double.infinity,
      height: SizeConfig.heightMultiplier * 25 * SizeConfig.textScaleFactor,
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
                text: '${value.round()} ',
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
                value: value,
                onChanged: (value) {
                  _calculatorBloc.onHeightChanged(value);
                  _calculatorBloc.onWeightGrChanged(value);
                  _calculatorBloc.onWeightKgChanged(value);
                },
                max: 300,
                min: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightWidget() {
    return Container(
      height: SizeConfig.heightMultiplier * 25 * SizeConfig.textScaleFactor,
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: SizeConfig.heightMultiplier * 11 * SizeConfig.textScaleFactor,
      ),
      child: Row(
        children: <Widget>[
          StreamBuilder<double>(
            stream: _calculatorBloc.weightKg,
            builder: (context, weightKgSnapshot) {
              return _weightItem(
                  AppLocalizations.of(context).translate(LocalizationKeys.kg),
                  weightKgSnapshot.data ?? 0);
            },
          ),
          SizedBox(width: SizeConfig.widthMultiplier * 2.777),
          StreamBuilder<double>(
            stream: _calculatorBloc.weightGr,
            builder: (context, weightGrSnapshot) {
              return _weightItem(
                  AppLocalizations.of(context).translate(LocalizationKeys.gr),
                  weightGrSnapshot.data ?? 0);
            },
          ),
        ],
      ),
    );
  }

  Widget _weightItem(String type, double value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).unselectedWidgetColor,
          borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Row(
              children: <Widget>[
                Spacer(),
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.number,
                )),
                Spacer(),
              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            Text(type),
          ],
        ),
      ),
    );
  }
}
