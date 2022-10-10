import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';

abstract class RateMovieRepository {
  Future<Either<Failure, bool>> rateMovie({
    required int movieId,
    required double rating,
  });

  Future<Either<Failure, bool>> deleteRatingMovie({required int movieId});
}
