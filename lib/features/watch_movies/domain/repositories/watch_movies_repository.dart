import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';

abstract class WatchMoviesRepository {
  Future<Either<Failure, MoviesPageEntipy>> getListWatchMovies({
    required int page,
  });
}
