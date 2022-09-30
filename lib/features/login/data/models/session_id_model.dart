import 'package:movies_pop/features/login/domain/entities/session_id_entity.dart';

class SessionIdModel extends SessionIdEntity {
  const SessionIdModel({required String sessionId})
      : super(sessionId: sessionId);

  factory SessionIdModel.fronJson(Map<String, dynamic> json) {
    return SessionIdModel(sessionId: json['session_id']);
  }

  Map<String, dynamic> toJson() => {'session_id': sessionId};
}
