import 'package:equatable/equatable.dart';

class CheckMovieInMyListWatchedMoviesEntity extends Equatable {
  final String? id;
  final bool status;

  const CheckMovieInMyListWatchedMoviesEntity({
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [];
}
