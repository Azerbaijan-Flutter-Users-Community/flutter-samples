import 'package:get_it/get_it.dart';

import 'blocs/lang_bloc/language_bloc.dart';

void initLocator() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<LanguageBloc>(LanguageBloc());
}
