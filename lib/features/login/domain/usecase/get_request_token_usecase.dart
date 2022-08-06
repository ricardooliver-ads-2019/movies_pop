import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';

class GetRequestTokenUsecase {
  final ILoginRepository _iLoginRepository;

  GetRequestTokenUsecase({required ILoginRepository iLoginRepository})
      : _iLoginRepository = iLoginRepository;

  Future<Either<Failure, RequestTokenEntity>> call() {
    return _iLoginRepository.getRequestToken();
  }
}
