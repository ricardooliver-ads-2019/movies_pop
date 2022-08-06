import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/login/data/datasources/i_login_datasources.dart';
import 'package:movies_pop/features/login/data/datasources/login_datasources_impl.dart';

class MockHttpClient extends Mock implements HttpClient {}

Future<void> main() async {
  late HttpClient client;
  late ILoginDatasources datasourcesImpl;

  setUp(() {
    client = MockHttpClient();
    datasourcesImpl = LoginDatasourcesImpl(client: client);
  });

  Map<String, dynamic> tResponseRequestToken = {
    "success": true,
    "expires_at": "2022-08-05 03:39:17",
    "request_token": "b409c24d8ad4595f1bdb096a43c934d328428146"
  };

  Map<String, dynamic> tResponseSessionId = {
    "success": true,
    "session_id": "0ebc8799e32e0b761f9a35ac71299fb2d9752de5"
  };

  const urlBaseGetRequestToken =
      'https://api.themoviedb.org/3/authentication/token/new';

  const urlBaseValidateTokenWithLogin =
      'https://api.themoviedb.org/3/authentication/token/validate_with_login';

  const urlBaseValidateSessionId =
      'https://api.themoviedb.org/3/authentication/session/new';

  test('login datasources impl ...', () async {
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: tResponseRequestToken,
        statusCode: 200,
        statusMessage: 'success',
      ),
    );

    final result = await datasourcesImpl.getRequestToken();
    print(result.data);
    print(result.statusCode);
    print(result.statusMessage);
    expect(
      result.data,
      tResponseRequestToken,
    );

    verify(
      () => client.get(urlBaseGetRequestToken, queryParameters: {
        'api_key': '899e6212bb39852b379032c9c5e25689',
      }),
    ).called(1);
  });

  //------------------------------ validateTokenWithLogin ------------------------------//

  test('deve retornar um requesToken validado', () async {
    when(() => client
            .post(any(), queryParameters: any(named: 'queryParameters'), data: {
          "username": "ricardooliver245",
          "password": "Fh587932",
          "request_token": "039ad8a2ef1b5636a6bba3351a592a905c801392"
        })).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: tResponseRequestToken,
        statusCode: 200,
        statusMessage: 'success',
      ),
    );

    final result = await datasourcesImpl.validateTokenWithLogin(
      login: 'ricardooliver245',
      password: 'Fh587932',
      requestToken: '039ad8a2ef1b5636a6bba3351a592a905c801392',
    );

    expect(result.data, tResponseRequestToken);

    verify(
      () => client.post(urlBaseValidateTokenWithLogin, queryParameters: {
        'api_key': '899e6212bb39852b379032c9c5e25689',
      }, data: {
        "username": "ricardooliver245",
        "password": "Fh587932",
        "request_token": "039ad8a2ef1b5636a6bba3351a592a905c801392"
      }),
    ).called(1);
  });

  //------------------------------ validateSessionId ------------------------------//
  test('deve retornar uma sessionId', () async {
    when(() => client.post(any(),
            queryParameters: any(named: 'queryParameters'),
            data: {
              "request_token": "039ad8a2ef1b5636a6bba3351a592a905c801392"
            })).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: tResponseSessionId,
        statusCode: 200,
        statusMessage: 'success',
      ),
    );

    final result = await datasourcesImpl.validateSessionId(
        requestToken: '039ad8a2ef1b5636a6bba3351a592a905c801392');
    print(result.data);
    expect(result.data, tResponseSessionId);

    verify(
      () => client.post(urlBaseValidateSessionId,
          queryParameters: {'api_key': '899e6212bb39852b379032c9c5e25689'},
          data: {"request_token": "039ad8a2ef1b5636a6bba3351a592a905c801392"}),
    ).called(1);
  });
}
