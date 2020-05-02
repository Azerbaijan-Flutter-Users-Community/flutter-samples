import 'package:bmi_calculator/blocs/calculator_bloc/calculator_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CalculatorState {
  const CalculatorState();
}

class Initial extends CalculatorState {}

class InvalidError extends CalculatorState {
  final Invalid invalidType;

  InvalidError(this.invalidType) : assert(invalidType != null);
}

class BMISuccess extends CalculatorState with EquatableMixin {
  final BMIResult bmiResult;

  BMISuccess(this.bmiResult) : assert(bmiResult != null);

  @override
  List<Object> get props => [bmiResult];
}
