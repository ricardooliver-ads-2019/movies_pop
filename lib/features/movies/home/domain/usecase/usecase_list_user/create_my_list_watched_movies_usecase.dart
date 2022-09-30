import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/list_watchaed_movies_Id_entity.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';

class CreateMyListWatchedMoviesUsecase {
  final HomeRepository _homeRepository;

  CreateMyListWatchedMoviesUsecase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<Either<Failure, ListWatchaedMoviesIdEntity>>
      createMyListWatchedMovies() async {
    return await _homeRepository.createMyListWatchedMovies();
  }
}
