import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/fab_button_menu/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';

import '../../domain/entities/movie_status_entity.dart';

class FabButtonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialFabButtonState extends FabButtonState {
  @override
  List<Object?> get props => [];
}

class LoadingFabButtonState extends FabButtonState {
  @override
  List<Object?> get props => [];
}

class SuccessFabButtonState extends FabButtonState {
  final MovieStatusEntity movieStatus;

  SuccessFabButtonState({required this.movieStatus});

  @override
  List<Object?> get props => [movieStatus];
}

class SuccessMovieStatusInListWatchedMoviesFabButtonState
    extends FabButtonState {
  final CheckMovieInMyListWatchedMoviesEntity
      checkMovieInMyListWatchedMoviesEntity;

  SuccessMovieStatusInListWatchedMoviesFabButtonState(
      {required this.checkMovieInMyListWatchedMoviesEntity});
  @override
  List<Object?> get props => [checkMovieInMyListWatchedMoviesEntity];
}

class RequestAddMoviesToWatched extends FabButtonState {
  final bool response;
  RequestAddMoviesToWatched({required this.response});
  @override
  List<Object?> get props => [response];
}

class RequestRemoveMoviesToWatched extends FabButtonState {
  final bool response;
  RequestRemoveMoviesToWatched({required this.response});
  @override
  List<Object?> get props => [response];
}

class RequestAddMoviesToWatchList extends FabButtonState {
  final bool response;
  RequestAddMoviesToWatchList({required this.response});
  @override
  List<Object?> get props => [response];
}

class RequestRemoveMoviesToWatchList extends FabButtonState {
  final bool response;
  RequestRemoveMoviesToWatchList({required this.response});
  @override
  List<Object?> get props => [response];
}

class ErrorFabButtonState extends FabButtonState {
  final Failure error;
  ErrorFabButtonState({required this.error});

  @override
  List<Object?> get props => [];
}
