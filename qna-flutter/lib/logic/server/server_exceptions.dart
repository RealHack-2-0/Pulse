import 'package:dio/dio.dart';
import 'package:qna_flutter/logic/models/response_error.dart';

class ServerException implements Exception {
  final ResponseError error;
  final Response response;

  ServerException(this.error, this.response);

  int get statusCode => response.statusCode;

  static fromDioError(DioError dioError) {
    switch (dioError.response.statusCode) {
      case 400:
        return Server400Exception(dioError.response);
      case 401:
        return Server401Exception(dioError.response);
      case 403:
        return Server403Exception(dioError.response);
      case 404:
        return Server404Exception(dioError.response);
      case 405:
        return Server405Exception(dioError.response);
      default:
        ResponseError error =
            ResponseError(dioError.response.statusMessage);
        return ServerException(error, dioError.response);
    }
  }

  @override
  String toString() {
    return "(Error ${response.statusCode}) ${error.detail}";
  }
}

class Server400Exception extends ServerException {
  static formatResponse(Response response) {
    RegExp pattern = RegExp(r"[()\[\]]");
    String formattedResponse = response.data.toString().replaceAll(pattern, "");
    formattedResponse =
        formattedResponse.replaceAll('\{', "[").replaceAll('\}', "]");
    return formattedResponse;
  }

  Server400Exception(Response response)
      : super(
            ResponseError(
                'Incorrect data: ${formatResponse(response)}'),
            response);
}

class Server401Exception extends ServerException {
  Server401Exception(Response response)
      : super(ResponseError(response.data), response);
}

class Server403Exception extends ServerException {
  Server403Exception(Response response)
      : super(ResponseError(response.data), response);
}

class Server404Exception extends ServerException {
  Server404Exception(Response response)
      : super(
            ResponseError(
                'API Endpoint not found: ${response.request.uri}'),
            response);
}

class Server405Exception extends ServerException {
  Server405Exception(Response response)
      : super(ResponseError(response.data), response);
}
