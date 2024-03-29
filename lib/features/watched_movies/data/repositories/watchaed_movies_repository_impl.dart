import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/watched_movies/data/models/list_watched_movies_model.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';
import 'package:movies_pop/features/watched_movies/domain/repositories/watchaed_movies_repository.dart';

import '../datasources/watchaed_movies_datasource.dart';

class WatchaedMoviesRepositoryImpl implements WatchaedMoviesRepository {
  final WatchaedMoviesDatasource _datasource;
  WatchaedMoviesRepositoryImpl({required WatchaedMoviesDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, ListWatchedMoviesEntity>> getListWatchedMovies(
      {required int idList}) async {
    final result = await _datasource.getListWatchedMovies(idList: idList);
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
        error: 'Falha de Conversão nos dados recebidos',
        message: 'Dados não encontrados',
        statusCode: 44,
      ));
    }

    try {
      final results = ListWatchedMoviesModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(ErrorInvalidData(
        message: 'Erro de conversão',
        error: 'xxListWatchedMoviesxx',
        statusCode: 44,
      ));
    }
  }
}
