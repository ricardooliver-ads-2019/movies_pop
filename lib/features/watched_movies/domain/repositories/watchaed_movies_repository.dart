import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';

abstract class WatchaedMoviesRepository {
  Future<Either<Failure, ListWatchedMoviesEntity>> getListWatchedMovies(
      {required int idList});
}
