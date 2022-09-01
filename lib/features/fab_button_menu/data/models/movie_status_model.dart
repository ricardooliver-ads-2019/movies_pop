import 'package:movies_pop/features/fab_button_menu/domain/entities/movie_status_entity.dart';

class MovieStatusModel extends MovieStatusEntity {
  const MovieStatusModel({
    required int id,
    required bool watchMovie,
    required rated,
  }) : super(
          id: id,
          watchMovie: watchMovie,
          rated: rated,
        );

  factory MovieStatusModel.fromJson(Map<String, dynamic> json) {
    return MovieStatusModel(
      id: json['id'],
      watchMovie: json['watchlist'],
      rated: json['rated'],
    );
  }
}
