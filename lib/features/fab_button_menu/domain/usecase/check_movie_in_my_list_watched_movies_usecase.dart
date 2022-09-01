import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/fab_button_menu/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';
import 'package:movies_pop/features/fab_button_menu/domain/repositories/fab_button_menu_repository.dart';

class CheckMovieInMyListWatchedMoviesUsecase {
  final FabButtonMenuRepository _fabButtonMenuRepository;
  CheckMovieInMyListWatchedMoviesUsecase(
      {required FabButtonMenuRepository fabButtonMenuRepository})
      : _fabButtonMenuRepository = fabButtonMenuRepository;

  Future<Either<Failure, CheckMovieInMyListWatchedMoviesEntity>> call(
      {required int movieId}) async {
    return await _fabButtonMenuRepository.checkMovieInMyListWatchedMovies(
        movieId: movieId);
  }
}
