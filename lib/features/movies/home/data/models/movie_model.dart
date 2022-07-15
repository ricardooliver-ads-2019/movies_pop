import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

class MovieModel extends MovieEntipy {
  const MovieModel(
      {required int id,
      required String title,
      required String? posterPath,
      required double stars,
      required DateTime releaseDate})
      : super(
          id: id,
          title: title,
          posterPath: posterPath,
          stars: stars,
          releaseDate: releaseDate,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['title'],
        posterPath: json['poster_path'],
        stars: json['vote_average'],
        releaseDate: DateTime.parse(json['release_date']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'poster_path': posterPath,
        'vote_average': stars,
        'release_date': releaseDate.toString(),
      };
}
