import 'package:get_it/get_it.dart';

import 'blocs/lang_bloc/language_bloc.dart';
import 'blocs/theme_bloc/theme_bloc.dart';

void initLocator() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<LanguageBloc>(LanguageBloc());
  getIt.registerSingleton<ThemeBloc>(ThemeBloc());
}
