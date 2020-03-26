import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/bloc_layer/register_bloc/register_bloc.dart';
import 'package:poster/constants/routes.dart';
import 'package:poster/data_layer/repositories/user_repository.dart';
import 'package:poster/presentation_layer/pages/login_page.dart';
import 'package:poster/presentation_layer/pages/register_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Routes.LOGIN:
      return MaterialPageRoute(
        builder: (_) => LoginPage(),
      );
      break;
    case Routes.HOME:
      return MaterialPageRoute(
        builder: (_) => null,
      );
      break;
    case Routes.CREATE_ACCOUNT:
      return MaterialPageRoute(
        builder: (_) => BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                ),
            child: RegisterPage()),
      );
      break;
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('This page doesn\'t exist!'),
          ),
        ),
      );
      break;
  }
}
