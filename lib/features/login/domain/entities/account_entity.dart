import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final int id;
  final String username;
  const AccountEntity({required this.id, required this.username});

  @override
  List<Object?> get props => [id, username];
}
