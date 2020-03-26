import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_bloc_pattern/constants/app_constants.dart';
import 'package:learn_bloc_pattern/ui_layer/pages/detail_screen.dart';
import 'package:learn_bloc_pattern/ui_layer/pages/home_screen.dart';


class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.DETAIL:
        final hit = settings.arguments;
        return MaterialPageRoute(builder: (context) => DetailScreen(currentHit: hit,));
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text('Does not exist!: ${settings.name}'),
              ),
            ));
    }
  }
}
