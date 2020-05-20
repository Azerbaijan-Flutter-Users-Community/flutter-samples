import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/add_todo_bloc/add_todo_event.dart';
import 'package:todo_app/blocs/add_todo_bloc/add_todo_state.dart';
import 'package:todo_app/contractors/imple_todo_repository.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final ITodoRepository todoRepository;

  AddTodoBloc(this.todoRepository) : assert(todoRepository != null);

  @override
  AddTodoState get initialState => AddTodoInitial();

  @override
  Stream<AddTodoState> mapEventToState(AddTodoEvent event) async* {
    if (event is AddTodoRequested) {
      yield AddTodoLoading();

      final newTodo = event.todo;

      try {
        if (newTodo.title == null || newTodo.title.length < 3) {
          yield AddTodoFailure('title is not valid!');
        }

        if (newTodo.content == null || newTodo.content.length < 10) {
          yield AddTodoFailure('content is not valid!');
        }

        await todoRepository.addTodo(newTodo);
        yield AddTodoSuccess();
      } catch (e) {
        yield AddTodoFailure('Request is not valid!');
      }
    }
  }
}
