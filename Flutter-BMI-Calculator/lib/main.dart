import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/blocs/theme_bloc/theme_bloc.dart';
import 'package:bmi_calculator/localizations/app_localizations.dart';
import 'package:bmi_calculator/locator.dart';
import 'package:bmi_calculator/ui/pages/splash_page.dart';
import 'package:bmi_calculator/ui/router.dart';
import 'package:bmi_calculator/ui/shared/colors.dart';
import 'package:bmi_calculator/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: AppColors.primaryAndDarkColor,

      // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primaryAndDarkColor,
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
  ThemeBloc themeBloc;

  @override
  void initState() {
    languageBloc = GetIt.instance.get<LanguageBloc>();
    themeBloc = GetIt.instance.get<ThemeBloc>();
    languageBloc?.loadDefaultLocale();
    themeBloc?.loadDefaultTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation, context);
              return StreamBuilder<Locale>(
                  stream: languageBloc.currentLocale,
                  builder: (context, currentLocaleSnapshot) {
                    return StreamBuilder<ThemeMode>(
                      stream: themeBloc.currentThemeMode,
                      builder: (context, themeSnapshot) {
                        return MaterialApp(
                          themeMode: themeSnapshot.data,
                          darkTheme: ThemeData(
                            brightness: Brightness.dark,
                            primaryColor: AppColors.primaryAndDarkColor,
                            accentColor: Colors.pinkAccent,
                            scaffoldBackgroundColor:
                                AppColors.primaryAndDarkColor,
                            textTheme: TextTheme(
                              title: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    22.22 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              headline: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    8.611 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              body1: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    4.444 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              body2: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    4.444 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    4.444 *
                                    SizeConfig.textScaleFactor,
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
                          ),
                          theme: ThemeData(
                            brightness: Brightness.light,
                            primaryColor: AppColors.primaryAndDarkColor,
                            scaffoldBackgroundColor: Colors.grey[300],
                            accentColor: Colors.pinkAccent,
                            textTheme: TextTheme(
                              title: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    22.22 *
                                    SizeConfig.textScaleFactor,
                                color: AppColors.primaryAndDarkColor,
                                fontWeight: FontWeight.bold,
                              ),
                              headline: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    8.611 *
                                    SizeConfig.textScaleFactor,
                                color: AppColors.primaryAndDarkColor,
                                fontWeight: FontWeight.bold,
                              ),
                              body1: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    4.444 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              body2: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    4.444 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    4.444 *
                                    SizeConfig.textScaleFactor,
                                color: AppColors.primaryAndDarkColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            unselectedWidgetColor:
                                AppColors.unselectedGenderBackground,
                            focusColor: AppColors.selectedGenderBackground,
                            hintColor: AppColors.primaryAndDarkColor,
                            sliderTheme: SliderThemeData(
                              activeTrackColor: Colors.pinkAccent,
                              activeTickMarkColor: Colors.pink,
                              disabledThumbColor: Colors.pink,
                              thumbColor: Colors.pink,
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
                          home: SplashPage(),
                          onGenerateRoute: onGenerateRoute,
                        );
                      },
                    );
                  });
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    languageBloc?.dispose();
    themeBloc?.dispose();
    super.dispose();
  }
}
