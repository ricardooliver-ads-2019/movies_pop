import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movies_page_entipy/movies_page_entipy.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final Failure? error;
  final MoviesPageEntipy? pageCineMovies;
  final MoviesPageEntipy? pagePopularMovies;

  const HomeState._({
    required this.status,
    this.error,
    this.pageCineMovies,
    this.pagePopularMovies,
  });

  const HomeState.initial()
      : this._(
          status: HomeStatus.initial,
          error: null,
          pageCineMovies: null,
          pagePopularMovies: null,
        );
  HomeState copyWith({
    HomeStatus? status,
    Failure? error,
    MoviesPageEntipy? pageCineMovies,
    MoviesPageEntipy? pagePopularMovies,
  }) {
    return HomeState._(
        status: status ?? this.status,
        error: error ?? this.error,
        pageCineMovies: pageCineMovies ?? this.pageCineMovies,
        pagePopularMovies: pagePopularMovies ?? this.pagePopularMovies);
  }

  @override
  List<Object?> get props => [status, error, pageCineMovies, pagePopularMovies];
}
