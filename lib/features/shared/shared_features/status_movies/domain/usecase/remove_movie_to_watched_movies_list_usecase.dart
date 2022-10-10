import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/repositories/status_movies_repository.dart';

class RemoveMovieToWatchedMoviesListUsecase {
  final StatusMoviesRepository _statusMoviesRepository;
  RemoveMovieToWatchedMoviesListUsecase(
      {required StatusMoviesRepository statusMoviesRepository})
      : _statusMoviesRepository = statusMoviesRepository;
  Future<Either<Failure, bool>> call({required int movieId}) async {
    return await _statusMoviesRepository.removeMovieToWatchedMoviesList(
        movieId: movieId);
  }
}
