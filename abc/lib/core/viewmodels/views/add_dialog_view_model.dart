import 'package:abc/core/models/AbcItem.dart';
import 'package:abc/core/services/abc_database.dart';
import 'package:abc/core/viewmodels/base_model.dart';
import 'package:abc/locator.dart';

class AddDialogViewModel extends BaseModel {
  final _abcDb = locator.get<AbcDatabaseProvider>();

  Future<int> addAbcToDatabase(AbcItem abcItem) async {
    setBusy(true);
    final result = await _abcDb.insertAbc(abcItem);
    setBusy(false);
    return result;
  }
}
