import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic error;
  final int statusCode;

  const Failure({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, error, statusCode];
}

class GenericFailure extends Failure {
  const GenericFailure(
      {required String message, required error, required int statusCode})
      : super(message: message, error: error, statusCode: statusCode);
}
