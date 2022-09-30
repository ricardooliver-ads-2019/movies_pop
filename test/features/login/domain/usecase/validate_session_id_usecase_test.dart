import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/features/login/domain/entities/session_id_entity.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_session_id_usecase.dart';

class MockILoginRepository extends Mock implements ILoginRepository {}

void main() {
  late ValidateSessionIdUsecase usecase;
  late ILoginRepository loginRepository;

  setUp(() {
    loginRepository = MockILoginRepository();
    usecase = ValidateSessionIdUsecase(loginRepository: loginRepository);
  });
  test('deve responder com um SessionEntity', () async {
    when(
      () => loginRepository.validateSessionId(
          requestToken: 'b409c24d8ad4595f1bdb096a43c934d328428146'),
    ).thenAnswer((_) async => const Right(SessionIdEntity(
        sessionId: '22ffe1dbe668ecfa90bc972e62d860b420133237')));

    final result = await usecase.call(
        requestToken: 'b409c24d8ad4595f1bdb096a43c934d328428146');

    final responsSessionId = result.fold((l) => null, (r) => r);

    expect(
      responsSessionId,
      const SessionIdEntity(
          sessionId: '22ffe1dbe668ecfa90bc972e62d860b420133237'),
    );
  });
}
