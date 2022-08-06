import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/login/domain/entities/session_id_entity.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';

class ValidateSessionIdUsecase {
  final ILoginRepository _loginRepository;
  ValidateSessionIdUsecase({required ILoginRepository loginRepository})
      : _loginRepository = loginRepository;

  Future<Either<Failure, SessionIdEntity>> call(
          {required String requestToken}) =>
      _loginRepository.validateSessionId(requestToken: requestToken);
}
