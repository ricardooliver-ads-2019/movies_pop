import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies_details/data/datasources/movie_details_datasources.dart';
import 'package:movies_pop/features/movies_details/data/models/movie_details_model.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';
import 'package:movies_pop/features/movies_details/domain/repositories/movie_details_repository.dart';

import '../../../../core/network/http_client_response.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsDatasources _movieDetailsDatasources;
  MovieDetailsRepositoryImpl(
      {required MovieDetailsDatasources movieDetailsDatasources})
      : _movieDetailsDatasources = movieDetailsDatasources;

  @override
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(
      {required int movieId}) async {
    final result =
        await _movieDetailsDatasources.getMovieDetails(movieId: movieId);
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
      final results = MovieDetailsModel.fromMap(result.data);
      return Right(results);
    } catch (e) {
      return const Left(GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMovieDetailsxx',
          statusCode: 500));
    }
  }
}
