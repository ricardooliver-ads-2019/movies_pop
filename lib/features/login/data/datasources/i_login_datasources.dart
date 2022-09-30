import 'package:movies_pop/core/network/http_client_response.dart';

abstract class ILoginDatasources {
  Future<HttpClientResponse> getRequestToken();

  Future<HttpClientResponse> validateTokenWithLogin({
    required String login,
    required String password,
    required String requestToken,
  });

  Future<HttpClientResponse> validateSessionId({required String requestToken});

  Future<HttpClientResponse> getDetailsAccount({required String sessionId});
}
