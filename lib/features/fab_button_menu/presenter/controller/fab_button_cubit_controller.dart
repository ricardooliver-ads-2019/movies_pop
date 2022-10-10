import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_state.dart';

import '../../../shared/shared_features/status_movies/domain/usecase/add_movie_to_watch_movies_list_usecase.dart';
import '../../../shared/shared_features/status_movies/domain/usecase/add_movie_to_watched_movies_list_usecase.dart';
import '../../../shared/shared_features/status_movies/domain/usecase/check_movie_in_my_list_watched_movies_usecase.dart';
import '../../../shared/shared_features/status_movies/domain/usecase/get_status_movies_usecase.dart';
import '../../../shared/shared_features/status_movies/domain/usecase/remove_movie_to_watch_movies_list_usecase.dart';
import '../../../shared/shared_features/status_movies/domain/usecase/remove_movie_to_watched_movies_list_usecase.dart';

class FabButtonCubitController extends Cubit<FabButtonState> {
  final GetStatusMoviesUsecase _getStatusMoviesUsecase;
  final CheckMovieInMyListWatchedMoviesUsecase
      _checkMovieInMyListWatchedMoviesUsecase;
  final AddMovieToWatchedMoviesListUsecase _addMovieToWatchedMoviesListUsecase;
  final RemoveMovieToWatchedMoviesListUsecase
      _removeMovieToWatchedMoviesListUsecase;
  final AddMovieToWatchMoviesListUsecase _addMovieToWatchMoviesListUsecase;
  final RemoveMovieToWatchMoviesListUsecase
      _removeMovieToWatchMoviesListUsecase;

  FabButtonCubitController({
    required GetStatusMoviesUsecase getStatusMoviesUsecase,
    required CheckMovieInMyListWatchedMoviesUsecase
        checkMovieInMyListWatchedMoviesUsecase,
    required AddMovieToWatchedMoviesListUsecase
        addMovieToWatchedMoviesListUsecase,
    required RemoveMovieToWatchedMoviesListUsecase
        removeMovieToWatchedMoviesListUsecase,
    required AddMovieToWatchMoviesListUsecase addMovieToWatchMoviesListUsecase,
    required RemoveMovieToWatchMoviesListUsecase
        removeMovieToWatchMoviesListUsecase,
  })  : _getStatusMoviesUsecase = getStatusMoviesUsecase,
        _checkMovieInMyListWatchedMoviesUsecase =
            checkMovieInMyListWatchedMoviesUsecase,
        _addMovieToWatchedMoviesListUsecase =
            addMovieToWatchedMoviesListUsecase,
        _removeMovieToWatchedMoviesListUsecase =
            removeMovieToWatchedMoviesListUsecase,
        _addMovieToWatchMoviesListUsecase = addMovieToWatchMoviesListUsecase,
        _removeMovieToWatchMoviesListUsecase =
            removeMovieToWatchMoviesListUsecase,
        super(InitialFabButtonState());

  Future<void> getStateMovies(int movieId) async {
    emit(LoadingFabButtonState());
    final result = await _getStatusMoviesUsecase.call(movieId: movieId);
    result.fold(
      (error) => emit(ErrorFabButtonState(error: error)),
      (movieStatus) => emit(SuccessFabButtonState(movieStatus: movieStatus)),
    );
  }

  Future<void> checkMovieInMyListWatchedMovies(int movieId) async {
    emit(LoadingFabButtonState());
    final result =
        await _checkMovieInMyListWatchedMoviesUsecase.call(movieId: movieId);
    result.fold(
      (error) => emit(ErrorFabButtonState(error: error)),
      (movieStatus) => emit(SuccessMovieStatusInListWatchedMoviesFabButtonState(
          checkMovieInMyListWatchedMoviesEntity: movieStatus)),
    );
  }

  Future<void> addMovieToWatchedMoviesList(int movieId) async {
    emit(LoadingFabButtonState());
    final result =
        await _addMovieToWatchedMoviesListUsecase.call(movieId: movieId);
    result.fold((error) => emit(ErrorFabButtonState(error: error)),
        (response) => emit(RequestAddMoviesToWatched(response: response)));
  }

  Future<void> removeMovieToWatchedMoviesList(int movieId) async {
    emit(LoadingFabButtonState());
    final result =
        await _removeMovieToWatchedMoviesListUsecase.call(movieId: movieId);
    result.fold((error) => emit(ErrorFabButtonState(error: error)),
        (response) => emit(RequestRemoveMoviesToWatched(response: response)));
  }

  Future<void> addMovieToWatchMoviesList(int movieId) async {
    emit(LoadingFabButtonState());
    final result =
        await _addMovieToWatchMoviesListUsecase.call(movieId: movieId);
    result.fold((error) => emit(ErrorFabButtonState(error: error)),
        (response) => emit(RequestAddMoviesToWatchList(response: response)));
  }

  Future<void> removeMovieToWatchMoviesList({required int movieId}) async {
    emit(LoadingFabButtonState());
    final result = await _removeMovieToWatchMoviesListUsecase.call(movieId);
    result.fold((error) => emit(ErrorFabButtonState(error: error)),
        (response) => emit(RequestRemoveMoviesToWatchList(response: response)));
  }
}
