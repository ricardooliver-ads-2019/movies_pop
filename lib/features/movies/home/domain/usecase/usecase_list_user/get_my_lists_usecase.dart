import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_lists_movies_entity.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';

class GetMyListsUsecase {
  final HomeRepository _homeRepository;
  GetMyListsUsecase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;
  Future<Either<Failure, MyListsMoviesEntity>> call() async {
    return await _homeRepository.getMyLists();
  }
}
