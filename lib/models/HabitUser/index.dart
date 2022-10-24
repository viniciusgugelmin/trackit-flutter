class HabitUserModel {
  late String habitId;
  late String userId;
  late DateTime createdAt;

  HabitUserModel(this.habitId, this.userId, this.createdAt);

  Map<String, dynamic> toJson() {
    return {
      'habit_id': habitId,
      'user_id': userId,
      'created_at': createdAt,
    };
  }


  static List<HabitUserModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HabitUserModel.fromJson(json)).toList();
  }

  HabitUserModel.fromMap(Map<String, dynamic> map) {
    habitId = map['habit_id'];
    userId = map['user_id'];
    createdAt = map['created_at'];
  }

  HabitUserModel.fromJson(Map<String, dynamic> json)
      : habitId = json['habit_id'],
        userId = json['user_id'],
        createdAt = json['created_at'];
}
