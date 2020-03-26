import 'package:flutter/material.dart';
import 'package:learn_bloc_pattern/bloc_layer/bloc_provider.dart';
import 'package:learn_bloc_pattern/bloc_layer/blocs/hit_bloc.dart';
import 'package:learn_bloc_pattern/data_layer/repository/hit_repository.dart';
import 'package:learn_bloc_pattern/data_layer/services/api_service.dart';
import 'package:learn_bloc_pattern/ui_layer/router.dart';

import 'constants/app_constants.dart';

void main() => runApp(BlocProvider(
      bloc: HitBloc(hitRepository: HitRepository(apiService: ApiService())),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matrix Workshop app',
      theme: ThemeData(
        accentColor: Colors.amber,
        brightness: Brightness.dark,
      ),
      initialRoute: Routes.HOME,
      onGenerateRoute: Router.onGenerateRoute,
    );
  }
}
