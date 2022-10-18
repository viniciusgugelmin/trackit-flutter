import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trackit_flutter/models/Habit/index.dart';
import 'package:trackit_flutter/models/User/index.dart';

class HabitContext {
  late FlutterSecureStorage storage;

  HabitContext() {
    storage = const FlutterSecureStorage();
  }

  Future<List<HabitModel>?> getHabits() async {
    String? habits = await storage.read(key: 'habits');

    if (habits == null) {
      return null;
    }

    List habitsMap = json.decode(habits);

    return habitsMap.map((habit) => HabitModel.fromMap(habit)).toList();
  }

  Future<void> setHabit(HabitModel habit) async {
    String? habits = await storage.read(key: 'habits');

    List<HabitModel> habitsMap = [];

    if (habits != null) {
      habitsMap = habit.fromList(json.decode(habits));
    }

    habitsMap.add(habit);

    await storage.write(key: 'habits', value: json.encode(habitsMap));
  }

  Future<void> deleteHabit(String id) async {
    String? habits = await storage.read(key: 'habits');

    List habitsMap = [];

    if (habits != null) {
      habitsMap = json.decode(habits);
    }

    habitsMap.removeWhere((habit) => habit['id'] == id);

    await storage.write(key: 'habits', value: json.encode(habitsMap));
  }


  void clearHabits() {
    storage.delete(key: 'habits');
  }
}