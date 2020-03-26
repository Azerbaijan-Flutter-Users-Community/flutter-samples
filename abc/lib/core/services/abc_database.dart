import 'dart:async';
import 'dart:io';

import 'package:abc/core/models/AbcItem.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AbcDatabaseProvider {
  static Database _database;
  final String tableAbc = 'abc';
  final String abcId = 'abcId';
  final String abcAccident = 'abcAccident';
  final String abcBelief = 'abcBelief';
  final String abcConsequence = 'abcConsequence';
  final String abcDateTime = 'abcDateTime';

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "AbcDb.db";
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableAbc (
          $abcId integer primary key autoincrement,
          $abcAccident text not null,
          $abcBelief text not null,
          $abcConsequence text not null,
          $abcDateTime text not null)
''');
    });
  }

  Future<int> insertAbc(AbcItem abcItem) async {
    final db = await database;
    abcItem.abcId = (await db.insert(tableAbc, abcItem.toMap()));
    return abcItem.abcId;
  }

  Future<AbcItem> getAbc(int id) async {
    final db = await database;
    var result =
        await db.query(tableAbc, where: "abcId = ?", whereArgs: [abcId]);
    return result.isNotEmpty ? AbcItem.fromMap(result.first) : Null;
  }

  Future<List<AbcItem>> getAllAbc() async {
    final db = await database;
    var result = await db.query(tableAbc);
    List<AbcItem> abcs = result.isNotEmpty
        ? result.map((abc) => AbcItem.fromMap(abc)).toList()
        : [];
    return abcs;
  }

  Future<String> updateAbc(AbcItem abcItem) async {
    final db = await database;
    var result = (await db.update(tableAbc, abcItem.toMap(),
            where: "id = ?", whereArgs: [abcItem.abcId]))
        .toString();
    return result;
  }

  Future<void> deleteAbc(int abcId) async {
    final db = await database;
    db.delete(tableAbc, where: "abcId = ?", whereArgs: [abcId]);
  }

  Future<void> deleteAllAbc() async {
    final db = await database;
    db.rawDelete('Delete * from $tableAbc');
  }
}
