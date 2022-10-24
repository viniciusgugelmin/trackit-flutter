import 'package:mongo_dart/mongo_dart.dart';
import 'package:trackit_flutter/context/User/index.dart';
import 'package:trackit_flutter/models/Session/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:uuid/uuid.dart';

class SessionsRepository {
  static const String tableSessions = 'sessions';

  static const String db_id = 'id';
  static const String db_token = 'token';
  static const String db_userId = 'user_id';

  Future<void> createTable(Db db, int intVersion) async {
    await db.createCollection(tableSessions);
  }

  Future<void> save(Future<Db?> db, UserModel user) async {
    Db? dbClient = await db;

    String token = const Uuid().v4();
    SessionModel session = SessionModel(token, user.id);

    await dbClient?.collection(tableSessions).insert(session.toJson());

    UserContext userContext = UserContext();
    userContext.setToken(token);
    userContext.setUser(user);
  }

  Future<UserModel> getUser(Future<Db?> db, String token, String tableUsers) async {
    Db? dbClient = await db;

    var res = await dbClient?.collection(tableSessions).findOne({db_token: token});

    if (res == null || res.isEmpty) {
      throw Exception("Get user failed! User not found");
    }

    SessionModel session = SessionModel.fromMap(res);

    var resUser = await dbClient?.collection(tableUsers).findOne({db_id: session.userId});

    if (resUser == null || resUser.isEmpty) {
      throw Exception("Get user failed! User not found");
    }

    UserModel user = UserModel.fromMap(resUser);

    return user;
  }

  Future<void> delete(Future<Db?> db, String token) async {
    Db? dbClient = await db;

    var res = await dbClient?.collection(tableSessions).findOne({db_token: token});

    if (res == null || res.isEmpty) {
      return;
    }

    await dbClient?.collection(tableSessions).remove({db_token: token});
  }
}
