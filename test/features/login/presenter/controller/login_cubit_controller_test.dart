import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/login/domain/entities/account_entity.dart';
import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';
import 'package:movies_pop/features/login/domain/entities/session_id_entity.dart';
import 'package:movies_pop/features/login/domain/usecase/get_details_account.dart';
import 'package:movies_pop/features/login/domain/usecase/get_request_token_usecase.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_session_id_usecase.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_token_with_login_usecase.dart';
import 'package:movies_pop/features/login/presenter/controller/login_cubit_controller.dart';
import 'package:movies_pop/features/login/presenter/controller/login_state.dart';

class MockAuthSession extends Mock implements AuthSession {}

class MockValidateTokenWithLoginUsecase extends Mock
    implements ValidateTokenWithLoginUsecase {}

class MockValidateSessionIdUsecase extends Mock
    implements ValidateSessionIdUsecase {}

class MockGetRequestTokenUsecase extends Mock
    implements GetRequestTokenUsecase {}

class MockGetDetailsAccountUsecase extends Mock
    implements GetDetailsAccountUsecase {}

void main() {
  late AuthSession authSession;
  late ValidateTokenWithLoginUsecase validateTokenWithLoginUsecase;
  late ValidateSessionIdUsecase validateSessionIdUsecase;
  late GetRequestTokenUsecase getRequestTokenusecase;
  late GetDetailsAccountUsecase getDetailsAccountUsecase;

  late LoginCubitController cubitController;

  late RequestTokenEntity requestTokenSuccess;
  late SessionIdEntity sessionIdEntity;
  late AccountEntity detailsAccount;
  late Failure error;

  setUp(() {
    authSession = MockAuthSession();
    validateTokenWithLoginUsecase = MockValidateTokenWithLoginUsecase();
    validateSessionIdUsecase = MockValidateSessionIdUsecase();
    getRequestTokenusecase = MockGetRequestTokenUsecase();
    getDetailsAccountUsecase = MockGetDetailsAccountUsecase();
    cubitController = LoginCubitController(
      authSession: authSession,
      validateTokenWithLoginUsecase: validateTokenWithLoginUsecase,
      getRequestTokenusecase: getRequestTokenusecase,
      validateSessionIdUsecase: validateSessionIdUsecase,
      getDetailsAccountUsecase: getDetailsAccountUsecase,
    );
    requestTokenSuccess = RequestTokenEntity(
      expiresAt: DateTime.parse("2022-08-04 15:19:25"),
      requestToken: "039ad8a2ef1b5636a6bba3351a592a905c801392",
    );

    sessionIdEntity = const SessionIdEntity(
        sessionId: '039ad8a2ef1b5636a6bba3351a592a905c801392');

    detailsAccount = const AccountEntity(id: 4554, username: 'logintest');

    error = const UnauthorizedUser(
      error: 'UnauthorizedUser',
      message: 'Login ou senha incorreto!',
      statusCode: 403,
    );
  });

  tearDown(() => cubitController.close());

  blocTest<LoginCubitController, LoginState>(
    ' Deve retonar um estado de sucesso ...',
    build: () {
      when(() => getRequestTokenusecase.call()).thenAnswer(
        (_) async => Right(requestTokenSuccess),
      );

      when(
        () => validateTokenWithLoginUsecase.call(
          login: 'logintest',
          password: 'abc123456',
          requestToken: requestTokenSuccess.requestToken,
        ),
      ).thenAnswer((_) async => Right(requestTokenSuccess));

      when(
        () => validateSessionIdUsecase.call(
          requestToken: requestTokenSuccess.requestToken,
        ),
      ).thenAnswer((_) async => Right(sessionIdEntity));

      when(() => getDetailsAccountUsecase.call(
              sessionId: sessionIdEntity.sessionId))
          .thenAnswer((_) async => Right(detailsAccount));

      when(() => authSession.saveDetailsAccount(
          username: any(named: 'username'),
          id: any(named: 'id'))).thenAnswer((_) async => Future.value());

      when(() => authSession.saveSessionId(
              sessionId: '039ad8a2ef1b5636a6bba3351a592a905c801392'))
          .thenAnswer((_) async => Future.value());

      when(() => authSession.init()).thenAnswer((_) async => Future.value());

      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.validateTokenWithLogin(
        login: 'logintest',
        password: 'abc123456',
      );
    },
    expect: () => [
      Loading(),
      ValidateTokenSuccess(token: requestTokenSuccess),
      SessionIdSuccess(sessionId: sessionIdEntity),
      Loading(),
      LoginSuccess(detailsAccount: detailsAccount),
    ],
  );

  blocTest<LoginCubitController, LoginState>(
    ' Deve retonar um estado de Erro...',
    build: () {
      when(() => getRequestTokenusecase.call()).thenAnswer(
        (_) async => Right(requestTokenSuccess),
      );

      when(
        () => validateTokenWithLoginUsecase.call(
          login: 'logintes',
          password: '123456',
          requestToken: requestTokenSuccess.requestToken,
        ),
      ).thenAnswer((_) async => Left(error));

      return cubitController;
    },
    act: (cubitController) async {
      final result = await cubitController.validateTokenWithLogin(
        login: 'logintes',
        password: '123456',
      );
    },
    expect: () => [
      Loading(),
      Error(error: error),
    ],
  );
}
