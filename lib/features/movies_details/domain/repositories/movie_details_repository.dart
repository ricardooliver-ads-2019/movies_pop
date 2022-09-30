import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(
      {required int movieId});
}
