import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:trackit_flutter/repositories/Users/index.dart';

class DbHelper {
  static Database? _db;

  static const dbName = 'trackit.db';
  static const int version = 1;

  static UsersRepository usersRepository = UsersRepository();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();

    return _db;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);

    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int intVersion) async {
    usersRepository.createTable(db, intVersion);
  }
}