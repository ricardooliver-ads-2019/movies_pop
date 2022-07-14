import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

import '../repositories/home/home_repository.dart';

class GetMoviesPlayingInBrazilNowUsecase {
  final HomeRepository _repository;

  GetMoviesPlayingInBrazilNowUsecase({required HomeRepository repository})
      : _repository = repository;

  Future<Either<Failure, List<MovieEntipy>>> call() async {
    return await _repository.getMoviesPlayingInBrazilNow();
  }
}
