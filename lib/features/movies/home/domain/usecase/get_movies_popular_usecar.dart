import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';

class GetMoviesPopularUsecar {
  final HomeRepository _repository;
  GetMoviesPopularUsecar({required HomeRepository repository})
      : _repository = repository;

  Future<Either<Failure, MoviesPageEntipy>> call({required int page}) {
    return _repository.getMoviesPopular(page: page);
  }
}
