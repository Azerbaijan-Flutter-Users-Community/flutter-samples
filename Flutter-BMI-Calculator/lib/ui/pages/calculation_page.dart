import 'dart:async';

import 'package:bmi_calculator/blocs/calculator_bloc/calculator_bloc.dart';
import 'package:bmi_calculator/blocs/calculator_bloc/calculator_event.dart';
import 'package:bmi_calculator/blocs/calculator_bloc/calculator_state.dart';
import 'package:bmi_calculator/constants/localization_keys.dart';
import 'package:bmi_calculator/constants/routes.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:bmi_calculator/ui/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class CalculationPage extends StatefulWidget {
  @override
  _CalculationPageState createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  CalculatorBloc _calculatorBloc;
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  StreamSubscription _errorTypeSubscription;
  StreamSubscription _resultSubscription;

  @override
  void initState() {
    super.initState();

    _calculatorBloc = new CalculatorBloc();
    // send weight to bloc
    _weightController.addListener(() {
      _calculatorBloc.onWeightChanged(_weightController.text);
    });

    // send age to bloc
    _ageController.addListener(() {
      _calculatorBloc.onAgeChanged(_ageController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _calculatorBloc,
      listener: (context, calculatorState) {
        if (calculatorState is InvalidError) {
          String message;

          Invalid errorType = calculatorState.invalidType;

          if (errorType == Invalid.HEIGHT) {
            message = AppLocalizations.of(context)
                .translate(LocalizationKeys.invalid_height);
          } else if (errorType == Invalid.WEIGHT) {
            message = AppLocalizations.of(context)
                .translate(LocalizationKeys.invalid_weight);
          } else if (errorType == Invalid.AGE) {
            message = AppLocalizations.of(context)
                .translate(LocalizationKeys.invalid_age);
          }

          Toast.show(
            message,
            context,
            backgroundColor: Theme.of(context).cardColor,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.CENTER,
          );
        } else if (calculatorState is BMISuccess) {
          FocusScope.of(context).unfocus();

          final resultType = calculatorState.bmiResult.bmi;
          String value = calculatorState.bmiResult.result;
          String resultMessage;

          if (resultType == BMI.UNDERWEIGHT) {
            resultMessage = AppLocalizations.of(context)
                .translate(LocalizationKeys.underweight);
          } else if (resultType == BMI.NORMAL) {
            resultMessage =
                AppLocalizations.of(context).translate(LocalizationKeys.normal);
          } else if (resultType == BMI.OVERWEIGHT) {
            resultMessage = AppLocalizations.of(context)
                .translate(LocalizationKeys.overweight);
          } else if (resultType == BMI.OBESE) {
            resultMessage =
                AppLocalizations.of(context).translate(LocalizationKeys.obese);
          }

          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    titleTextStyle: Theme.of(context).textTheme.subtitle,
                    title: Text(
                      AppLocalizations.of(context)
                          .translate(LocalizationKeys.result),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                            '${AppLocalizations.of(context).translate(LocalizationKeys.your_bmi_value)}: $value'),
                        Text(resultMessage),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(AppLocalizations.of(context)
                            .translate(LocalizationKeys.cancel)),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)
                .translate(LocalizationKeys.bmiCalculator),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pushNamed(settings);
              },
            ),
          ],
        ),
        body: SafeArea(
          bottom: false,
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
                      _buildWeightAndAgeRow(),
                      StreamBuilder<double>(
                        stream: _calculatorBloc.height,
                        builder: (context, heightSnapshot) {
                          return _buildHeightWidget(heightSnapshot.data ?? 0);
                        },
                      ),
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
                  child: StreamBuilder<bool>(
                    stream: _calculatorBloc.isCalculateButtonEnabled,
                    builder: (context, isEnabledSnapshot) {
                      return FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        color: Theme.of(context).accentColor,
                        disabledColor:
                            Theme.of(context).highlightColor.withOpacity(1.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate(LocalizationKeys.calculate),
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: isEnabledSnapshot.hasData
                            ? (isEnabledSnapshot.data
                                ? () => _calculatorBloc
                                    .add(CalculateButtonPressed())
                                : null)
                            : null,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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
      iconPath = isSelected ? 'assets/male_selected.png' : 'assets/male.png';
    else
      iconPath =
          isSelected ? 'assets/female_selected.png' : 'assets/female.png';

    return Expanded(
      child: GestureDetector(
        onTap: () => _calculatorBloc
            .onGenderSelected(isMan ? Gender.MALE : Gender.FEMALE),
        child: Container(
          height: SizeConfig.heightMultiplier * 25 * SizeConfig.textScaleFactor,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                iconPath,
                height: SizeConfig.heightMultiplier * 16,
              ),
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
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: SizeConfig.heightMultiplier * 11 * SizeConfig.textScaleFactor,
      ),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
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
                onChanged: (value) => _calculatorBloc.onHeightChanged(value),
                max: 300,
                min: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightAndAgeRow() {
    return Container(
      height: SizeConfig.heightMultiplier * 25 * SizeConfig.textScaleFactor,
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
      ),
      child: Row(
        children: <Widget>[
          StreamBuilder<double>(
            stream: _calculatorBloc.weight,
            builder: (context, weightKgSnapshot) {
              return _item(
                  AppLocalizations.of(context)
                      .translate(LocalizationKeys.weight),
                  AppLocalizations.of(context).translate(LocalizationKeys.kg),
                  weightKgSnapshot.data ?? 0);
            },
          ),
          SizedBox(width: SizeConfig.widthMultiplier * 2.777),
          StreamBuilder<double>(
            stream: _calculatorBloc.weight,
            builder: (context, weightGrSnapshot) {
              return _item(
                  AppLocalizations.of(context).translate(LocalizationKeys.age),
                  AppLocalizations.of(context)
                      .translate(LocalizationKeys.years_old),
                  weightGrSnapshot.data ?? 0,
                  true);
            },
          ),
        ],
      ),
    );
  }

  Widget _item(String type, String subtitle, double value,
      [bool isAge = false]) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(type, style: Theme.of(context).textTheme.subtitle),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Spacer(),
                Expanded(
                    child: TextField(
                  controller: isAge ? _ageController : _weightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  autofocus: false,
                  inputFormatters: [
                    new WhitelistingTextInputFormatter(
                      isAge
                          ? new RegExp('[0123456789]')
                          : new RegExp('[0123456789.]'),
                    ),
                  ],
                  textInputAction: TextInputAction.done,
                )),
                Spacer(),
              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            Text(subtitle),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageController?.dispose();
    _weightController?.dispose();
    _errorTypeSubscription?.cancel();
    _resultSubscription?.cancel();
    super.dispose();
  }
}
