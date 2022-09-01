import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/login/presenter/controller/login_state.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';

class WatchedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialWatchedState extends WatchedState {}

class LoadingWatchedState extends WatchedState {}

class SucccessWatchedState extends WatchedState {
  final ListWatchedMoviesEntity myListMoviesWatched;
  SucccessWatchedState({
    required this.myListMoviesWatched,
  });

  @override
  List<Object?> get props => [myListMoviesWatched];
}

class ErrorWatchedState extends WatchedState {
  final Failure error;
  ErrorWatchedState({required this.error});

  @override
  List<Object?> get props => [Error];
}
