import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';
import 'package:movies_pop/features/watched_movies/domain/repositories/watchaed_movies_repository.dart';

class GetMyListWatchedMoviesUsecase {
  final WatchaedMoviesRepository _repository;
  GetMyListWatchedMoviesUsecase({required WatchaedMoviesRepository repository})
      : _repository = repository;

  Future<Either<Failure, ListWatchedMoviesEntity>> call(
      {required int idList}) async {
    return await _repository.getListWatchedMovies(idList: idList);
  }
}
