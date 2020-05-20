import 'package:todo_app/contractors/imple_todo_repository.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/data/service/database_service.dart';

class TodoRepository implements ITodoRepository {
  final db = DatabaseService.databaseService;

  @override
  Future<List<Todo>> getAllDones() async {
    final List<Todo> dones = await db.getAllDone();
    return dones.reversed.toList();
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    final List<Todo> todos = await db.getAllTodos();
    return todos;
  }

  @override
  Future<void> makeTodoDone(int todoId) async {
    final Todo currentTodo = await db.getTodo(todoId);
    await db.deleteTodo(todoId);
    await db.insertDone(currentTodo);
  }

  @override
  Future<int> addTodo(Todo newTodo) async {
    final result = await db.insertTodo(newTodo);
    return result;
  }
}
