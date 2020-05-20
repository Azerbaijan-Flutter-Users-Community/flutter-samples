import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_event.dart';
import 'package:todo_app/blocs/todo_state.dart';
import 'package:todo_app/contractors/imple_todo_repository.dart';
import 'package:todo_app/data/model/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this.todoRepository) : assert(todoRepository != null);

  final ITodoRepository todoRepository;
  final StreamController<List<Todo>> _donesController =
      new StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get dones => _donesController.stream;

  @override
  TodoState get initialState => TodoInitial();

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoDataRequested) {
      yield* _todoDataRequested();
    } else if (event is DoneDataRequested) {
      await _doneDataRequested();
    } else if (event is MarkAsDone) {
      await todoRepository.makeTodoDone(event.todoId);
      yield* _todoDataRequested();
      _doneDataRequested();
    }
  }

  Stream<TodoState> _todoDataRequested() async* {
    yield TodoLoading();
    try {
      final todos = await todoRepository.getAllTodos();
      yield TodoDataSuccess(todos);
    } catch (e) {
      yield TodoDataFailure();
    }
  }

  Future<void> _doneDataRequested() async {
    try {
      final dones = await todoRepository.getAllDones();
      _donesController.add(dones);
    } catch (_) {
      _donesController.addError('Error occured!');
    }
  }

  @override
  Future<void> close() {
    _donesController?.close();
    return super.close();
  }
}
