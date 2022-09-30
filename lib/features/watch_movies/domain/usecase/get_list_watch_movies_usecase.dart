import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';

import '../repositories/watch_movies_repository.dart';

class GetListWatchMoviesUsecase {
  final WatchMoviesRepository _watchMoviesRopository;
  GetListWatchMoviesUsecase(
      {required WatchMoviesRepository watchMoviesRopository})
      : _watchMoviesRopository = watchMoviesRopository;
  Future<Either<Failure, MoviesPageEntipy>> call(int page) async {
    return await _watchMoviesRopository.getListWatchMovies(page: page);
  }
}
