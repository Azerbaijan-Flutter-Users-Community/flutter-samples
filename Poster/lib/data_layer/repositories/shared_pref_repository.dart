import 'package:poster/constants/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  static LocalStorageRepository _localStorageRepository;
  static SharedPreferences _sharedPreferences;

  static Future<LocalStorageRepository> getInstance() async {
    if (_localStorageRepository == null) {
      _localStorageRepository = LocalStorageRepository();
    }

    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }

    return _localStorageRepository;
  }

  String readUid() {
    return _sharedPreferences.get(Keys.UID);
  }

  Future<bool> writeUid(String value) {
    return _sharedPreferences.setString(Keys.UID, value);
  }

  Future<bool> removeUid() {
    return _sharedPreferences.remove(Keys.UID);
  }

  Future<bool> enableDarkMode() {
    return _sharedPreferences.setBool(Keys.mode, true);
  }

  Future<bool> disableDarkMode() {
    return _sharedPreferences.setBool(Keys.mode, false);
  }
}
