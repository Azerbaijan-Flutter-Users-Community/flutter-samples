import 'package:flutter/material.dart';
import './screens/images_list_screen.dart';
import 'package:provider/provider.dart';
import './providers/hits_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HitsProvider(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black87
      ),
      home: ImagesListScreen(),
    ),
    );
  }
}
