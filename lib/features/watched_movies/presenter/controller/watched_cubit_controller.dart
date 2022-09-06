import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/user_lists_watched_movies/details_list_watched_movies.dart';
import 'package:movies_pop/features/login/presenter/controller/login_state.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';
import 'package:movies_pop/features/watched_movies/domain/usecase/get_my_list_watched_movies_usecase.dart';

part 'watched_state.dart';

class WatchedCubitController extends Cubit<WatchedState> {
  final DetailsListWatchedMovies detailsListWatchedMovies;
  final GetMyListWatchedMoviesUsecase _getMyListWatchedMoviesUsecase;

  WatchedCubitController({
    required this.detailsListWatchedMovies,
    required GetMyListWatchedMoviesUsecase getMyListWatchedMoviesUsecase,
  })  : _getMyListWatchedMoviesUsecase = getMyListWatchedMoviesUsecase,
        super(InitialWatchedState());

  Future<void> getMyListWatchedMovies() async {
    emit(LoadingWatchedState());
    if (detailsListWatchedMovies.idList != null) {
      final result = await _getMyListWatchedMoviesUsecase.call(
          idList: detailsListWatchedMovies.idList!);
      result.fold((error) => emit(ErrorWatchedState(error: error)),
          (myListMoviesWatched) {
        emit(SucccessWatchedState(myListMoviesWatched: myListMoviesWatched));
      });
    }
  }
}
