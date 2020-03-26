import 'package:flutter/material.dart';
import 'package:learn_structure/core/constants/routes.dart';
import 'package:learn_structure/ui/router.dart';
import 'package:provider/provider.dart';
import 'package:learn_structure/provider_setup.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: Routes.Login,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
