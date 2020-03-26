import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poster/bloc_layer/authentication_bloc/authentication_bloc.dart';
import 'package:poster/bloc_layer/login_bloc/login_bloc.dart';
import 'package:poster/bloc_layer/theme_bloc/theme_bloc.dart';
import 'package:poster/bloc_layer/theme_bloc/theme_state.dart';
import 'package:poster/data_layer/repositories/user_repository.dart';
import 'package:poster/presentation_layer/pages/home_page.dart';
import 'package:poster/presentation_layer/pages/login_page.dart';
import 'package:poster/presentation_layer/pages/splash_page.dart';
import 'package:poster/presentation_layer/router.dart';
import 'package:poster/utils/simple_bloc_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = new UserRepository();
  runApp(
    RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: userRepository)
          ..add(
            AppStarted(),
          ),
        child: BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(),
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Poster App',
          theme: ThemeData(
            brightness: themeState.brightness,
            primarySwatch: Colors.blue,
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Uninitialized) {
                return SplashPage();
              }

              if (state is Unauthenticated) {
                return BlocProvider<LoginBloc>(
                  create: (_) => LoginBloc(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                  ),
                  child: LoginPage(),
                );
              }

              if (state is Authenticated) {
                return HomePage();
              }

              return Container();
            },
          ),
          onGenerateRoute: onGenerateRoute,
        );
      },
    );
  }
}
