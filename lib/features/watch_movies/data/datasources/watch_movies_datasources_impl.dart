import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/watch_movies/data/datasources/watch_movies_datasources.dart';

class WatchMoviesDatasourcesImpl implements WatchMoviesDatasources {
  final HttpClient _client;
  final AuthSession _auth;
  WatchMoviesDatasourcesImpl(
      {required HttpClient client, required AuthSession auth})
      : _client = client,
        _auth = auth;

  @override
  Future<HttpClientResponse> getListWatchMovies({required int page}) async {
    return await _client.get(
        Constants.baseUrl + '/account/${_auth.id}/watchlist/movies',
        queryParameters: {
          'api_key': Constants.apiKey,
          'language': 'pt-br',
          'session_id': _auth.sessionId,
          'page': page
        });
  }
}
