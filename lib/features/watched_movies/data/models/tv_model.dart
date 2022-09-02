import 'package:movies_pop/features/watched_movies/domain/entities/tv_entity.dart';

class TvModel extends TvEntity {
  const TvModel({
    required String? backdropPath,
    required int id,
    required String name,
    required String? posterPath,
    required double stars,
    required String mediaType,
  }) : super(
          backdropPath: backdropPath,
          id: id,
          name: name,
          posterPath: posterPath,
          stars: stars,
          mediaType: mediaType,
        );
  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      stars: json['vote_average'].toDouble(),
      mediaType: json['media_type'],
    );
  }
}
