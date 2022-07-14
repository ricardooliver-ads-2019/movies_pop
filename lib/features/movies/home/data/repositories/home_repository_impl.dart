import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies/home/data/models/movie_model.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';

import '../datasources/i_home_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final IHomeDatasource _datasource;
  HomeRepositoryImpl({required IHomeDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, List<MovieEntipy>>>
      getMoviesPlayingInBrazilNow() async {
    final result = await _datasource.getMoviesPlayingInBrazilNow();
    if (result is HttpClientResponseError) {
      return Left(GenericFailure(
          error: result.error,
          message: result.message,
          statusCode: result.statusCode));
    }
    try {
      final results = result.data['results'];

      if (results == null) {
        return const Left(GenericFailure(
            error: 'Lista de filmes vazia',
            message: 'Erro ao buscar lista de filmes',
            statusCode: 000));
      }

      try {
        return Right(
            results.map<MovieModel>((f) => MovieModel.fromJson(f)).toList);
      } catch (e) {
        return const Left(GenericFailure(
            message: 'Erro de converção', error: 'Erro', statusCode: 500));
      }
    } on Exception {
      return const Left(
          GenericFailure(error: 'Erro', message: 'Ferrou', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntipy>>> getMoviesPopular() {
    // TODO: implement getMoviesPopular
    throw UnimplementedError();
  }
}
