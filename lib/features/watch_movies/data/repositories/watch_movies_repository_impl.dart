import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';
import 'package:movies_pop/features/shared/models/movies_page_model/movies_page_model.dart';
import 'package:movies_pop/features/watch_movies/domain/repositories/watch_movies_repository.dart';

import '../datasources/watch_movies_datasources.dart';

class WatchMoviesRepositoryImpl implements WatchMoviesRepository {
  final WatchMoviesDatasources _watchMoviesDatasources;
  WatchMoviesRepositoryImpl(
      {required WatchMoviesDatasources watchMoviesDatasources})
      : _watchMoviesDatasources = watchMoviesDatasources;

  @override
  Future<Either<Failure, MoviesPageEntipy>> getListWatchMovies(
      {required int page}) async {
    final result = await _watchMoviesDatasources.getListWatchMovies(page: page);

    if (result is HttpClientResponseError) {
      if (result.statusCode == 0) {
        return Left(
          ErrorNoConnection(
            error: result.data,
            message: result.statusMessage,
            statusCode: result.statusCode,
          ),
        );
      }

      if (result.statusCode == 404) {
        return Left(
          ErrorNotFound(
            error: result.data,
            message: result.statusMessage,
            statusCode: result.statusCode,
          ),
        );
      }

      return Left(
        GenericFailure(
          error: result.data,
          message: result.statusMessage,
          statusCode: result.statusCode,
        ),
      );
    }

    if (result.data == null) {
      return const Left(
        ErrorInvalidData(
          error: '',
          message: 'Dados não encontrados',
          statusCode: 44,
        ),
      );
    }

    try {
      final results = MoviesPageModel.fromJson(result.data);
      return Right(results);
    } catch (e) {
      return const Left(
        ErrorInvalidData(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 44,
        ),
      );
    }
  }
}
