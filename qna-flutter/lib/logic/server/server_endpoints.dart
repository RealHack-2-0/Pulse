import 'package:dio/dio.dart';

class ServerEndpoints {
  static const EMULATOR_HOST_IP_ADDRESS = 'http://10.0.2.2';
  static const NGROK_SERVER_ADDRESS = "https://f027b58b.ngrok.io";
  static const WEBSITE_ADDRESS = 'http://www.polyc.com';
  static const LOGIN = "auth/";
  static const LOGOUT = "api/logout/";

  final Dio _dio = Dio();
  final String _serverUrl;
  String _token;

  String get serverUrl => _serverUrl;

  set authorizationToken(String token) {
    print("Authorization key set to $token");
    _token = token;
  }

  ServerEndpoints({String serverUrl})
      : _serverUrl = serverUrl ?? NGROK_SERVER_ADDRESS {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (Options options) async {
          if (_token != null) {
            options.headers['Authorization'] = "Bearer $_token";
          }
        },
      ),
    );
  }

  Future<Response> get(String url) {
    print("Getting data from endpoint $url of server $_serverUrl");
    return _dio.get("$_serverUrl/$url");
  }

  Future<Response> post(String url, Map data) async {
    print("Posting $data to endpoint $url of server $_serverUrl");
    return _dio.post("$_serverUrl/$url", data: data);
  }
}
