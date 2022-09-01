import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/models/movie_model/movie_model.dart';
import 'package:movies_pop/features/watched_movies/data/models/tv_model.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';

class ListWatchedMoviesModel extends ListWatchedMoviesEntity {
  const ListWatchedMoviesModel({
    required int id,
    required String name,
    required List<MovieEntipy> listMovies,
  }) : super(
          id: id,
          name: name,
          listMovies: listMovies,
        );

  factory ListWatchedMoviesModel.fromJson(Map<String, dynamic> json) {
    return ListWatchedMoviesModel(
      id: int.parse(json['id']),
      name: json['name'],
      listMovies: (json['items'] as List).map((movie) {
        if (movie['media_type'] == 'movie') {
          return MovieModel.fromJson(movie);
        }
        return TvModel.fromJson(movie);
      }).toList(),
    );
  }
}
