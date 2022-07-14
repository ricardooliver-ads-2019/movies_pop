import 'package:dio/dio.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_exception.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/utils/constants.dart';

class DioClient implements HttpClient {
  late final Dio _dio;

  final _defaultOptions = BaseOptions(baseUrl: Constants.base_url);

  DioClient({
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(baseOptions ?? _defaultOptions);
  }

  @override
  Future<HttpClientResponse> delete(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwHttpClientExeception(e);
    }
  }

  @override
  Future<HttpClientResponse> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwHttpClientExeception(e);
    }
  }

  @override
  Future<HttpClientResponse> patch(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwHttpClientExeception(e);
    }
  }

  @override
  Future<HttpClientResponse> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwHttpClientExeception(e);
    }
  }

  @override
  Future<HttpClientResponse> put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwHttpClientExeception(e);
    }
  }

  @override
  Future<HttpClientResponse> request(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );

      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwHttpClientExeception(e);
    }
  }

  Future<HttpClientResponse> _dioResponseConverter(
      Response<dynamic> response) async {
    if ((response.statusCode! >= 200) && (response.statusCode! < 400)) {
      print(response.requestOptions.validateStatus);
      return HttpClientResponseSuccess(
          data: response.data,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage);
    }

    print(response.requestOptions.validateStatus);
    return HttpClientResponseError(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  Never _throwHttpClientExeception(DioError dioError) {
    final response = dioError.response;

    throw HttpClientException(
        error: dioError.error,
        message: response?.statusMessage,
        statusCode: response?.statusCode,
        response: HttpClientResponse(
          data: response?.data,
          statusCode: response?.statusCode,
          statusMessage: response?.statusMessage,
        ));
  }
}
