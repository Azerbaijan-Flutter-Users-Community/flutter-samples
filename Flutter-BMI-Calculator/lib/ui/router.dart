import 'package:bmi_calculator/constants/routes.dart';
import 'package:bmi_calculator/ui/pages/calculation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case calculator:
      return MaterialPageRoute(
        builder: (context) => CalculationPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(),
      );
      break;
  }
}
