import 'package:equatable/equatable.dart';
import 'package:todo_app/data/model/todo.dart';

abstract class AddTodoEvent extends Equatable {
  const AddTodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoRequested extends AddTodoEvent {
  final Todo todo;

  AddTodoRequested(this.todo) : assert(todo != null);
}
