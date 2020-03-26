import 'package:abc/core/models/AbcItem.dart';
import 'package:abc/core/services/abc_database.dart';
import 'package:abc/core/viewmodels/base_model.dart';
import 'package:abc/locator.dart';

class HomeViewModel extends BaseModel {
  final abcDatabaseProvider = locator.get<AbcDatabaseProvider>();
  List<AbcItem> abcItems = [];

  Future<void> getAllAbcItems() async {
    setBusy(true);
    final result = await abcDatabaseProvider.getAllAbc();
    abcItems = result ?? [];
    setBusy(false);
  }

  Future<int> addAbcToDb(AbcItem abcItem) async {
    setBusy(true);
    final result = await abcDatabaseProvider.insertAbc(abcItem);
    setBusy(false);
    return result;
  }

  Future<void> deleteAbcFromDb(int id) async {
    setBusy(true);
    await abcDatabaseProvider.deleteAbc(id);
    setBusy(false);
  }
}
