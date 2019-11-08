import 'package:dio/dio.dart';
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

  static Future<Map<String, dynamic>> getUserData(String id) async {
    Response r = await ServerManager().get('user/$id/');
    Map<String, dynamic> map = Map<String, dynamic>.from(r.data);
    print(map);
    return map;
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
