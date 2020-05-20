import 'package:equatable/equatable.dart';

abstract class AddTodoState extends Equatable {
  const AddTodoState();

  @override
  List<Object> get props => [];
}

class AddTodoInitial extends AddTodoState {}

class AddTodoSuccess extends AddTodoState {}

class AddTodoFailure extends AddTodoState {
  final String message;

  AddTodoFailure(this.message) : assert(message != null);

  @override
  List<Object> get props => [message];
}

class AddTodoLoading extends AddTodoState {}
