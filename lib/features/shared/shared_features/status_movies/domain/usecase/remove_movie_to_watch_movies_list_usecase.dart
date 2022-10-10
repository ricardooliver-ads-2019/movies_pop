import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/repositories/status_movies_repository.dart';

class RemoveMovieToWatchMoviesListUsecase {
  final StatusMoviesRepository _statusMoviesRepository;
  RemoveMovieToWatchMoviesListUsecase(
      {required StatusMoviesRepository statusMoviesRepository})
      : _statusMoviesRepository = statusMoviesRepository;
  Future<Either<Failure, bool>> call(int movieId) async {
    return await _statusMoviesRepository.removeMovieToWatchMoviesList(
        movieId: movieId);
  }
}
