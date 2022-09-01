import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/fab_button_menu/domain/entities/movie_status_entity.dart';
import 'package:movies_pop/features/fab_button_menu/domain/repositories/fab_button_menu_repository.dart';

class GetStatusMoviesUsecase {
  final FabButtonMenuRepository _fabButtonMenuRepository;

  GetStatusMoviesUsecase(
      {required FabButtonMenuRepository fabButtonMenuRepository})
      : _fabButtonMenuRepository = fabButtonMenuRepository;

  Future<Either<Failure, MovieStatusEntity>> call(
      {required int movieId}) async {
    return await _fabButtonMenuRepository.getStatusMovies(movieId: movieId);
  }
}
