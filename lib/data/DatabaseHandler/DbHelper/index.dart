import 'package:mongo_dart/mongo_dart.dart';
import 'package:trackit_flutter/constants.dart';
import 'package:trackit_flutter/models/Habit/index.dart';
import 'package:trackit_flutter/models/HabitUser/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/repositories/HabitUser/index.dart';
import 'package:trackit_flutter/repositories/Habits/index.dart';
import 'package:trackit_flutter/repositories/Sessions/index.dart';

import 'package:trackit_flutter/repositories/Users/index.dart';

class DbHelper {
  static Db? _db;

  static const dbName = 'trackit.db';
  static const int version = 1;

  static UsersRepository usersRepository = UsersRepository();
  static SessionsRepository sessionsRepository = SessionsRepository();
  static HabitsRepository habitsRepository = HabitsRepository();
  static HabitUserRepository habitUserRepository = HabitUserRepository();

  Future<UserModel> saveUser(UserModel user) async => await usersRepository.save(db, user);
  Future<UserModel> getLoginUser(String email, String password) async => await usersRepository.getLoginUser(db, email, password);

  Future<void> saveSession(UserModel user) async => await sessionsRepository.save(db, user);
  Future<UserModel> getSessionUser(String token) async => await sessionsRepository.getUser(db, token, UsersRepository.tableUsers);
  Future<void> deleteSession(String token) async => await sessionsRepository.delete(db, token);

  Future<void> saveHabit(HabitModel habit) async => await habitsRepository.save(db, habit);
  Future<List<HabitModel>> getByUserId(String userId) async => await habitsRepository.getByUserId(db, userId);
  Future<List<HabitModel>> getByUserIdAndDate(String userId) async => await habitsRepository.getByUserIdAndDate(db, userId);
  Future<void> deleteHabit(String id) async => await habitsRepository.delete(db, id);

  Future<void> saveHabitUser(String habitId, String userId) async => await habitUserRepository.save(db, habitId, userId);
  Future<List<HabitUserModel>> getHabitUserByUserIdAndDate(String userId) async => await habitUserRepository.getByUserIdAndDate(db, userId);
  Future<void> deleteHabitUser(String habitId, String userId) async => await habitUserRepository.delete(db, habitId, userId);

  Future<Db?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await init();

    return _db;
  }

  Future<Db> init() async {
    Db db = await Db.create(Constants.dbConnectionString);
    await db.open();

    if (false) {
      await db.dropCollection(UsersRepository.tableUsers);
      await db.dropCollection(SessionsRepository.tableSessions);
      await db.dropCollection(HabitsRepository.tableHabits);
      await db.dropCollection(HabitUserRepository.tableHabitUser);
    }

    return db;
  }
}