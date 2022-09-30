import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/repositories/status_movies_repository.dart';

class CheckMovieInMyListWatchedMoviesUsecase {
  final StatusMoviesRepository _statusMoviesRepository;
  CheckMovieInMyListWatchedMoviesUsecase(
      {required StatusMoviesRepository statusMoviesRepository})
      : _statusMoviesRepository = statusMoviesRepository;

  Future<Either<Failure, CheckMovieInMyListWatchedMoviesEntity>> call(
      {required int movieId}) async {
    return await _statusMoviesRepository.checkMovieInMyListWatchedMovies(
        movieId: movieId);
  }
}
