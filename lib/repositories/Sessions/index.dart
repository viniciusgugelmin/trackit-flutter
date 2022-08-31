import 'package:sqflite/sqflite.dart';
import 'package:trackit_flutter/context/User/index.dart';
import 'package:trackit_flutter/models/Session/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:crypt/crypt.dart';
import 'package:uuid/uuid.dart';

class SessionsRepository {
  static const String tableSessions = 'sessions';

  static const String db_id = 'id';
  static const String db_token = 'token';
  static const String db_userId = 'user_id';

  Future<void> createTable(Database db, int intVersion) async {
    await db.execute('''
      CREATE TABLE $tableSessions (
        $db_id TEXT PRIMARY KEY,
        $db_token TEXT NOT NULL,
        $db_userId TEXT NOT NULL
      )
    ''');
  }

  Future<void> save(Future<Database?> db, UserModel user) async {
    Database? dbClient = await db;

    String token = const Uuid().v4();
    SessionModel session = SessionModel(token, user.id);

    await dbClient?.insert(tableSessions, session.toMap());

    UserContext userContext = UserContext();
    userContext.setToken(token);
    userContext.setUser(user);
  }

  Future<UserModel> getUser(Future<Database?> db, String token, String tableUsers) async {
    Database? dbClient = await db;

    var res = await dbClient?.query(tableSessions, where: "$db_token = '$token'");

    if (res == null || res.isEmpty) {
      throw Exception("Get user failed! User not found");
    }

    SessionModel session = SessionModel.fromMap(res.first);

    var resUser = await dbClient?.query(tableUsers, where: "$db_id = '${session.userId}'");

    if (resUser == null || resUser.isEmpty) {
      throw Exception("Get user failed! User not found");
    }

    UserModel user = UserModel.fromMap(resUser.first);

    return user;
  }

  Future<void> delete(Future<Database?> db, String token) async {
    Database? dbClient = await db;

    var res = await dbClient?.query(tableSessions, where: "$db_token = '$token'");

    if (res == null || res.isEmpty) {
      return;
    }

    await dbClient?.delete(tableSessions, where: "$db_token = '$token'");
  }
}
