import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/list_watchaed_movies_Id_entity.dart';

class ListWatchaedMoviesIdModel extends ListWatchaedMoviesIdEntity {
  const ListWatchaedMoviesIdModel({required int idListWatchedMovies})
      : super(idListWatchedMovies: idListWatchedMovies);

  factory ListWatchaedMoviesIdModel.fromJson(Map<String, dynamic> json) {
    return ListWatchaedMoviesIdModel(idListWatchedMovies: json['list_id']);
  }
}
