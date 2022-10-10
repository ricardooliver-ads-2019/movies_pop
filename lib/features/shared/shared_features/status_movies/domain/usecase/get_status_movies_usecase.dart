import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/entities/movie_status_entity.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/repositories/status_movies_repository.dart';

class GetStatusMoviesUsecase {
  final StatusMoviesRepository _statusMoviesRepository;

  GetStatusMoviesUsecase(
      {required StatusMoviesRepository statusMoviesRepository})
      : _statusMoviesRepository = statusMoviesRepository;

  Future<Either<Failure, MovieStatusEntity>> call(
      {required int movieId}) async {
    return await _statusMoviesRepository.getStatusMovies(movieId: movieId);
  }
}
