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
  Future<HttpClientResponse<T>> delete<T>(String path,
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
  Future<HttpClientResponse<T>> get<T>(String path,
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
  Future<HttpClientResponse<T>> patch<T>(String path,
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
  Future<HttpClientResponse<T>> post<T>(String path,
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
  Future<HttpClientResponse<T>> put<T>(String path,
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
  Future<HttpClientResponse<T>> request<T>(String path,
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

  Future<HttpClientResponse<T>> _dioResponseConverter<T>(
      Response<dynamic> response) async {
    return HttpClientResponse<T>(
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
