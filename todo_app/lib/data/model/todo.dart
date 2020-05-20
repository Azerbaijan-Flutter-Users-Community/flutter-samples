import 'package:meta/meta.dart';

class Todo {
  final int todoId;
  final String title;
  final String content;

  Todo({
    this.todoId,
    @required this.title,
    @required this.content,
  });

  Map<String, dynamic> toMap() => {
        'todoTitle': title,
        'todoContent': content,
      };

  factory Todo.fromMap(Map<dynamic, dynamic> json) => new Todo(
        todoId: json["todoId"],
        title: json["todoTitle"],
        content: json["todoContent"],
      );
}
