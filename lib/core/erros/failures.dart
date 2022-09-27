import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final dynamic error;
  final int? statusCode;

  const Failure({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, error, statusCode];
}

class GenericFailure extends Failure {
  const GenericFailure({
    required String? message,
    required dynamic error,
    required int? statusCode,
  }) : super(message: message, error: error, statusCode: statusCode);
}

class ErrorNoConnection extends Failure {
  const ErrorNoConnection({
    required String? message,
    required dynamic error,
    required int? statusCode,
  }) : super(
          message: message,
          error: error,
          statusCode: statusCode,
        );
}

class UnauthorizedUser extends Failure {
  const UnauthorizedUser({
    required String? message,
    required dynamic error,
    required int? statusCode,
  }) : super(
          message: message,
          error: error,
          statusCode: statusCode,
        );
}

class ErrorInvalidData extends Failure {
  const ErrorInvalidData({
    required String? message,
    required dynamic error,
    required int? statusCode,
  }) : super(
          message: message,
          error: error,
          statusCode: statusCode,
        );
}

class ErrorNotFound extends Failure {
  const ErrorNotFound({
    required String? message,
    required dynamic error,
    required int? statusCode,
  }) : super(
          message: message,
          error: error,
          statusCode: statusCode,
        );
}
