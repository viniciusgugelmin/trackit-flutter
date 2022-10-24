import 'package:mongo_dart/mongo_dart.dart';
import 'package:trackit_flutter/models/HabitUser/index.dart';

class HabitUserRepository {
  static const String tableHabitUser = 'habit_user';

  static const String db_habit_id = 'habit_id';
  static const String db_user_id = 'user_id';
  static const String db_created_at = 'created_at';

  Future<void> createTable(Db db, int intVersion) async {
    await db.createCollection(tableHabitUser);
  }

  Future<void> save(Future<Db?> db, String habitId, String userId) async {
    Db? dbClient = await db;

    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    bool checkIfHabitIsAlreadyCompletedToday = await dbClient?.collection(tableHabitUser).findOne({
      db_habit_id: habitId,
      db_user_id: userId,
      db_created_at: {
        r'$gte': startOfToday,
        r'$lt': now
      }
    }) != null;

    if (!checkIfHabitIsAlreadyCompletedToday) {
      await dbClient?.collection(tableHabitUser).insert({
        db_habit_id: habitId,
        db_user_id: userId,
        db_created_at: DateTime.now()
      });
      return;
    }

    

    throw 'Habit already completed today';
  }

  Future<List<HabitUserModel>> getByUserIdAndDate(Future<Db?> db, String userId) async {
    Db? dbClient = await db;

    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    List<Map> habitUserList = await dbClient?.collection(tableHabitUser).find({
      db_user_id: userId,
      db_created_at: {
        r'$gte': startOfToday,
        r'$lt': now
      }
    }).toList() ?? [];

    

    return HabitUserModel.fromJsonList(habitUserList);
  }

  Future<void> delete(Future<Db?> db, String habitId, String userId) async {
    Db? dbClient = await db;

    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    bool checkIfHabitIsNotCompletedToday = await dbClient?.collection(tableHabitUser).findOne({
      db_habit_id: habitId,
      db_user_id: userId,
      db_created_at: {
        r'$gte': startOfToday,
        r'$lt': now
      }
    }) == null;

    if (checkIfHabitIsNotCompletedToday) {
      throw 'Habit not completed today';
    }

    await dbClient?.collection(tableHabitUser).remove({
      db_habit_id: habitId,
      db_user_id: userId,
      db_created_at: {
        r'$gte': DateTime.now().subtract(const Duration(hours: 24)),
        r'$lt': DateTime.now()
      }
    });

    
  }
}
