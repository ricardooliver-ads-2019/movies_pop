import 'package:movies_pop/features/login/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel({
    required int id,
    required String username,
  }) : super(
          id: id,
          username: username,
        );

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      username: json['username'],
    );
  }
}
