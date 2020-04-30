import 'package:bmi_calculator/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum Gender { MALE, FEMALE }

mixin BMIValidator {}

class CalculatorBloc extends BaseBloc with BMIValidator {
  CalculatorBloc() {
    _isMaleSelectedSubject.add(false);
    _heightSubject.add(_height);
    _weightKgSubject.add(_weightKg);
    _weightGrSubject.add(_weightGr);
  }

  BehaviorSubject<bool> _isMaleSelectedSubject = new BehaviorSubject<bool>();
  BehaviorSubject<double> _heightSubject = new BehaviorSubject<double>();
  BehaviorSubject<double> _weightKgSubject = new BehaviorSubject<double>();
  BehaviorSubject<double> _weightGrSubject = new BehaviorSubject<double>();

  Stream<bool> get isMaleSelected => _isMaleSelectedSubject.stream;

  Stream<double> get height => _heightSubject.stream;

  Stream<double> get weightKg => _weightKgSubject.stream;

  Stream<double> get weightGr => _weightGrSubject.stream;

  double _height = 0.0;
  double _weightKg = 0.0;
  double _weightGr = 0.0;

  void onGenderSelected(Gender type) {
    if (type == Gender.FEMALE) {
      _isMaleSelectedSubject.add(false);
    } else {
      _isMaleSelectedSubject.add(true);
    }
  }

  void onHeightChanged(double value) {
    _height = value;
    _heightSubject.add(value);
  }

  void onWeightKgChanged(double value) {
    _weightKg = value;
    _weightKgSubject.add(value);
  }

  void onWeightGrChanged(double value) {
    _weightGr = value;
    _weightGrSubject.add(value);
  }

  void onCalculatePressed() {
    // TODO: add business logic of BMI calculation
  }

  @override
  void dispose() {
    Future.wait([
      _isMaleSelectedSubject?.close(),
      _heightSubject?.close(),
      _weightKgSubject?.close(),
      _weightGrSubject?.close(),
    ]);
  }
}
