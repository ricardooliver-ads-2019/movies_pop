import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';

import '../repositories/home/home_repository.dart';

class GetMoviesPlayingInBrazilNowUsecase {
  final HomeRepository _repository;

  GetMoviesPlayingInBrazilNowUsecase({required HomeRepository repository})
      : _repository = repository;

  Future<Either<Failure, MoviesPageEntipy>> call({required int page}) async {
    return await _repository.getMoviesPlayingInBrazilNow(page: page);
  }
}
