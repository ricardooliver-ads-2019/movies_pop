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
  HttpClientResponseError({
    required data,
    required int? statusCode,
    required String? statusMessage,
    HttpClientResponse? response,
  }) : super(data: data, statusCode: statusCode, statusMessage: statusMessage);

  @override
  String toString() {
    return 'HttClientResponseError(statusCode: $statusCode, statusMessage: $statusMessage)';
  }
}
