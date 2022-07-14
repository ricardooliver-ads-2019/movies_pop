import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';

import '../../entities/movie_entipy/movie_entipy.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MovieEntipy>>> getMoviesPlayingInBrazilNow();
  Future<Either<Failure, List<MovieEntipy>>> getMoviesPopular();
}
