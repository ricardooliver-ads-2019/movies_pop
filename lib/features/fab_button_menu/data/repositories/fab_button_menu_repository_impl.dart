import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/fab_button_menu/data/datasources/fab_button_menu_datasources.dart';
import 'package:movies_pop/features/fab_button_menu/data/models/check_movie_In_my_list_watched_movies_model.dart';
import 'package:movies_pop/features/fab_button_menu/data/models/movie_status_model.dart';
import 'package:movies_pop/features/fab_button_menu/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';
import 'package:movies_pop/features/fab_button_menu/domain/entities/movie_status_entity.dart';
import 'package:movies_pop/features/fab_button_menu/domain/repositories/fab_button_menu_repository.dart';

class FabButtonMenuRepositoryImpl implements FabButtonMenuRepository {
  final FabButtonMenuDatasources _fabButtonMenuDatasources;
  FabButtonMenuRepositoryImpl(
      {required FabButtonMenuDatasources fabButtonMenuDatasources})
      : _fabButtonMenuDatasources = fabButtonMenuDatasources;

  @override
  Future<Either<Failure, MovieStatusEntity>> getStatusMovies(
      {required int movieId}) async {
    final result =
        await _fabButtonMenuDatasources.getStatusMovies(movieId: movieId);

    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      final results = MovieStatusModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, CheckMovieInMyListWatchedMoviesEntity>>
      checkMovieInMyListWatchedMovies({required int movieId}) async {
    final result = await _fabButtonMenuDatasources
        .checkMovieInMyListWatchedMovies(movieId: movieId);

    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      final results =
          CheckMovieInMyListWatchedMoviesModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> addMovieToWatchedMoviesList(
      {required int movieId}) async {
    final result = await _fabButtonMenuDatasources.addMovieToWatchedMoviesList(
        movieId: movieId);
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      if (result.data['success'] == false) {
        return Right(result.data['success']);
      }
      return Right(result.data['success']);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> removeMovieToWatchedMoviesList(
      {required int movieId}) async {
    final result = await _fabButtonMenuDatasources
        .removeMovieToWatchedMoviesList(movieId: movieId);
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      if (result.data['success'] == false) {
        return Right(result.data['success']);
      }
      return Right(result.data['success']);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> addMovieToWatchMoviesList({
    required int movieId,
  }) async {
    final result = await _fabButtonMenuDatasources.addMovieToWatchMoviesList(
        movieId: movieId);
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      if (result.data['success'] == false) {
        return Right(result.data['success']);
      }
      return Right(result.data['success']);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> removeMovieToWatchMoviesList(
      {required int movieId}) async {
    final result = await _fabButtonMenuDatasources.removeMovieToWatchMoviesList(
      movieId: movieId,
    );
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      return Left(GenericFailure(
        error: result.data,
        message: result.statusMessage,
        statusCode: result.statusCode,
      ));
    }

    try {
      if (result.data['success'] == false) {
        return Right(result.data['success']);
      }
      return Right(result.data['success']);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500));
    }
  }
}
