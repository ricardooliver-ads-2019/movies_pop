import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/entities/movie_status_entity.dart';

class CardButtonsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitalStatusMovie extends CardButtonsState {}

class SuccessStatusMovie extends CardButtonsState {
  final MovieStatusEntity movieStatus;
  final CheckMovieInMyListWatchedMoviesEntity movieInMyListWatched;

  SuccessStatusMovie({
    required this.movieStatus,
    required this.movieInMyListWatched,
  });
}

class RequestAddMoviesToWatchList extends CardButtonsState {
  final bool response;
  RequestAddMoviesToWatchList({required this.response});
  @override
  List<Object?> get props => [response];
}

class RequestRemoveMoviesToWatchList extends CardButtonsState {
  final bool response;
  RequestRemoveMoviesToWatchList({required this.response});
  @override
  List<Object?> get props => [response];
}

class RequestAddMoviesToWatched extends CardButtonsState {
  final bool response;
  RequestAddMoviesToWatched({required this.response});
  @override
  List<Object?> get props => [response];
}

class RequestRemoveMoviesToWatched extends CardButtonsState {
  final bool response;
  RequestRemoveMoviesToWatched({required this.response});
  @override
  List<Object?> get props => [response];
}

class ErrorStatusMovie extends CardButtonsState {
  final Failure error;
  ErrorStatusMovie({required this.error});
}
