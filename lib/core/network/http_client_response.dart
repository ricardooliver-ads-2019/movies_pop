class HttpClientResponse {
  dynamic data;
  int? statusCode;
  String? statusMessage;
  HttpClientResponse({
    required this.data,
    required this.statusCode,
    required this.statusMessage,
  });
}

class HttpClientResponseSuccess extends HttpClientResponse {
  HttpClientResponseSuccess({
    required data,
    required int? statusCode,
    required String? statusMessage,
  }) : super(data: data, statusCode: statusCode, statusMessage: statusMessage);
}

class HttpClientResponseError extends HttpClientResponse {
  String? message;
  @override
  int? statusCode;
  dynamic error;
  HttpClientResponse? response;

  HttpClientResponseError({
    required data,
    required int? statusCode,
    required String? statusMessage,
    HttpClientResponse? response,
  }) : super(
          data: data,
          statusCode: statusCode,
          statusMessage: statusMessage,
        );

  @override
  String toString() {
    return 'HttClientException(message: $message, statusCode: $statusCode, error: $error, response: $response)';
  }
}
