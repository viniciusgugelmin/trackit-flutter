import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/repositories/Repositories/index.dart';
import 'dart:io' as io;

import 'package:trackit_flutter/repositories/Users/index.dart';

class DbHelper {
  static Database? _db;

  static const dbName = 'trackit.db';
  static const int version = 1;

  static UsersRepository usersRepository = UsersRepository();
  static SessionsRepository sessionsRepository = SessionsRepository();

  Future<UserModel> saveUser(UserModel user) async => await usersRepository.save(db, user);
  Future<UserModel> getLoginUser(String email, String password) async => await usersRepository.getLoginUser(db, email, password);

  Future<void> saveSession(UserModel user) async => await sessionsRepository.save(db, user);
  Future<UserModel> getSessionUser(String token, String tableUsers) async => await sessionsRepository.getUser(db, token, tableUsers);

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await init();

    return _db;
  }

  Future<Database> init() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);

    if (false) {
      await deleteDatabase(path);
    }

    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int intVersion) async {
    await usersRepository.createTable(db, intVersion);
    await sessionsRepository.createTable(db, intVersion);
  }
}