import 'package:equatable/equatable.dart';

class SessionIdEntity extends Equatable {
  final String sessionId;
  const SessionIdEntity({required this.sessionId});

  @override
  List<Object?> get props => [sessionId];
}
