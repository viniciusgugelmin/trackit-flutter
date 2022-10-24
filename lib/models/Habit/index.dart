import 'package:uuid/uuid.dart';

class HabitModel {
  late String id;
  late String name;
  late String userId;
  late List<bool> frequency;

  HabitModel(this.name, this.userId, this.frequency) {
    id = const Uuid().v4();
  }

  Map<String, dynamic> toMapWithoutPassword() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'frequency': frequency,
    };
  }

  List<HabitModel> fromList(List<dynamic> habits) {
    return habits.map((habit) => HabitModel.fromMap(habit)).toList();
  }

  HabitModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    userId = map['user_id'];
    frequency = map['frequency'].cast<bool>();
  }

  HabitModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        userId = json['user_id'],
        frequency = json['frequency'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'frequency': frequency,
    };
  }
}
