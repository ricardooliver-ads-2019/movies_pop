import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies/home/data/models/list_watchaed_movies_Id_model.dart';
import 'package:movies_pop/features/movies/home/data/models/my_lists_movies_model.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/list_watchaed_movies_Id_entity.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_lists_movies_entity.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';
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
        return Left(ErrorNoConnection(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      if (result.statusCode == 404) {
        return Left(ErrorNotFound(
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

    if (result.data == null) {
      return const Left(ErrorInvalidData(
        error: '',
        message: 'Dados não encontrados',
        statusCode: 44,
      ));
    }

    try {
      final results = MoviesPageModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(ErrorInvalidData(
        error: 'Falha de Conversão nos dados recebidos',
        message: 'Dados não encontrados',
        statusCode: 44,
      ));
    }
  }

  @override
  Future<Either<Failure, MoviesPageEntipy>> getMoviesPopular(
      {required int page}) async {
    final result = await _datasource.getMoviesPopular(page: page);

    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(ErrorNoConnection(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      if (result.statusCode == 404) {
        return Left(ErrorNotFound(
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
      final results = MoviesPageModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(ErrorInvalidData(
        error: 'Falha de Conversão nos dados recebidos',
        message: 'Dados não encontrados',
        statusCode: 44,
      ));
    }
  }

  @override
  Future<Either<Failure, ListWatchaedMoviesIdEntity>>
      createMyListWatchedMovies() async {
    final result = await _datasource.createMyListWatchedMovies();
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(ErrorNoConnection(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      if (result.statusCode == 404) {
        return Left(ErrorNotFound(
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
      return const Left(ErrorInvalidData(
        error: 'Falha de Conversão nos dados recebidos',
        message: 'Dados não encontrados',
        statusCode: 44,
      ));
    }
  }

  @override
  Future<Either<Failure, MyListsMoviesEntity>> getMyLists() async {
    final result = await _datasource.getMylists();
    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(ErrorNoConnection(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ));
      }

      if (result.statusCode == 404) {
        return Left(ErrorNotFound(
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
      return const Left(ErrorInvalidData(
        error: 'Falha de Conversão nos dados recebidos',
        message: 'Dados não encontrados',
        statusCode: 44,
      ));
    }
  }
}
