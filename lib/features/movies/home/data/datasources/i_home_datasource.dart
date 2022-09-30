import 'package:movies_pop/core/network/http_client_response.dart';

abstract class IHomeDatasource {
  Future<HttpClientResponse> getMoviesPlayingInBrazilNow({required int page});
  Future<HttpClientResponse> getMoviesPopular({required int page});
  Future<HttpClientResponse> getMylists();
  Future<HttpClientResponse> createMyListWatchedMovies();
}
