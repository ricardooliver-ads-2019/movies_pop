import 'package:equatable/equatable.dart';

class MyListEntipy extends Equatable {
  final int id;
  final String name;
  final String description;
  const MyListEntipy({
    required this.id,
    required this.name,
    required this.description,
  });
  @override
  List<Object?> get props => [id, description, name];
}
