import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/watched_movies/data/datasources/watchaed_movies_datasource.dart';

class WatchaedMoviesDatasourceImpl implements WatchaedMoviesDatasource {
  final HttpClient _client;

  WatchaedMoviesDatasourceImpl({
    required HttpClient client,
  }) : _client = client;

  @override
  Future<HttpClientResponse> getListWatchedMovies({required int idList}) async {
    return await _client.get(
      Constants.baseUrl + '/list/$idList',
      queryParameters: {'api_key': Constants.apiKey},
    );
  }
}
