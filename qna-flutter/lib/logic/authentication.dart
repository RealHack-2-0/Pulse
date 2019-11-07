import 'package:qna_flutter/logic/server/server_manager.dart';

typedef void OnError(dynamic error);

class Authentication {
  static Future<bool> login(String email, String password,
      [OnError onError]) async {
    try {
      return ServerManager().login(email, password);
    } catch (e) {
      onError(e);
      return false;
    }
  }

  static Future<void> signup(
      String firstName, String lastName, String email, String password,
      [OnError onError]) async {
    try {
      await ServerManager().post('register/', {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password
      });
    } catch (e) {
      onError(e);
      return false;
    }
  }
}
