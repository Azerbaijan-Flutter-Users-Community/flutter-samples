import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoDataRequested extends TodoEvent {}

class DoneDataRequested extends TodoEvent {}

class MarkAsDone extends TodoEvent {
  final int todoId;

  MarkAsDone(this.todoId) : assert(todoId != null);

  @override
  List<Object> get props => [todoId];
}
