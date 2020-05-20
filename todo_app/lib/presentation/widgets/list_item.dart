import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_event.dart';

class ListItem extends StatelessWidget {
  final int id;
  final String title;
  final String subtitle;
  final bool isDone;

  ListItem({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    this.isDone = false,
  }) : assert(title != null && subtitle != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(Icons.playlist_add_check),
      trailing: isDone
          ? null
          : IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(MarkAsDone(id));
              },
            ),
    );
  }
}
