import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_event.dart';
import 'package:todo_app/blocs/todo_state.dart';
import 'package:todo_app/presentation/widgets/list_item.dart';
import 'package:todo_app/utils/routes.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoBloc>(context).add(TodoDataRequested());

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done_outline),
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(DoneDataRequested());
              Navigator.of(context).pushNamed(Routes.donePage);
            },
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, todoState) {
          if (todoState is TodoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (todoState is TodoDataFailure) {
            return Center(
              child: Text('Failed'),
            );
          }

          if (todoState is TodoDataSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) => ListItem(
                id: todoState.todos[index].todoId,
                title: todoState.todos[index].title,
                subtitle: todoState.todos[index].content,
              ),
              itemCount: todoState.todos.length,
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.addTodoPage);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
