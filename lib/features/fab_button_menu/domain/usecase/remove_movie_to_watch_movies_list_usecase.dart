import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/fab_button_menu/domain/repositories/fab_button_menu_repository.dart';

class RemoveMovieToWatchMoviesListUsecase {
  final FabButtonMenuRepository _fabButtonMenuRepository;
  RemoveMovieToWatchMoviesListUsecase(
      {required FabButtonMenuRepository fabButtonMenuRepository})
      : _fabButtonMenuRepository = fabButtonMenuRepository;
  Future<Either<Failure, bool>> call(int movieId) async {
    return await _fabButtonMenuRepository.removeMovieToWatchMoviesList(
        movieId: movieId);
  }
}
