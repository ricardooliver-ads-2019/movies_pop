import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_token_with_login_usecase.dart';

class MockILoginRepository extends Mock implements ILoginRepository {}

void main() {
  late ILoginRepository loginRepository;
  late ValidateTokenWithLoginUsecase usecase;
  setUp(() {
    loginRepository = MockILoginRepository();
    usecase = ValidateTokenWithLoginUsecase(repository: loginRepository);
  });
  test(
      'Quando validateTokenWithLoginUsecase for chamado deve retornar um RequestToken Validado',
      () async {
    when(() => loginRepository.validateTokenWithLogin(
              login: 'ricardooliver245',
              password: 'Fh587932',
              requestToken: '039ad8a2ef1b5636a6bba3351a592a905c801392',
            ))
        .thenAnswer((invocation) async => Right(RequestTokenEntity(
            expiresAt: DateTime.parse('2022-08-04 14:41:10'),
            requestToken: '039ad8a2ef1b5636a6bba3351a592a905c801392')));

    final result = await usecase(
      login: 'ricardooliver245',
      password: 'Fh587932',
      requestToken: '039ad8a2ef1b5636a6bba3351a592a905c801392',
    );

    expect(
        result,
        Right(RequestTokenEntity(
            expiresAt: DateTime.parse('2022-08-04 14:41:10'),
            requestToken: '039ad8a2ef1b5636a6bba3351a592a905c801392')));
  });
}
