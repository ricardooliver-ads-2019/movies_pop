import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/login/data/datasources/i_login_datasources.dart';
import 'package:movies_pop/features/login/data/models/account_model.dart';
import 'package:movies_pop/features/login/data/models/request_token_model.dart';
import 'package:movies_pop/features/login/data/models/session_id_model.dart';
import 'package:movies_pop/features/login/domain/entities/account_entity.dart';
import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';
import 'package:movies_pop/features/login/domain/entities/session_id_entity.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final ILoginDatasources _loginDatasources;
  LoginRepositoryImpl({required ILoginDatasources loginDatasources})
      : _loginDatasources = loginDatasources;
  @override
  Future<Either<Failure, RequestTokenEntity>> getRequestToken() async {
    final result = await _loginDatasources.getRequestToken();
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }
      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      final results = RequestTokenModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(
        GenericFailure(
          message: 'Erro de conversão',
          error: 'xxRequestTokenxx',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, RequestTokenEntity>> validateTokenWithLogin({
    required String login,
    required String password,
    required String requestToken,
  }) async {
    final result = await _loginDatasources.validateTokenWithLogin(
        login: login, password: password, requestToken: requestToken);
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }
      if (result.statusCode == 401) {
        return Left(UnauthorizedUser(
          error: result.statusMessage,
          message: 'Login inválido: usuário ou senha inválidos',
          statusCode: result.statusCode,
        ));
      }
      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      final results = RequestTokenModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(
        GenericFailure(
          message: 'Erro de conversão',
          error: 'xxRequestTokenxx',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SessionIdEntity>> validateSessionId(
      {required String requestToken}) async {
    final result =
        await _loginDatasources.validateSessionId(requestToken: requestToken);
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }
      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      final results = SessionIdModel.fronJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(
        GenericFailure(
          message: 'Erro de conversão',
          error: 'xxRequestTokenxx',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> getDetailsAccount(
      {required String sessionId}) async {
    final result =
        await _loginDatasources.getDetailsAccount(sessionId: sessionId);
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }
      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      final results = AccountModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(
        GenericFailure(
          message: 'Erro de conversão',
          error: 'xxAccountXX',
          statusCode: 500,
        ),
      );
    }
  }
}
