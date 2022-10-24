import 'package:uuid/uuid.dart';

class SessionModel {
  late String id;
  late String token;
  late String userId;

  SessionModel(this.token, this.userId) {
    id = const Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'user_id': userId,
    };
  }

  SessionModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    token = map['token'];
    userId = map['user_id'];
  }
}
