import 'package:bmi_calculator/constants/routes.dart';
import 'package:bmi_calculator/ui/pages/calculation_page.dart';
import 'package:bmi_calculator/ui/pages/settings_page.dart';
import 'package:bmi_calculator/ui/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case calculator:
      return MaterialPageRoute(
        builder: (_) => CalculationPage(),
      );
    case settings:
      return MaterialPageRoute(
        builder: (_) => SettingsPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(),
      );
      break;
  }
}
