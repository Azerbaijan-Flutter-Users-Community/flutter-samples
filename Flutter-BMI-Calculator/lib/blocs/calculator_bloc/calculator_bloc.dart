import 'dart:async';

import 'package:bmi_calculator/blocs/calculator_bloc/calculator_event.dart';
import 'package:bmi_calculator/blocs/calculator_bloc/calculator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Gender { MALE, FEMALE }

enum Invalid { HEIGHT, WEIGHT, AGE }

enum BMI { UNDERWEIGHT, NORMAL, OVERWEIGHT, OBESE }

class BMIResult {
  final BMI bmi;
  final String result;

  BMIResult({
    this.bmi,
    this.result,
  });
}

mixin BMIValidator {
  bool isHeightValid(double value) => value != null || value > 0;

  bool isWeightValid(double value) =>
      value != null &&
      !value.toString().contains('..') &&
      (value > 1 && value <= 300);

  bool isAgeValid(int value) => value != null && value > 20;
}

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState>
    with BMIValidator {
  CalculatorBloc() {
    weight.listen((weight) {
      print('weight: working');
      if (!isWeightValid(weight)) add(InvalidErrorHappened(Invalid.WEIGHT));
      _calculateButtonEnabledSubject.add(isAllValid());
    });

    height.listen((height) {
      print('height: working');
      if (!isHeightValid(height)) add(InvalidErrorHappened(Invalid.HEIGHT));
      _calculateButtonEnabledSubject.add(isAllValid());
    });

    age.listen((age) {
      print('age: working');
      if (!isAgeValid(age)) add(InvalidErrorHappened(Invalid.AGE));
      _calculateButtonEnabledSubject.add(isAllValid());
    });
  }

  StreamController<bool> _isMaleSelectedSubject =
      new StreamController<bool>.broadcast();
  StreamController<double> _heightSubject =
      new StreamController<double>.broadcast();
  StreamController<double> _weightSubject =
      new StreamController<double>.broadcast();
  StreamController<int> _ageSubject = new StreamController<int>.broadcast();
  StreamController<bool> _calculateButtonEnabledSubject =
      new StreamController<bool>.broadcast();

  Stream<bool> get isMaleSelected => _isMaleSelectedSubject.stream;

  Stream<double> get height => _heightSubject.stream;

  Stream<double> get weight => _weightSubject.stream;

  Stream<int> get age => _ageSubject.stream;

  Stream<bool> get isCalculateButtonEnabled =>
      _calculateButtonEnabledSubject.stream;

  double _height = 0.0;
  double _weight = 0.0;
  int _age = 0;

  void onGenderSelected(Gender type) {
    if (type == Gender.FEMALE) {
      _isMaleSelectedSubject.add(false);
    } else {
      _isMaleSelectedSubject.add(true);
    }
  }

  void onHeightChanged(double value) {
    _height = value.round().toDouble();
    _heightSubject.add(value);
  }

  void onWeightChanged(String value) {
    double parsed = double.tryParse(value);

    _weight = parsed;
    _weightSubject.add(parsed);
  }

  void onAgeChanged(String value) {
    int parsed = int.tryParse(value);
    _age = parsed;
    _ageSubject.add(parsed);
  }

  @override
  CalculatorState get initialState => Initial();

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    if (event is CalculateButtonPressed) {
      double result = _weight / ((_height / 100) * (_height / 100));
      String finalResult = result.toStringAsFixed(2);

      BMIResult bmiResult;
      if (result < 18.5) {
        bmiResult = BMIResult(result: finalResult, bmi: BMI.UNDERWEIGHT);
      } else if (result >= 18.5 && result <= 24.9) {
        bmiResult = BMIResult(result: finalResult, bmi: BMI.NORMAL);
      } else if (result >= 25.0 && result <= 29.9) {
        bmiResult = BMIResult(result: finalResult, bmi: BMI.OVERWEIGHT);
      } else {
        bmiResult = BMIResult(result: finalResult, bmi: BMI.OBESE);
      }

      yield BMISuccess(bmiResult);
    } else if (event is InvalidErrorHappened) {
      yield InvalidError(event.invalid);
    }
  }

  bool isAllValid() =>
      isWeightValid(_weight) && isAgeValid(_age) && isHeightValid(_height);

  @override
  Future<void> close() {
    Future.wait([
      _isMaleSelectedSubject?.close(),
      _heightSubject?.close(),
      _weightSubject?.close(),
      _ageSubject?.close(),
      _calculateButtonEnabledSubject?.close(),
    ]);
    return super.close();
  }
}
