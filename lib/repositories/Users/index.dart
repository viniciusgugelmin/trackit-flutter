import 'package:sqflite/sqflite.dart';

class UsersRepository {
  static const String tableUsers = 'users';

  static const String userId = 'user_id';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';

  Future<void> createTable(Database db, int intVersion) async {
    await db.execute('''
      CREATE TABLE $tableUsers (
        $userId INTEGER PRIMARY KEY,
        $name TEXT NOT NULL,
        $email TEXT UNIQUE NOT NULL,
        $password TEXT NOT NULL
      )
    ''');
  }
}
