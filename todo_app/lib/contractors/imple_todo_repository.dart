import 'package:todo_app/data/model/todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getAllTodos();

  Future<List<Todo>> getAllDones();

  Future<void> makeTodoDone(int todoId);

  Future<int> addTodo(Todo newTodo);
}
