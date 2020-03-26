import 'package:flutter/material.dart';
import 'package:learn_structure/core/constants/routes.dart';
import 'package:learn_structure/core/models/post.dart';
import 'package:learn_structure/ui/views/home_view.dart';
import 'package:learn_structure/ui/views/login_view.dart';
import 'package:learn_structure/ui/views/post_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.Post:
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
