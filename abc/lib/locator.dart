import 'package:get_it/get_it.dart';

import 'core/services/abc_database.dart';
import 'core/viewmodels/views/add_dialog_view_model.dart';
import 'core/viewmodels/views/home_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // services locators
  locator.registerLazySingleton<AbcDatabaseProvider>(() => AbcDatabaseProvider());

  // view-model locators
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<AddDialogViewModel>(() => AddDialogViewModel());
}
