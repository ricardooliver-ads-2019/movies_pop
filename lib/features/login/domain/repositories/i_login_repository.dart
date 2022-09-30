import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/login/domain/entities/account_entity.dart';
import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';
import 'package:movies_pop/features/login/domain/entities/session_id_entity.dart';

abstract class ILoginRepository {
  Future<Either<Failure, RequestTokenEntity>> getRequestToken();

  Future<Either<Failure, RequestTokenEntity>> validateTokenWithLogin({
    required String login,
    required String password,
    required String requestToken,
  });

  Future<Either<Failure, SessionIdEntity>> validateSessionId(
      {required String requestToken});

  Future<Either<Failure, AccountEntity>> getDetailsAccount(
      {required String sessionId});
}
