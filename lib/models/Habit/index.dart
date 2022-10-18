import 'package:uuid/uuid.dart';

class HabitModel {
  late String id;
  late String name;
  late List<bool> frequency;

  HabitModel(this.name, this.frequency) {
    id = const Uuid().v4();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
    };
  }

  Map<String, dynamic> toMapWithoutPassword() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
    };
  }

  List<HabitModel> fromList(List<dynamic> habits) {
    return habits.map((habit) => HabitModel.fromMap(habit)).toList();
  }

  HabitModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    frequency = map['frequency'].cast<bool>();
  }

  HabitModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        frequency = json['frequency'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
    };
  }
}
