import 'package:equatable/equatable.dart';

class MovieEntipy extends Equatable {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final double stars;
  final DateTime releaseDate;

  const MovieEntipy({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.posterPath,
    required this.stars,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [id, title, posterPath, stars, releaseDate];
}
