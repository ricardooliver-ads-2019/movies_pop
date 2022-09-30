import 'package:movies_pop/core/network/http_client_response.dart';

class HttpClientException implements Exception {
  String? message;
  int? statusCode;
  dynamic error;
  HttpClientResponse response;

  HttpClientException({
    this.message,
    this.statusCode,
    this.error,
    required this.response,
  });

  @override
  String toString() {
    return 'HttClientException(message: $message, statusCode: $statusCode, error: $error, response: $response)';
  }
}
