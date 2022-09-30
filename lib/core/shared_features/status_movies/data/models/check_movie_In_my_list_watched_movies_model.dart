import 'package:movies_pop/core/shared_features/status_movies/domain/entities/check_movie_In_my_list_watched_moviesEntity.dart';

class CheckMovieInMyListWatchedMoviesModel
    extends CheckMovieInMyListWatchedMoviesEntity {
  const CheckMovieInMyListWatchedMoviesModel({
    required String? id,
    required bool status,
  }) : super(
          id: id,
          status: status,
        );
  factory CheckMovieInMyListWatchedMoviesModel.fromJson(
      Map<String, dynamic> json) {
    return CheckMovieInMyListWatchedMoviesModel(
      id: json['id'],
      status: json['item_present'],
    );
  }
}
