import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/model/todo.dart';

class DatabaseService {
  DatabaseService._();

  final String tableTodo = 'Todo';
  final String todoId = 'todoId';
  final String todoTitle = 'todoTitle';
  final String todoContent = 'todoContent';

  final String tableDone = 'Done';
  final String doneId = 'todoId';
  final String doneTitle = 'doneTitle';
  final String doneContent = 'doneContent';

  static Database database;
  static DatabaseService databaseService = new DatabaseService._();

  Future<Database> get databaseGetter async {
    if (database != null) return database;

    database = await _initDatabase();
    return database;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "Todo.db";
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableTodo (
          $todoId integer primary key autoincrement,
          $todoTitle text not null,
          $todoContent text not null)
          ''');

      await db.execute('''
          create table $tableDone (
          $doneId integer primary key autoincrement,
          $todoTitle text not null,
          $todoContent text not null)
          ''');
    });
  }

  Future<Todo> getTodo(int todoId) async {
    final db = await databaseGetter;
    var result =
        await db.query(tableTodo, where: "todoId = ?", whereArgs: [todoId]);
    return result.isNotEmpty ? Todo.fromMap(result.first) : Null;
  }

  Future<void> deleteTodo(int todoId) async {
    final db = await databaseGetter;
    db.delete(tableTodo, where: "todoId = ?", whereArgs: [todoId]);
  }

  Future<int> insertTodo(Todo newTodo) async {
    final db = await databaseGetter;
    final int newTodoId = await db.insert(tableTodo, newTodo.toMap());
    return newTodoId;
  }

  Future<int> insertDone(Todo newDone) async {
    final db = await databaseGetter;
    final int newDoneId = await db.insert(tableDone, newDone.toMap());
    return newDoneId;
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await databaseGetter;
    var result = await db.query(tableTodo);
    List<Todo> todos = result.isNotEmpty
        ? result.map((todo) => Todo.fromMap(todo)).toList()
        : [];
    return todos;
  }

  Future<List<Todo>> getAllDone() async {
    final db = await databaseGetter;
    var result = await db.query(tableDone);
    List<Todo> dones = result.isNotEmpty
        ? result.map((done) => Todo.fromMap(done)).toList()
        : [];
    return dones;
  }
}
