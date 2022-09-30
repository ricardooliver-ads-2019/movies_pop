import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/login/domain/entities/account_entity.dart';
import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';
import 'package:movies_pop/features/login/domain/entities/session_id_entity.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitState extends LoginState {
  @override
  List<Object?> get props => [];
}

class Loading extends LoginState {
  @override
  List<Object?> get props => [];
}

class Error extends LoginState {
  final Failure error;

  Error({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetTokenSuccess extends LoginState {
  final RequestTokenEntity token;

  GetTokenSuccess({
    required this.token,
  });

  @override
  List<Object?> get props => [token];
}

class ValidateTokenSuccess extends LoginState {
  @override
  final RequestTokenEntity token;

  ValidateTokenSuccess({
    required this.token,
  });

  @override
  List<Object?> get props => [token];
}

class SessionIdSuccess extends LoginState {
  final SessionIdEntity sessionId;

  SessionIdSuccess({required this.sessionId});

  @override
  List<Object?> get props => [sessionId];
}

class LoginSuccess extends LoginState {
  final AccountEntity detailsAccount;

  LoginSuccess({required this.detailsAccount});

  @override
  List<Object?> get props => [detailsAccount];
}
