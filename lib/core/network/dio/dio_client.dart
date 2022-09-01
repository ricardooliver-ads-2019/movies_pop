import 'package:dio/dio.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_exception.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/network_connection/i_network_connection.dart';
import 'package:movies_pop/core/utils/constants.dart';

class DioClient implements HttpClient {
  late final Dio _dio;
  late final INetworkConnection _networkConnection;

  final _defaultOptions = BaseOptions(baseUrl: Constants.baseUrl);

  DioClient(
      {BaseOptions? baseOptions,
      required INetworkConnection networkConnection}) {
    _dio = Dio(baseOptions ?? _defaultOptions);
    _networkConnection = networkConnection;
  }

  @override
  Future<HttpClientResponse> delete(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    if (await _networkConnection.isConnected) {
      try {
        final response = await _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: _getOptions(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioError catch (e) {
        _throwHttpClientExeception(e);
      }
    }

    return HttpClientResponseError(
      data: null,
      statusCode: 0,
      statusMessage: 'no connection',
      response: HttpClientResponse(
          data: null, statusCode: 0, statusMessage: 'no connection'),
    );
  }

  @override
  Future<HttpClientResponse> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    if (await _networkConnection.isConnected) {
      try {
        final response = await _dio.get(
          path,
          queryParameters: queryParameters,
          options: _getOptions(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioError catch (e) {
        _throwHttpClientExeception(e);
      }
    }

    return HttpClientResponseError(
      data: null,
      statusCode: 0,
      statusMessage: 'no connection',
      response: HttpClientResponse(
          data: null, statusCode: 0, statusMessage: 'no connection'),
    );
  }

  @override
  Future<HttpClientResponse> patch(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    if (await _networkConnection.isConnected) {
      try {
        final response = await _dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: _getOptions(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioError catch (e) {
        _throwHttpClientExeception(e);
      }
    }

    return HttpClientResponseError(
      data: null,
      statusCode: 0,
      statusMessage: 'no connection',
      response: HttpClientResponse(
          data: null, statusCode: 0, statusMessage: 'no connection'),
    );
  }

  @override
  Future<HttpClientResponse> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    if (await _networkConnection.isConnected) {
      try {
        final response = await _dio.post(path,
            data: data,
            queryParameters: queryParameters,
            options: _getOptions(headers: headers));

        return _dioResponseConverter(response);
      } on DioError catch (e) {
        _throwHttpClientExeception(e);
      }
    }

    return HttpClientResponseError(
      data: null,
      statusCode: 0,
      statusMessage: 'no connection',
      response: HttpClientResponse(
          data: null, statusCode: 0, statusMessage: 'no connection'),
    );
  }

  @override
  Future<HttpClientResponse> put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    if (await _networkConnection.isConnected) {
      try {
        final response = await _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: _getOptions(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioError catch (e) {
        _throwHttpClientExeception(e);
      }
    }

    return HttpClientResponseError(
      data: null,
      statusCode: 0,
      statusMessage: 'no connection',
      response: HttpClientResponse(
          data: null, statusCode: 0, statusMessage: 'no connection'),
    );
  }

  @override
  Future<HttpClientResponse> request(String path,
      {required String method,
      data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    if (await _networkConnection.isConnected) {
      try {
        final response = await _dio.request(path,
            data: data,
            queryParameters: queryParameters,
            options: _getOptions(headers: headers, method: method));

        return _dioResponseConverter(response);
      } on DioError catch (e) {
        _throwHttpClientExeception(e);
      }
    }

    return HttpClientResponseError(
      data: null,
      statusCode: 0,
      statusMessage: 'no connection',
      response: HttpClientResponse(
          data: null, statusCode: 0, statusMessage: 'no connection'),
    );
  }

  Future<HttpClientResponse> _dioResponseConverter(
      Response<dynamic> response) async {
    if ((response.statusCode! >= 200) && (response.statusCode! < 400)) {
      return HttpClientResponseSuccess(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    }

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

  Options _getOptions({Map<String, dynamic>? headers, String? method}) {
    return Options(
        headers: headers,
        method: method,
        validateStatus: (statusCode) {
          if (statusCode == null) {
            return false;
          } else {
            return statusCode >= 200 && statusCode < 500;
          }
        });
  }
}
