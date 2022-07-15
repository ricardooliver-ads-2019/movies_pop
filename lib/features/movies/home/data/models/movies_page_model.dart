import 'package:movies_pop/features/movies/home/data/models/movie_model.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movies_page_entipy/movies_page_entipy.dart';

class MoviesPageModel extends MoviesPageEntipy {
  const MoviesPageModel({
    required int page,
    required List<MovieEntipy> movies,
    required int totalPages,
    required int totalResults,
  }) : super(
          page: page,
          movies: movies,
          totalPages: totalPages,
          totalResults: totalResults,
        );

  factory MoviesPageModel.fromJson(Map<String, dynamic> pageMoviesJson) {
    return MoviesPageModel(
      page: pageMoviesJson['page'],
      movies: (pageMoviesJson['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList(),
      totalPages: pageMoviesJson['totalPages'],
      totalResults: pageMoviesJson['totalResults'],
    );
  }
}
