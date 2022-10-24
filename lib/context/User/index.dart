import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trackit_flutter/models/User/index.dart';

class UserContext {
  late FlutterSecureStorage storage;

  UserContext() {
    storage = const FlutterSecureStorage();
  }

  void setUser(UserModel user) {
    storage.write(key: 'user', value: json.encode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    String? user = await storage.read(key: 'user');

    if (user == null) {
      return null;
    }

    Map userMap = json.decode(user);

    return UserModel.fromMap(userMap as Map<String, dynamic>);
  }

  void clearUser() {
    storage.delete(key: 'user');
  }

  void setToken(String token) {
    storage.write(key: "token", value: token);
  }

  Future<Map<String, dynamic>?> getToken() async {
    String? token = await storage.read(key: "token");
    UserModel? user = await getUser();

    if (token == null) {
      return null;
    }

    return {
      "token": token,
      "user": user
    };
  }

  void clearToken() {
    storage.delete(key: "token");
  }
}