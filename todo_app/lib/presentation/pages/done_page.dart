import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/data/model/todo.dart';
import 'package:todo_app/presentation/widgets/list_item.dart';

class DonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done page'),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: BlocProvider.of<TodoBloc>(context).dones,
        builder: (context, doneSnapshot) {
          if (doneSnapshot.hasError) {
            return Center(
              child: Text(doneSnapshot.error),
            );
          }

          if (!doneSnapshot.hasData) {
            return Center(
              child: Text('There is no element!'),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) => ListItem(
              id: 1,
              title: doneSnapshot.data[index].title,
              subtitle: doneSnapshot.data[index].content,
              isDone: true,
            ),
            itemCount: doneSnapshot.data.length,
          );
        },
      ),
    );
  }
}
