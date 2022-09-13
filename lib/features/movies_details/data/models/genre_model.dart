import 'package:movies_pop/features/movies_details/domain/entities/genre_entity.dart';

class GenreModel extends GenreEntity {
  const GenreModel({required int id, required String name})
      : super(id: id, name: name);

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  @override
  String toString() => 'GenreModel(id: $id, name: $name)';
}
