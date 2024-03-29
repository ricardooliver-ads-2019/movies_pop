import 'package:equatable/equatable.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';

class ListWatchedMoviesEntity extends Equatable {
  final String name;
  final List<MovieEntipy> listMovies;

  const ListWatchedMoviesEntity({
    required this.name,
    required this.listMovies,
  });

  @override
  List<Object?> get props => [name, listMovies];
}
