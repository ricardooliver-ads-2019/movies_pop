import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/login/data/datasources/i_login_datasources.dart';

class LoginDatasourcesImpl implements ILoginDatasources {
  final HttpClient _client;

  LoginDatasourcesImpl({required HttpClient client}) : _client = client;
  @override
  Future<HttpClientResponse> getRequestToken() async {
    return await _client.get(
      Constants.baseUrl + '/authentication/token/new',
      queryParameters: {'api_key': Constants.apiKey},
    );
  }

  @override
  Future<HttpClientResponse> validateTokenWithLogin({
    required String login,
    required String password,
    required String requestToken,
  }) async {
    return await _client.post(
        Constants.baseUrl + '/authentication/token/validate_with_login',
        queryParameters: {
          'api_key': Constants.apiKey
        },
        data: {
          "username": login,
          "password": password,
          "request_token": requestToken
        });
  }

  @override
  Future<HttpClientResponse> validateSessionId(
      {required String requestToken}) async {
    return await _client.post(
      Constants.baseUrl + '/authentication/session/new',
      queryParameters: {
        'api_key': Constants.apiKey,
      },
      data: {"request_token": requestToken},
    );
  }

  @override
  Future<HttpClientResponse> getDetailsAccount(
      {required String sessionId}) async {
    return await _client.get(Constants.baseUrl + '/account', queryParameters: {
      'api_key': Constants.apiKey,
      'session_id': sessionId
    });
  }
}
