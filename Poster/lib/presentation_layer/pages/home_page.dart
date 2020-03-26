import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/bloc_layer/authentication_bloc/authentication_bloc.dart';
import 'package:poster/data_layer/models/Post.dart';
import 'package:poster/data_layer/repositories/post_repository.dart';
import 'package:poster/data_layer/repositories/shared_pref_repository.dart';
import 'package:poster/presentation_layer/widgets/theme_changer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          ThemeChanger(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Success :)',
              style: TextStyle(
                fontSize: 60,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Sign Out'),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
