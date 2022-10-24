import 'package:crypt/crypt.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/repositories/Sessions/index.dart';

class UsersRepository {
  static const String tableUsers = 'users';

  static const String db_id = 'id';
  static const String db_name = 'name';
  static const String db_email = 'email';
  static const String db_password = 'password';

  Future<void> createTable(Db db, int intVersion) async {
    await db.createCollection(tableUsers);
  }

  Future<UserModel> save(Future<Db?> db, UserModel user) async {
    Db? dbClient = await db;

    var userWithEmail = await dbClient?.collection(tableUsers).findOne(where.eq(db_email, user.email));

    if (userWithEmail != null && userWithEmail.isNotEmpty) {
      return throw Exception("Signup failed! User with email '${user.email}' already exists");
    }

    String hashedPassword = Crypt.sha256(user.password).toString();
    user.password = hashedPassword;

    user.id = (await dbClient?.collection(tableUsers).insert(user.toJson())).toString();

    

    return user;
  }

  Future<UserModel> getLoginUser(
      Future<Db?> db, String email, String password) async {
    Db? dbClient = await db;

    var res = await dbClient?.collection(tableUsers).findOne(where.eq(db_email, email));

    if (res == null || res.isEmpty) {
      throw Exception("Login failed! Incorrect email or password");
    }

    UserModel user = UserModel.fromMap(res);

    bool isPasswordValid =
        await Future.value(Crypt(user.password).match(password));

    if (!isPasswordValid) {
      throw Exception('Login failed! Incorrect email or password');
    }

    SessionsRepository sessionsRepository = SessionsRepository();
    await sessionsRepository.save(db, user);

    

    return user;
  }
}
