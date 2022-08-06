import 'package:movies_pop/features/login/domain/entities/request_token_entity.dart';

class RequestTokenModel extends RequestTokenEntity {
  const RequestTokenModel({
    required DateTime expiresAt,
    required String requestToken,
  }) : super(
          expiresAt: expiresAt,
          requestToken: requestToken,
        );

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
      expiresAt: DateTime.parse(json['expires_at']),
      requestToken: json['request_token'],
    );
  }

  Map<String, dynamic> toJson() => {'request_token': requestToken};
}
