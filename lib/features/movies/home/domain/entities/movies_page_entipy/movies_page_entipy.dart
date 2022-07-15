import 'package:equatable/equatable.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

class MoviesPageEntipy extends Equatable {
  const MoviesPageEntipy({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });
  final int page;
  final List<MovieEntipy> movies;
  final int totalPages;
  final int totalResults;

  @override
  List<Object?> get props => [page, movies, totalPages, totalResults];
}
