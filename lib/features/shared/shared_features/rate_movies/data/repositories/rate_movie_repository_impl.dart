import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/shared/shared_features/rate_movies/data/datasources/rate_movie_datasources.dart';
import 'package:movies_pop/features/shared/shared_features/rate_movies/domain/repositories/rate_movie_repository.dart';

class RateMovieRepositoryImpl implements RateMovieRepository {
  final RateMovieDatasources _rateMovieDatasources;
  RateMovieRepositoryImpl({
    required RateMovieDatasources rateMovieDatasources,
  }) : _rateMovieDatasources = rateMovieDatasources;

  @override
  Future<Either<Failure, bool>> rateMovie({
    required int movieId,
    required double rating,
  }) async {
    final result = await _rateMovieDatasources.rateMovie(
      movieId: movieId,
      rating: rating,
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
      return const Left(
        GenericFailure(
          message: 'Erro de conversão',
          error: 'xxRateMoviexx',
          statusCode: 800,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> deleteRatingMovie(
      {required int movieId}) async {
    final result = await _rateMovieDatasources.deleteRatingMovie(
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
      return const Left(
        GenericFailure(
          message: 'Erro de conversão',
          error: 'xxDeleteRatingMoviexx',
          statusCode: 800,
        ),
      );
    }
  }
}
