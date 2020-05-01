import 'dart:async';

import 'package:bmi_calculator/constants/routes.dart';
import 'package:bmi_calculator/ui/size_config.dart';
import 'package:flutter/material.dart';

import '../../constants/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _startTime() async {
    var duration = new Duration(milliseconds: 2000);
    return new Timer(duration, _navigateToNextPage);
  }

  void _navigateToNextPage() {
    Navigator.of(context).pushReplacementNamed(calculator);
  }

  @override
  void initState() {
    _startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation, context);

            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TweenAnimationBuilder(
                        curve: Curves.easeInOutBack,
                        tween: Tween<Offset>(
                          begin: Offset(SizeConfig.screenWidth, 0),
                          end: Offset(0, 0),
                        ),
                        duration: Duration(
                          milliseconds: 1000,
                        ),
                        builder: (context, offset, widget) {
                          return Transform.translate(
                            offset: offset,
                            child: Text(
                              'BMI',
                              style: Theme.of(context).textTheme.title,
                            ),
                          );
                        }),
                    TweenAnimationBuilder(
                        curve: Curves.easeInOutBack,
                        tween: Tween<Offset>(
                          begin: Offset(-SizeConfig.screenWidth, 0),
                          end: Offset(0, 0),
                        ),
                        duration: Duration(
                          milliseconds: 1000,
                        ),
                        builder: (context, offset, widget) {
                          return Transform.translate(
                            offset: offset,
                            child: Text(
                              'Calculator',
                              style: Theme.of(context).textTheme.headline,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
