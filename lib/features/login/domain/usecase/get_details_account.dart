import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';

import '../entities/account_entity.dart';

class GetDetailsAccountUsecase {
  final ILoginRepository _loginRepository;

  GetDetailsAccountUsecase({required ILoginRepository loginRepository})
      : _loginRepository = loginRepository;

  Future<Either<Failure, AccountEntity>> call({required String sessionId}) =>
      _loginRepository.getDetailsAccount(sessionId: sessionId);
}
