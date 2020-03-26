import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: FlutterLogo(
                style: FlutterLogoStyle.stacked,
                duration: const Duration(
                  seconds: 2,
                ),
                curve: Curves.bounceInOut,
              ),
            ),
          ),
          Spacer(),
          Text(
            'Poster',
            style: Theme.of(context).textTheme.display2,
          ),
          Text(
            'make your post',
            style: Theme.of(context).textTheme.display1,
          ),
          Spacer(),
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
