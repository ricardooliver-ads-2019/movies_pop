import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies/home/data/models/list_watchaed_movies_Id_model.dart';
import 'package:movies_pop/features/movies/home/data/models/my_lists_movies_model.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/list_watchaed_movies_Id_entity.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_lists_movies_entity.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';
import 'package:movies_pop/features/shared/models/movie_model/movie_model.dart';
import 'package:movies_pop/features/shared/models/movies_page_model/movies_page_model.dart';

import '../datasources/i_home_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final IHomeDatasource _datasource;
  HomeRepositoryImpl({required IHomeDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, MoviesPageEntipy>> getMoviesPlayingInBrazilNow(
      {required int page}) async {
    final result = await _datasource.getMoviesPlayingInBrazilNow(page: page);

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

    if ((result.data == null) || (result.data['results'] as List).isEmpty) {
      return const Left(GenericFailure(
        error: 'Lista de filmes vazia',
        message: 'Erro ao buscar lista de filmes',
        statusCode: 54,
      ));
    }

    try {
      final movies = MovieModel.fromJson(result.data['results'][0]);
    } catch (e) {
      return const Left(GenericFailure(
        message: 'Erro de conversão nos filmes',
        error: 'XXFilmeXX',
        statusCode: 300,
      ));
    }

    try {
      final results = MoviesPageModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, MoviesPageEntipy>> getMoviesPopular(
      {required int page}) async {
    final result = await _datasource.getMoviesPopular(page: page);

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

    if ((result.data == null) || (result.data['results'] as List).isEmpty) {
      return const Left(GenericFailure(
        error: 'Lista de filmes vazia',
        message: 'Erro ao buscar lista de filmes',
        statusCode: 000,
      ));
    }

    try {
      final results = MoviesPageModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ListWatchaedMoviesIdEntity>>
      createMyListWatchedMovies() async {
    final result = await _datasource.createMyListWatchedMovies();
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
      final results = ListWatchaedMoviesIdModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMyListsMoviesxx',
          statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, MyListsMoviesEntity>> getMyLists() async {
    final result = await _datasource.getMylists();
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
      final results = MyListsMoviesModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMyListsMoviesxx',
          statusCode: 500));
    }
  }
}
