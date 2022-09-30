import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/entities/movie_status_entity.dart';

abstract class StatusMoviesRepository {
  Future<Either<Failure, MovieStatusEntity>> getStatusMovies(
      {required int movieId});

  Future<Either<Failure, CheckMovieInMyListWatchedMoviesEntity>>
      checkMovieInMyListWatchedMovies({required int movieId});

  Future<Either<Failure, bool>> addMovieToWatchedMoviesList(
      {required int movieId});

  Future<Either<Failure, bool>> removeMovieToWatchedMoviesList(
      {required int movieId});

  Future<Either<Failure, bool>> addMovieToWatchMoviesList(
      {required int movieId});

  Future<Either<Failure, bool>> removeMovieToWatchMoviesList(
      {required int movieId});
}
