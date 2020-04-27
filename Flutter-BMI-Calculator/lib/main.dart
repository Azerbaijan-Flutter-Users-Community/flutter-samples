import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:bmi_calculator/locator.dart';
import 'package:bmi_calculator/ui/pages/splash_page.dart';
import 'package:bmi_calculator/ui/router.dart';
import 'package:bmi_calculator/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.deepPurple,

      // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.deepPurple,
      systemNavigationBarDividerColor: Colors.white,
      // bar icons' color
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  initLocator();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LanguageBloc languageBloc;

  @override
  void initState() {
    languageBloc = GetIt.instance.get<LanguageBloc>();
    languageBloc.loadDefaultLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
        stream: languageBloc.currentLocale,
        builder: (context, currentLocaleSnapshot) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.deepPurple,
              primaryColorDark: Colors.deepPurple,
              accentColor: Colors.black54,
              highlightColor: Colors.white,
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.deepPurple,
              primaryColorDark: Colors.deepPurple,
              accentColor: Colors.deepPurpleAccent,
              highlightColor: Colors.white,
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.purple,
                  fontSize: 16,
                ),
              ),
            ),
            title: 'Flutter BMI Calculator',
            locale: currentLocaleSnapshot.data,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('az', 'AZ'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            home: LayoutBuilder(builder: (context, constraints) {
              return OrientationBuilder(builder: (context, orientation) {
                SizeConfig().init(constraints, orientation, context);
                return SplashPage();
              });
            }),
            onGenerateRoute: onGenerateRoute,
          );
        });
  }

  @override
  void dispose() {
    languageBloc.dispose();
    super.dispose();
  }
}
