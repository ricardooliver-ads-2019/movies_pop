import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';

class TvEntity extends MovieEntipy {
  final String mediaType;
  const TvEntity({
    required String? backdropPath,
    required int id,
    required String name,
    required String? posterPath,
    required double stars,
    required this.mediaType,
  }) : super(
          backdropPath: backdropPath,
          id: id,
          title: name,
          posterPath: posterPath,
          stars: stars,
          releaseDate: null,
        );
  @override
  List<Object?> get props =>
      [id, backdropPath, title, posterPath, stars, releaseDate];
}
