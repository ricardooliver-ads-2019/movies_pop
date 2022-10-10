import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/card_details/card_buttons/controller/card_buttons_state.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/entities/movie_status_entity.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/usecase/add_movie_to_watch_movies_list_usecase.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/usecase/add_movie_to_watched_movies_list_usecase.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/usecase/check_movie_in_my_list_watched_movies_usecase.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/usecase/get_status_movies_usecase.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/usecase/remove_movie_to_watch_movies_list_usecase.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/usecase/remove_movie_to_watched_movies_list_usecase.dart';

class CardButtonsCubitController extends Cubit<CardButtonsState> {
  final GetStatusMoviesUsecase _getStatusMoviesUsecase;
  final CheckMovieInMyListWatchedMoviesUsecase
      _checkMovieInMyListWatchedMoviesUsecase;
  final AddMovieToWatchMoviesListUsecase _addMovieToWatchMoviesListUsecase;
  final RemoveMovieToWatchMoviesListUsecase
      _removeMovieToWatchMoviesListUsecase;
  final AddMovieToWatchedMoviesListUsecase _addMovieToWatchedMoviesListUsecase;
  final RemoveMovieToWatchedMoviesListUsecase
      _removeMovieToWatchedMoviesListUsecase;
  CardButtonsCubitController({
    required GetStatusMoviesUsecase getStatusMoviesUsecase,
    required CheckMovieInMyListWatchedMoviesUsecase
        checkMovieInMyListWatchedMoviesUsecase,
    required AddMovieToWatchMoviesListUsecase addMovieToWatchMoviesListUsecase,
    required RemoveMovieToWatchMoviesListUsecase
        removeMovieToWatchMoviesListUsecase,
    required AddMovieToWatchedMoviesListUsecase
        addMovieToWatchedMoviesListUsecase,
    required RemoveMovieToWatchedMoviesListUsecase
        removeMovieToWatchedMoviesListUsecase,
  })  : _getStatusMoviesUsecase = getStatusMoviesUsecase,
        _checkMovieInMyListWatchedMoviesUsecase =
            checkMovieInMyListWatchedMoviesUsecase,
        _addMovieToWatchMoviesListUsecase = addMovieToWatchMoviesListUsecase,
        _removeMovieToWatchMoviesListUsecase =
            removeMovieToWatchMoviesListUsecase,
        _addMovieToWatchedMoviesListUsecase =
            addMovieToWatchedMoviesListUsecase,
        _removeMovieToWatchedMoviesListUsecase =
            removeMovieToWatchedMoviesListUsecase,
        super(InitalStatusMovie());

  Future<void> getStatusMovies(int movieId) async {
    late MovieStatusEntity movieStatus;
    late CheckMovieInMyListWatchedMoviesEntity movieInMyListWatched;
    final getMovieStatus = await _getStatusMoviesUsecase.call(movieId: movieId);

    getMovieStatus.fold((error) => emit(ErrorStatusMovie(error: error)),
        (status) async {
      movieStatus = status;
      final checkMovieInListWatched =
          await _checkMovieInMyListWatchedMoviesUsecase.call(movieId: movieId);
      checkMovieInListWatched
          .fold((error) => emit(ErrorStatusMovie(error: error)),
              (checkMovieInMyListWatched) {
        movieInMyListWatched = checkMovieInMyListWatched;
      });
      emit(SuccessStatusMovie(
          movieStatus: movieStatus,
          movieInMyListWatched: movieInMyListWatched));
    });
  }

  Future<void> addMovieToWatchMoviesList(int movieId) async {
    final result =
        await _addMovieToWatchMoviesListUsecase.call(movieId: movieId);
    result.fold((error) => emit(ErrorStatusMovie(error: error)),
        (response) => emit(RequestAddMoviesToWatchList(response: response)));
  }

  Future<void> removeMovieToWatchMoviesList(int movieId) async {
    final result = await _removeMovieToWatchMoviesListUsecase.call(movieId);
    result.fold((error) => emit(ErrorStatusMovie(error: error)),
        (response) => emit(RequestRemoveMoviesToWatchList(response: response)));
  }

  Future<void> addMovieToWatchedMoviesList(int movieId) async {
    final result =
        await _addMovieToWatchedMoviesListUsecase.call(movieId: movieId);
    result.fold((error) => emit(ErrorStatusMovie(error: error)),
        (response) => emit(RequestAddMoviesToWatched(response: response)));
  }

  Future<void> removeMovieToWatchedMoviesList(int movieId) async {
    final result =
        await _removeMovieToWatchedMoviesListUsecase.call(movieId: movieId);
    result.fold((error) => emit(ErrorStatusMovie(error: error)),
        (response) => emit(RequestRemoveMoviesToWatched(response: response)));
  }
}
