import 'package:mongo_dart/mongo_dart.dart';
import 'package:trackit_flutter/models/Habit/index.dart';

class HabitsRepository {
  static const String tableHabits = 'habits';

  static const String db_id = 'id';
  static const String db_name = 'name';
  static const String db_userId = 'user_id';
  static const String db_frequency = 'frequency';

  Future<void> createTable(Db db, int intVersion) async {
    await db.createCollection(tableHabits);
  }

  Future<HabitModel> save(Future<Db?> db, HabitModel habit) async {
    Db? dbClient = await db;

    habit.id = (await dbClient?.collection(tableHabits).insert(habit.toJson()))
        .toString();

    return habit;
  }

  Future<List<HabitModel>> getByUserId(Future<Db?> db, String userId) async {
    Db? dbClient = await db;

    var res = await dbClient
        ?.collection(tableHabits)
        .find(where.eq(db_userId, userId))
        .toList();

    if (res == null || res.isEmpty) {
      return [];
    }

    List<HabitModel> habits =
        res.map((habit) => HabitModel.fromMap(habit)).toList();

    

    return habits;
  }

  Future<List<HabitModel>> getByUserIdAndDate(
      Future<Db?> db, String userId) async {
    Db? dbClient = await db;

    var res = await dbClient
        ?.collection(tableHabits)
        .find(where
            .eq(db_userId, userId))
        .toList();

    if (res == null || res.isEmpty) {
      return [];
    }

    List<HabitModel> habits =
        res.map((habit) => HabitModel.fromMap(habit)).toList();

    List<HabitModel> todayHabits = [];

    for (var habit in habits) {
      if (habit.frequency[DateTime.now().weekday - 1] == true) {
        todayHabits.add(habit);
      }
    }

    

    return todayHabits;
  }

  Future<void> delete(Future<Db?> db, String habitId) async {
    Db? dbClient = await db;

    await dbClient?.collection(tableHabits).remove(where.eq(db_id, habitId));

    
  }
}
