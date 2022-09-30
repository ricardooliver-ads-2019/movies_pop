import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';
import 'package:movies_pop/features/login/domain/usecase/get_request_token_usecase.dart';

class MockILoginRepository extends Mock implements ILoginRepository {}

void main() {
  late MockILoginRepository mockRository;
  late GetRequestTokenUsecase usecase;

  setUp(() {
    mockRository = MockILoginRepository();
    usecase = GetRequestTokenUsecase(iLoginRepository: mockRository);
  });
  test(
    'Quando o GetRequestTokenUsecase o Repository deve responder com RequestTokenEntity',
    () async {
      when(() => mockRository.getRequestToken()).thenAnswer((_) async => Right(
          RequestTokenEntity(
              expiresAt: DateTime.parse("2022-08-04 15:19:25"),
              requestToken: "039ad8a2ef1b5636a6bba3351a592a905c801392")));
      final result = await usecase.call();
      expect(
          result,
          Right(
            RequestTokenEntity(
                expiresAt: DateTime.parse("2022-08-04 15:19:25"),
                requestToken: "039ad8a2ef1b5636a6bba3351a592a905c801392"),
          ));
    },
  );
}
