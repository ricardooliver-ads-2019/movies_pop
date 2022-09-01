import 'package:equatable/equatable.dart';

class MovieStatusEntity extends Equatable {
  final int id;
  final bool watchMovie;
  final dynamic rated;
  const MovieStatusEntity({
    required this.id,
    required this.watchMovie,
    required this.rated,
  });

  @override
  List<Object> get props => [id, watchMovie, rated];
}
