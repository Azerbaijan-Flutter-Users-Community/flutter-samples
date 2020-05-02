import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/blocs/theme_bloc/theme_bloc.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:bmi_calculator/locator.dart';
import 'package:bmi_calculator/ui/pages/splash_page.dart';
import 'package:bmi_calculator/ui/router.dart';
import 'package:bmi_calculator/ui/shared/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  initLocator();

  LanguageBloc _languageBloc = GetIt.instance.get<LanguageBloc>();
  ThemeBloc _themeBloc = GetIt.instance.get<ThemeBloc>();
  _languageBloc?.loadDefaultLocale();
  _themeBloc?.loadDefaultTheme();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LanguageBloc _languageBloc;
  ThemeBloc _themeBloc;

  @override
  void initState() {
    _languageBloc = GetIt.instance.get<LanguageBloc>();
    _themeBloc = GetIt.instance.get<ThemeBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
        stream: _languageBloc.currentLocale,
        builder: (context, currentLocaleSnapshot) {
          return StreamBuilder<ThemeMode>(
            stream: _themeBloc.currentThemeMode,
            builder: (context, themeSnapshot) {
              return MaterialApp(
                themeMode: themeSnapshot.data,
                darkTheme: ThemeData(
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  }),
                  brightness: Brightness.dark,
                  accentColor: Colors.pinkAccent,
                  primaryColor: Colors.black45,
                  primaryColorDark: Colors.black45,
                  primaryColorLight: Colors.black45,
                  disabledColor: Colors.grey,
                  appBarTheme: AppBarTheme(brightness: Brightness.dark),
                  textTheme: TextTheme(
                    title: GoogleFonts.roboto(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    headline: GoogleFonts.roboto(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    body1: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    body2: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  unselectedWidgetColor:
                      AppColors.unselectedDarkGenderBackground,
                  focusColor: AppColors.selectedGenderBackground,
                  hintColor: Colors.white,
                  dividerColor: Colors.grey,
                  sliderTheme: SliderThemeData(
                    activeTrackColor: Colors.pinkAccent,
                    activeTickMarkColor: Colors.pink,
                    disabledThumbColor: Colors.pink,
                    thumbColor: Colors.pink,
                    inactiveTrackColor: Colors.white,
                    overlayColor: Colors.pinkAccent.withOpacity(0.3),
                  ),
                  cursorColor: Colors.pinkAccent,
                  cardColor: Colors.red,
                ),
                theme: ThemeData(
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  }),
                  brightness: Brightness.light,
                  primaryColor: AppColors.primaryAndDarkColor,
                  primaryColorDark: AppColors.primaryAndDarkColor,
                  scaffoldBackgroundColor: Colors.grey[300],
                  accentColor: Colors.pinkAccent,
                  appBarTheme: AppBarTheme(brightness: Brightness.dark),
                  primaryColorLight: Colors.white,
                  textTheme: TextTheme(
                    title: GoogleFonts.roboto(
                      fontSize: 80,
                      color: AppColors.primaryAndDarkColor,
                      fontWeight: FontWeight.bold,
                    ),
                    headline: GoogleFonts.roboto(
                      fontSize: 30,
                      color: AppColors.primaryAndDarkColor,
                      fontWeight: FontWeight.bold,
                    ),
                    body1: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    body2: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: GoogleFonts.roboto(
                      fontSize: 16,
                      color: AppColors.primaryAndDarkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  unselectedWidgetColor: AppColors.unselectedGenderBackground,
                  focusColor: AppColors.selectedGenderBackground,
                  hintColor: AppColors.primaryAndDarkColor,
                  sliderTheme: SliderThemeData(
                    activeTrackColor: Colors.pinkAccent,
                    activeTickMarkColor: Colors.pink,
                    disabledThumbColor: Colors.pink,
                    thumbColor: Colors.pink,
                    inactiveTrackColor: Colors.grey,
                    overlayColor: Colors.pinkAccent.withOpacity(0.3),
                  ),
                  cursorColor: Colors.pinkAccent,
                  cardColor: Colors.red,
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
                debugShowCheckedModeBanner: kReleaseMode,
                home: SplashPage(),
                onGenerateRoute: onGenerateRoute,
              );
            },
          );
        });
  }

  @override
  void dispose() {
    _languageBloc?.dispose();
    _themeBloc?.dispose();
    super.dispose();
  }
}
