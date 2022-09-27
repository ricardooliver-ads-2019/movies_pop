import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';

class WatchMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialWatchMoviesState extends WatchMoviesState {
  @override
  List<Object?> get props => [];
}

class LoadingWatchMoviesState extends WatchMoviesState {
  @override
  List<Object?> get props => [];
}

class SuccessWatchMoviesState extends WatchMoviesState {
  final MoviesPageEntipy moviesPageEntipy;
  SuccessWatchMoviesState({required this.moviesPageEntipy});

  @override
  List<Object?> get props => [moviesPageEntipy];
}

class ListIsEmptyWatchMoviesState extends WatchMoviesState {
  final MoviesPageEntipy moviesPageEntipy;
  ListIsEmptyWatchMoviesState({required this.moviesPageEntipy});

  @override
  List<Object?> get props => [moviesPageEntipy];
}

class ErrorWatchMoviesState extends WatchMoviesState {
  final Failure error;
  ErrorWatchMoviesState({required this.error});

  @override
  List<Object?> get props => [error];
}
