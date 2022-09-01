import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/fab_button_menu/domain/repositories/fab_button_menu_repository.dart';

class RemoveMovieToWatchedMoviesListUsecase {
  final FabButtonMenuRepository _fabButtonMenuRepository;
  RemoveMovieToWatchedMoviesListUsecase(
      {required FabButtonMenuRepository fabButtonMenuRepository})
      : _fabButtonMenuRepository = fabButtonMenuRepository;
  Future<Either<Failure, bool>> call({required int movieId}) async {
    return await _fabButtonMenuRepository.removeMovieToWatchedMoviesList(
        movieId: movieId);
  }
}
