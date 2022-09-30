import 'package:equatable/equatable.dart';

class RequestTokenEntity extends Equatable {
  final DateTime expiresAt;
  final String requestToken;
  const RequestTokenEntity({
    required this.expiresAt,
    required this.requestToken,
  });
  @override
  List<Object?> get props => [expiresAt, requestToken];
}
