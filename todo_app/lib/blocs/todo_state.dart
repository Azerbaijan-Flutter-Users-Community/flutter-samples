import 'package:equatable/equatable.dart';
import 'package:todo_app/data/model/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoDataSuccess extends TodoState {
  final List<Todo> todos;

  TodoDataSuccess(this.todos) : assert(todos != null);

  @override
  List<Object> get props => [...todos];
}

class TodoDataFailure extends TodoState {}
