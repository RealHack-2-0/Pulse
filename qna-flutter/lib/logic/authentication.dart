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

  static Future<bool> signup(
      String name, String email, String password, String confirm,
      [OnError onError]) async {
    return false;
  }
}
