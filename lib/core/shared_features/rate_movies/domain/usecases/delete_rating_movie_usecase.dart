import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/shared_features/rate_movies/domain/repositories/rate_movie_repository.dart';

class DeleteRatingMovieUsecase {
  final RateMovieRepository _rateMovieRepository;
  DeleteRatingMovieUsecase({required RateMovieRepository rateMovieRepository})
      : _rateMovieRepository = rateMovieRepository;

  Future<Either<Failure, bool>> call({required int movieId}) async {
    return await _rateMovieRepository.deleteRatingMovie(movieId: movieId);
  }
}
