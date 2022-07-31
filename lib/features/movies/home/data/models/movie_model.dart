import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

class MovieModel extends MovieEntipy {
  const MovieModel(
      {required int id,
      required String title,
      required String? posterPath,
      required String? backdropPath,
      required double stars,
      required DateTime releaseDate})
      : super(
          id: id,
          title: title,
          posterPath: posterPath,
          backdropPath: backdropPath,
          stars: stars,
          releaseDate: releaseDate,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      stars: json['vote_average'].toDouble(),
      releaseDate: DateTime.parse(
          json['release_date'] == '' ? '2000-02-02' : json['release_date']),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
        'vote_average': stars,
        'release_date': releaseDate.toString(),
      };
}
