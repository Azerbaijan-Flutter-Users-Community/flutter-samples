import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/add_todo_bloc/add_todo_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo_app/blocs/todo_bloc/todo_event.dart';
import 'package:todo_app/data/repository/todo_repository.dart';
import 'package:todo_app/presentation/pages/add_todo_page.dart';
import 'package:todo_app/presentation/pages/done_page.dart';
import 'package:todo_app/presentation/pages/todo_page.dart';
import 'package:todo_app/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => TodoRepository(),
      child: BlocProvider(
        create: (context) =>
            TodoBloc(RepositoryProvider.of<TodoRepository>(context)),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: TodoPage(),
          onGenerateRoute: (routeSettings) {
            switch (routeSettings.name) {
              case Routes.addTodoPage:
                return MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => AddTodoBloc(
                      RepositoryProvider.of<TodoRepository>(context),
                    ),
                    child: AddTodoPage(),
                  ),
                );
              case Routes.donePage:
                return MaterialPageRoute(
                  builder: (_) => DonePage(),
                );
              default:
                return MaterialPageRoute(
                  builder: (_) => Scaffold(
                    body: Center(
                      child: Text('Page doesn\'t exist!'),
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
