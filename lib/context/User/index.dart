import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserContext {
  late FlutterSecureStorage storage;

  UserContext() {
    storage = const FlutterSecureStorage();
  }

  void saveToken(String token) {
    storage.write(key: "token", value: token);
  }

  Future<String?> getToken() async {
    String? token = await storage.read(key: "token");

    if (token == null) {
      return null;
    }

    return token;
  }
}