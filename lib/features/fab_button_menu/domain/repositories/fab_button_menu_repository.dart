import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/fab_button_menu/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';
import 'package:movies_pop/features/fab_button_menu/domain/entities/movie_status_entity.dart';

abstract class FabButtonMenuRepository {
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
