import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './ui/location_query_screen.dart';
import 'bloc/bloc.dart';
import 'ui/locations_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) => LocationBloc(),
      child: MaterialApp(
        title: 'Restaurant Finder',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: LocationQueryScreen(),
        routes: {
          LocationsScreen.routeName: (context) => LocationsScreen(),
        },
      ),
    );
  }
}
