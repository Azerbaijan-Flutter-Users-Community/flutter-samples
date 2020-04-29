import 'package:bmi_calculator/blocs/lang_bloc/language_bloc.dart';
import 'package:bmi_calculator/blocs/lang_bloc/theme_bloc.dart';
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
  ThemeBloc themeBloc;

  @override
  void initState() {
    languageBloc = GetIt.instance.get<LanguageBloc>();
    themeBloc = GetIt.instance.get<ThemeBloc>();
    languageBloc.loadDefaultLocale();
    themeBloc.loadDefaultTheme();
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
                    print('locale rebuilding..');
                    return StreamBuilder<ThemeMode>(
                      stream: themeBloc.currentThemeMode,
                      builder: (context, themeSnapshot) {
                        print('theme rebuilding..');
                        return MaterialApp(
                          themeMode: themeSnapshot.data,
                          darkTheme: ThemeData(
                            brightness: Brightness.dark,
                            primaryColor: Colors.deepPurple,
                            primaryColorDark: Colors.deepPurple,
                            accentColor: Colors.black54,
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
                                color: Colors.white,
                              ),
                            ),
                            unselectedWidgetColor:
                                AppColors.unselectedGenderBackground,
                            focusColor: AppColors.selectedGenderBackground,
                          ),
                          theme: ThemeData(
                            brightness: Brightness.light,
                            primaryColor: Colors.deepPurple,
                            primaryColorDark: Colors.deepPurple,
                            accentColor: Colors.deepPurpleAccent,
                            textTheme: TextTheme(
                              title: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    22.22 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                              headline: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    8.611 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                              body1: GoogleFonts.roboto(
                                fontSize: SizeConfig.widthMultiplier *
                                    4.444 *
                                    SizeConfig.textScaleFactor,
                                color: Colors.deepPurple,
                              ),
                            ),
                            unselectedWidgetColor:
                                AppColors.unselectedGenderBackground,
                            focusColor: AppColors.selectedGenderBackground,
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
