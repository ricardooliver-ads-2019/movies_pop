import 'package:bloc/bloc.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/features/login/domain/usecase/get_details_account.dart';
import 'package:movies_pop/features/login/domain/usecase/get_request_token_usecase.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_token_with_login_usecase.dart';
import 'package:movies_pop/features/login/presenter/controller/login_state.dart';

import '../../domain/usecase/validate_session_id_usecase.dart';

class LoginCubitController extends Cubit<LoginState> {
  final AuthSession _authSession;
  final GetRequestTokenUsecase _getRequestTokenusecase;
  final ValidateTokenWithLoginUsecase _validateTokenWithLoginUsecase;
  final ValidateSessionIdUsecase _validateSessionIdUsecase;
  final GetDetailsAccountUsecase _getDetailsAccountUsecase;

  LoginCubitController({
    required AuthSession authSession,
    required ValidateTokenWithLoginUsecase validateTokenWithLoginUsecase,
    required GetRequestTokenUsecase getRequestTokenusecase,
    required ValidateSessionIdUsecase validateSessionIdUsecase,
    required GetDetailsAccountUsecase getDetailsAccountUsecase,
    createMyListWatchedMoviesUsecaseL,
  })  : _authSession = authSession,
        _getRequestTokenusecase = getRequestTokenusecase,
        _validateTokenWithLoginUsecase = validateTokenWithLoginUsecase,
        _validateSessionIdUsecase = validateSessionIdUsecase,
        _getDetailsAccountUsecase = getDetailsAccountUsecase,
        super(InitState());

  Future<void> validateTokenWithLogin({
    required String login,
    required String password,
  }) async {
    emit(Loading());
    final result = await _getRequestTokenusecase.call();
    result.fold((error) {
      emit(Error(error: error));
    }, (token) async {
      final result = await _validateTokenWithLoginUsecase.call(
          login: login, password: password, requestToken: token.requestToken);
      result.fold((error) {
        emit(Error(error: error));
      }, (token) {
        validateSessionId(requestToken: token.requestToken);
        emit(ValidateTokenSuccess(token: token));
      });
    });
  }

  Future<void> validateSessionId({required String requestToken}) async {
    emit(Loading());
    final result =
        await _validateSessionIdUsecase.call(requestToken: requestToken);
    result.fold((error) {
      emit(Error(error: error));
    }, (sessionId) {
      _authSession.saveSessionId(sessionId: sessionId.sessionId);

      emit(SessionIdSuccess(sessionId: sessionId));
      getDetailsAccount(sessionId: sessionId.sessionId);
    });
  }

  Future<void> getDetailsAccount({required String sessionId}) async {
    emit(Loading());
    final result = await _getDetailsAccountUsecase.call(sessionId: sessionId);
    result.fold((error) {
      emit(Error(error: error));
    }, (detailsAccount) {
      emit(LoginSuccess(detailsAccount: detailsAccount));
      _authSession.saveDetailsAccount(
          username: detailsAccount.username, id: detailsAccount.id);
    });
  }
}
