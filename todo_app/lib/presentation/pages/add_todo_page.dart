import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/add_todo_bloc/add_todo_bloc.dart';
import 'package:todo_app/blocs/add_todo_bloc/add_todo_event.dart';
import 'package:todo_app/blocs/add_todo_bloc/add_todo_state.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_event.dart';
import 'package:todo_app/data/model/todo.dart';

class AddTodoPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo Page'),
      ),
      body: BlocConsumer<AddTodoBloc, AddTodoState>(
        listener: (context, addTodoState) {
          if (addTodoState is AddTodoSuccess) {
            BlocProvider.of<TodoBloc>(context).add(TodoDataRequested());
            Navigator.of(context).pop();
          }
        },
        builder: (context, addTodoState) {
          if (addTodoState is AddTodoLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (addTodoState is AddTodoFailure) {
            return Center(
              child: Text(addTodoState.message),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Title',
                    ),
                    maxLines: 1,
                    maxLength: 30,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Content',
                    ),
                    maxLines: null,
                    maxLength: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RaisedButton(
                      onPressed: () {
                        BlocProvider.of<AddTodoBloc>(context).add(
                          AddTodoRequested(
                            Todo(
                              title: _titleController.text,
                              content: _contentController.text,
                            ),
                          ),
                        );
                      },
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
