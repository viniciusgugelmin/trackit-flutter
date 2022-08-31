import 'package:sqflite/sqflite.dart';
import 'package:trackit_flutter/context/User/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:crypt/crypt.dart';
import 'package:trackit_flutter/repositories/Repositories/index.dart';
import 'package:uuid/uuid.dart';

class UsersRepository {
  static const String tableUsers = 'users';

  static const String db_id = 'id';
  static const String db_name = 'name';
  static const String db_email = 'email';
  static const String db_password = 'password';

  Future<void> createTable(Database db, int intVersion) async {
    await db.execute('''
      CREATE TABLE $tableUsers (
        $db_id TEXT PRIMARY KEY,
        $db_name TEXT NOT NULL,
        $db_email TEXT UNIQUE NOT NULL,
        $db_password TEXT NOT NULL
      )
    ''');
  }

  Future<UserModel> save(Future<Database?> db, UserModel user) async {
    Database? dbClient = await db;

    String hashedPassword = Crypt.sha256(user.password).toString();
    user.password = hashedPassword;

    user.id = (await dbClient?.insert(tableUsers, user.toMap())).toString();

    return user;
  }

  Future<UserModel> getLoginUser(
      Future<Database?> db, String email, String password) async {
    Database? dbClient = await db;

    var res = await dbClient?.query(tableUsers, where: "$db_email = '$email'");

    if (res == null || res.isEmpty) {
      throw Exception("Login failed! User not found");
    }

    UserModel user = UserModel.fromMap(res.first);

    bool isPasswordValid =
        await Future.value(Crypt(user.password).match(password));

    if (!isPasswordValid) {
      throw Exception('Login failed! Password is not valid');
    }

    SessionsRepository sessionsRepository = SessionsRepository();
    await sessionsRepository.save(db, user);

    return user;
  }
}
