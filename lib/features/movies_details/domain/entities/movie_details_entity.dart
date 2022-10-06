import 'package:equatable/equatable.dart';
import 'package:movies_pop/features/movies_details/domain/entities/genre_entity.dart';
import 'package:movies_pop/features/movies_details/domain/entities/trailer_movie_entity.dart';

class MovieDetailsEntity extends Equatable {
  final int id;
  final String title;
  final String? posterPath;
  final String sinopse;
  final String? backdropPath;
  final double stars;
  final DateTime? releaseDate;
  final int runtime;
  final List<String> urlImages;
  final List<GenreEntity> genre;
  final List<TrailerMovieEntity> trailers;

  const MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.sinopse,
    required this.runtime,
    required this.stars,
    required this.releaseDate,
    required this.urlImages,
    required this.genre,
    required this.trailers,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        backdropPath,
        sinopse,
        stars,
        releaseDate,
        runtime,
        urlImages,
        genre,
        trailers,
      ];
}
