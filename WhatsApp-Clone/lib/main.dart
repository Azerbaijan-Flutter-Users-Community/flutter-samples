import 'package:flutter/material.dart';
import './screens/home_screen.dart';

main() => runApp(WhatsApp());

class WhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25D366),
      ),
      home: HomePage(),
    );
  }
}