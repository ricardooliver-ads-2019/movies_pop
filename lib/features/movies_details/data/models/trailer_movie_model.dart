import 'package:movies_pop/features/movies_details/domain/entities/trailer_movie_entity.dart';

class TrailerMovieModel extends TrailerMovieEntity {
  const TrailerMovieModel({
    required String regio,
    required String id,
    required String name,
    required String key,
    required String site,
    required int size,
    required String type,
    required bool official,
  }) : super(
          regio: regio,
          id: id,
          name: name,
          key: key,
          site: site,
          size: size,
          type: type,
          official: official,
        );

  factory TrailerMovieModel.fromMap(Map<String, dynamic> map) {
    return TrailerMovieModel(
      regio: map['iso_3166_1'],
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      key: map['key'] ?? '',
      site: map['site'] ?? '',
      size: map['size']?.toInt() ?? 0,
      type: map['type'] ?? '',
      official: map['official'] ?? false,
    );
  }

  @override
  String toString() {
    return 'TrailerMovieModel( regio: $regio, id: $id, name: $name, key: $key, site: $site, size: $size, type: $type, official: $official)';
  }
}
