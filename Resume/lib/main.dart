import 'package:flutter/material.dart';
import 'package:resume/profile_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
      ),
      home: ProfilePage(),
    );
  }
}
