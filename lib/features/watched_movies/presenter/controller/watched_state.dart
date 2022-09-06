part of 'watched_cubit_controller.dart';

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
