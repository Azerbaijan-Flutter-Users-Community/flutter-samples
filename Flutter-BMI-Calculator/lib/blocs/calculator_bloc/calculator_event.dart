import 'package:bmi_calculator/blocs/calculator_bloc/calculator_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CalculatorEvent {
  const CalculatorEvent();
}

class CalculateButtonPressed extends CalculatorEvent {}

class InvalidErrorHappened extends CalculatorEvent {
  final Invalid invalid;

  InvalidErrorHappened(this.invalid) : assert(invalid != null);
}
