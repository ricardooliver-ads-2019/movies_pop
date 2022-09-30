part of 'cine_movies_cubit_controller.dart';

class CineMoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends CineMoviesState {
  @override
  List<Object> get props => [];
}

class LoadingState extends CineMoviesState {
  @override
  List<Object> get props => [];
}

class SuccessState extends CineMoviesState {
  SuccessState({
    required this.pageCineMovies,
  });

  final MoviesPageEntipy pageCineMovies;

  @override
  List<Object> get props => [pageCineMovies];
}

class ErrorState extends CineMoviesState {
  ErrorState({
    required this.error,
  });

  final Failure error;

  @override
  List<Object> get props => [error];
}
