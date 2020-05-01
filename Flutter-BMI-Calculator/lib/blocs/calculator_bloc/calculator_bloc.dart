import 'package:bmi_calculator/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum Gender { MALE, FEMALE }

enum Invalid { HEIGHT, WEIGHT, AGE }

mixin BMIValidator {
  bool isHeightValid(double value) => value > 0 ? true : false;

  bool isWeightValid(double value) => value > 0 && value < 300 ? true : false;

  bool isAgeValid(int value) => value >= 20 ? true : false;
}

class CalculatorBloc extends BaseBloc with BMIValidator {
  CalculatorBloc() {
    _isMaleSelectedSubject.add(false);
    _heightSubject.add(_height);
    _weightSubject.add(_weight);
    _ageSubject.add(_age);
    _errorSubject.add(null);
  }

  BehaviorSubject<bool> _isMaleSelectedSubject = new BehaviorSubject<bool>();
  BehaviorSubject<double> _heightSubject = new BehaviorSubject<double>();
  BehaviorSubject<double> _weightSubject = new BehaviorSubject<double>();
  BehaviorSubject<int> _ageSubject = new BehaviorSubject<int>();
  BehaviorSubject<Invalid> _errorSubject = new BehaviorSubject<Invalid>();

  Stream<bool> get isMaleSelected => _isMaleSelectedSubject.stream;

  Stream<double> get height => _heightSubject.stream;

  Stream<double> get weight => _weightSubject.stream;

  Stream<int> get age => _ageSubject.stream;

  Stream<Invalid> get errorType => _errorSubject.stream;

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

    if (parsed == null) {
      return;
    }

    _weight = parsed;
    _weightSubject.add(parsed);
  }

  void onAgeChanged(String value) {
    int parsed = int.tryParse(value);

    if (parsed == null) {
      return;
    }

    _age = parsed;
    _ageSubject.add(parsed);
  }

  void onCalculatePressed() {
    if (!isWeightValid(_weight)) {
      _errorSubject.add(Invalid.WEIGHT);
      return;
    }

    if (!isAgeValid(_age)) {
      _errorSubject.add(Invalid.AGE);
      return;
    }

    if (!isHeightValid(_height)) {
      _errorSubject.add(Invalid.HEIGHT);
      return;
    }

    print('Height: $_height');
    print('Weight: $_weight');
    double result = _weight / ((_height / 100) * (_height / 100));
    print("BMI: ${result.round()}");
  }

  @override
  void dispose() {
    Future.wait([
      _isMaleSelectedSubject?.close(),
      _heightSubject?.close(),
      _weightSubject?.close(),
      _ageSubject?.close(),
      _errorSubject?.close(),
    ]);
  }
}
