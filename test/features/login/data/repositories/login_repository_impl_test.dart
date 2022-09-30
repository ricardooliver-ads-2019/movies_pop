import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/login/data/datasources/i_login_datasources.dart';
import 'package:movies_pop/features/login/data/models/request_token_model.dart';
import 'package:movies_pop/features/login/data/models/session_id_model.dart';
import 'package:movies_pop/features/login/data/repositories/login_repository_impl.dart';

class MockILoginDatasource extends Mock implements ILoginDatasources {}

void main() {
  late ILoginDatasources loginDatasource;
  late LoginRepositoryImpl loginRepository;

  setUp(() {
    loginDatasource = MockILoginDatasource();
    loginRepository = LoginRepositoryImpl(loginDatasources: loginDatasource);
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

  test('Deve retornar RequestTokenEntity', () async {
    when(() => loginDatasource.getRequestToken()).thenAnswer((_) async =>
        HttpClientResponseSuccess(
            data: tResponseRequestToken,
            statusCode: 200,
            statusMessage: 'statusMessage'));

    final result = await loginRepository.getRequestToken();
    final requestToken = result.fold((l) => null, (r) => r);

    expect(
      requestToken,
      RequestTokenModel(
          expiresAt: DateTime.parse('2022-08-05 03:39:17'),
          requestToken: 'b409c24d8ad4595f1bdb096a43c934d328428146'),
    );
  });

  //------------------------------ validateTokenWithLogin ------------------------------//

  test('deve retornar um requesToken validado', () async {
    when(
      () => loginDatasource.validateTokenWithLogin(
          login: 'ricardooliver245',
          password: 'Fh587932',
          requestToken: 'b409c24d8ad4595f1bdb096a43c934d328428146'),
    ).thenAnswer((_) async => HttpClientResponseSuccess(
        data: tResponseRequestToken,
        statusCode: 200,
        statusMessage: 'statusMessage'));
    final result = await loginRepository.validateTokenWithLogin(
        login: 'ricardooliver245',
        password: 'Fh587932',
        requestToken: 'b409c24d8ad4595f1bdb096a43c934d328428146');

    final responsResult = result.fold((l) => null, (r) => r);

    expect(
      responsResult,
      RequestTokenModel(
          expiresAt: DateTime.parse('2022-08-05 03:39:17'),
          requestToken: 'b409c24d8ad4595f1bdb096a43c934d328428146'),
    );
  });

  //------------------------------ validateSessionId ------------------------------//

  test('deve retornar um sessionId', () async {
    when(
      () => loginDatasource.validateSessionId(
          requestToken: 'b409c24d8ad4595f1bdb096a43c934d328428146'),
    ).thenAnswer((_) async => HttpClientResponseSuccess(
        data: tResponseSessionId,
        statusCode: 200,
        statusMessage: 'statusMessage'));

    final result = await loginRepository.validateSessionId(
        requestToken: 'b409c24d8ad4595f1bdb096a43c934d328428146');
    final responsResult = result.fold((l) => null, (r) => r);

    expect(
        responsResult,
        const SessionIdModel(
            sessionId: '0ebc8799e32e0b761f9a35ac71299fb2d9752de5'));
  });
}
