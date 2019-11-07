import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:dio/dio.dart';

import 'server_endpoints.dart';
import 'server_exceptions.dart';

class ServerManager {
  static const String _serverUrl = ServerEndpoints.EMULATOR_HOST_IP_ADDRESS;
  static ServerManager _repository;
  final ServerEndpoints _serverEndPoints;
  String userId;

  factory ServerManager() {
    if (_repository == null) {
      _repository = ServerManager._internal();
    }
    return _repository;
  }

  ServerManager._internal()
      : _serverEndPoints = ServerEndpoints(serverUrl: _serverUrl);

  Future<Response> get(String url) async {
    try {
      return await _serverEndPoints.get(url);
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        throw ServerException.fromDioError(e);
      } else {
        throw e;
      }
    }
  }

  Future<Response> post(String url, [Map data = const {}]) async {
    try {
      return await _serverEndPoints.post(url, data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        throw ServerException.fromDioError(e);
      } else {
        throw e;
      }
    }
  }

  Future<bool> login(String email, String password) async {
    Response response;
    try {
      response = await post(
        ServerEndpoints.LOGIN,
        {
          'email': email,
          'password': password,
        },
      );
      print(response);
    } on ServerException catch (e) {
      print("User login error: ${e.error.detail}");
      response = e.response;
    } on DioError catch (e) {
      print("User login error(Unhandled): ${e.message}");
      response = e.response;
    } catch (e) {
      throw e;
    }

    if (response.statusCode == 201) {
      // Save token for future authorizations
      _serverEndPoints.authorizationToken = response.data['accessToken'];
      userId = response.data['id'];

      final manager = SocketIOManager();
      final socket = await manager.createInstance(SocketOptions("$_serverUrl",
          nameSpace: "/pulse",
          enableLogging: true,
          transports: [Transports.POLLING]));

      socket.onConnect((s) {
        print("Conntection:::::::: $s");
      });
      socket.on("msg-event", (data) {
        print("NEWS: $data");
      });
      socket.connect();

      print("User: $userId");

      print("User $email logged in.");
      return true;
    } else {
      print("User $email logging in failed");
      return false;
    }
  }

  Future<void> logout() async {
    await post(ServerEndpoints.LOGOUT);
    _serverEndPoints.authorizationToken = null;
    print("User logged out");
  }
}
