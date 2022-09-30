import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';
import 'package:movies_pop/features/movies_details/domain/repositories/movie_details_repository.dart';

class GetMovieDetailsUsecase {
  final MovieDetailsRepository _movieDetailsRepository;
  GetMovieDetailsUsecase(
      {required MovieDetailsRepository movieDetailsRepository})
      : _movieDetailsRepository = movieDetailsRepository;

  Future<Either<Failure, MovieDetailsEntity>> call(
      {required int movieId}) async {
    return await _movieDetailsRepository.getMovieDetails(movieId: movieId);
  }
}
