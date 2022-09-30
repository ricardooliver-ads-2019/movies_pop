import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';

class ValidateTokenWithLoginUsecase {
  final ILoginRepository _repository;

  ValidateTokenWithLoginUsecase({required ILoginRepository repository})
      : _repository = repository;

  Future<Either<Failure, RequestTokenEntity>> call({
    required String login,
    required String password,
    required String requestToken,
  }) =>
      _repository.validateTokenWithLogin(
          login: login, password: password, requestToken: requestToken);
}
