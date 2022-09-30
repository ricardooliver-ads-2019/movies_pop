import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';

import '../repositories/rate_movie_repository.dart';

class RateMovieUsecase {
  final RateMovieRepository _rateMovieRepository;
  RateMovieUsecase({required RateMovieRepository rateMovieRepository})
      : _rateMovieRepository = rateMovieRepository;

  Future<Either<Failure, bool>> call(
      {required int movieId, required double rating}) async {
    return await _rateMovieRepository.rateMovie(
      movieId: movieId,
      rating: rating,
    );
  }
}
