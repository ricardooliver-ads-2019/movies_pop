import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/repositories/status_movies_repository.dart';

class AddMovieToWatchedMoviesListUsecase {
  final StatusMoviesRepository _statusMoviesRepository;
  AddMovieToWatchedMoviesListUsecase(
      {required StatusMoviesRepository statusMoviesRepository})
      : _statusMoviesRepository = statusMoviesRepository;
  Future<Either<Failure, bool>> call({required int movieId}) async {
    return await _statusMoviesRepository.addMovieToWatchedMoviesList(
        movieId: movieId);
  }
}
