import 'package:movies_pop/core/network/http_client_response.dart';

abstract class WatchaedMoviesDatasource {
  Future<HttpClientResponse> getListWatchedMovies();
}
