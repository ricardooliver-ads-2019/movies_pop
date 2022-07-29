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

// enum HomeStatus { initial, loading, success, error }

// class HomeState extends Equatable {
//   final HomeStatus status;
//   final Failure? error;
//   final MoviesPageEntipy? pageCineMovies;
//   final MoviesPageEntipy? pagePopularMovies;

//   const HomeState._({
//     required this.status,
//     this.error,
//     this.pageCineMovies,
//     this.pagePopularMovies,
//   });

//   const HomeState.initial()
//       : this._(
//           status: HomeStatus.initial,
//           error: null,
//           pageCineMovies: null,
//           pagePopularMovies: null,
//         );

//   @override
//   List<Object?> get props => [status, error, pageCineMovies, pagePopularMovies];

//   HomeState copyWith({
//     HomeStatus? status,
//     Failure? error,
//     MoviesPageEntipy? pageCineMovies,
//     MoviesPageEntipy? pagePopularMovies,
//   }) {
//     return HomeState._(
//         status: status ?? this.status,
//         error: error ?? this.error,
//         pageCineMovies: pageCineMovies ?? this.pageCineMovies,
//         pagePopularMovies: pagePopularMovies ?? this.pagePopularMovies);
//   }
// }
