class HttpClientResponse<T> {
  T? data;
  int? statusCode;
  String? statusMessage;
  HttpClientResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
  });
}
