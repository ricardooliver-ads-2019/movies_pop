import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';
import 'package:movies_pop/features/shared/models/movie_model/movie_model.dart';

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
      page: pageMoviesJson['page'].toInt(),
      movies: (pageMoviesJson['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList(),
      totalPages: pageMoviesJson['total_pages'].toInt(),
      totalResults: pageMoviesJson['total_results'].toInt(),
    );
  }
}
