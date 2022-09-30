import 'package:movies_pop/core/network/http_client_response.dart';

abstract class WatchMoviesDatasources {
  Future<HttpClientResponse> getListWatchMovies({required int page});
}
