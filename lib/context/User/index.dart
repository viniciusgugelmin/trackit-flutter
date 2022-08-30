import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:trackit_flutter/models/User/index.dart';

class UserContext {
  static File get _localFile {
    return File('./assets/users.json');
  }

  static Future setUser(User user) async {
    final file = _localFile;

    final String userJson = json.encode(user.toJson());
    await file.writeAsString(userJson);
  }

  static getUser(String userId) async {
    final String jsonString = await rootBundle.loadString(_localFile.path);
    final jsonResponse = json.decode(jsonString);
    final users = jsonResponse as List;

    final user = users.firstWhere((user) => user['id'] == userId, orElse: () => null);

    return user;
  }
}