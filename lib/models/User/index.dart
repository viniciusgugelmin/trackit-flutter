import 'package:uuid/uuid.dart';

class UserModel {
  late String id;
  late String name;
  late String email;
  late String password;

  UserModel(this.name, this.email, this.password) {
    id = const Uuid().v4();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toMapWithoutPassword() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': '',
    };
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
  }
}
