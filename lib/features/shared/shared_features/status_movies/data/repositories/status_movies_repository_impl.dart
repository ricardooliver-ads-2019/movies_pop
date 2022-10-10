import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/data/datasources/status_movies_datasources.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/data/models/check_movie_In_my_list_watched_movies_model.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/data/models/movie_status_model.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/entities/movie_status_entity.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/repositories/status_movies_repository.dart';

class StatusMoviesRepositoryImpl implements StatusMoviesRepository {
  final StatusMoviesDatasources _statusMoviesDatasources;
  StatusMoviesRepositoryImpl(
      {required StatusMoviesDatasources statusMoviesDatasources})
      : _statusMoviesDatasources = statusMoviesDatasources;

  @override
  Future<Either<Failure, MovieStatusEntity>> getStatusMovies(
      {required int movieId}) async {
    final result =
        await _statusMoviesDatasources.getStatusMovies(movieId: movieId);

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
    final result = await _statusMoviesDatasources
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
    final result = await _statusMoviesDatasources.addMovieToWatchedMoviesList(
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
    final result = await _statusMoviesDatasources
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
    final result = await _statusMoviesDatasources.addMovieToWatchMoviesList(
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
    final result = await _statusMoviesDatasources.removeMovieToWatchMoviesList(
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
