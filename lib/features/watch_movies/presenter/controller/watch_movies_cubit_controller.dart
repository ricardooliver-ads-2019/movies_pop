import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/watch_movies/domain/usecase/get_list_watch_movies_usecase.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_state.dart';

class WatchMoviesCubitController extends Cubit<WatchMoviesState> {
  final GetListWatchMoviesUsecase _usecase;
  WatchMoviesCubitController({required GetListWatchMoviesUsecase usecase})
      : _usecase = usecase,
        super(InitialWatchMoviesState());

  Future<void> getListWatchMovies({required int page}) async {
    emit(LoadingWatchMoviesState());
    final result = await _usecase.call(page);
    result.fold((error) => emit(ErrorWatchMoviesState(error: error)),
        (watchMoviesPage) {
      if (watchMoviesPage.movies.isEmpty) {
        emit(ListIsEmptyWatchMoviesState(moviesPageEntipy: watchMoviesPage));
      } else {
        emit(SuccessWatchMoviesState(moviesPageEntipy: watchMoviesPage));
      }
    });
  }
}
