import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/user_lists_watched_movies/details_list_watched_movies.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/watched_movies/data/datasources/watchaed_movies_datasource.dart';

class WatchaedMoviesDatasourceImpl implements WatchaedMoviesDatasource {
  final HttpClient _client;
  final DetailsListWatchedMovies _idList;

  WatchaedMoviesDatasourceImpl({
    required HttpClient client,
    required DetailsListWatchedMovies idList,
  })  : _client = client,
        _idList = idList;
  @override
  Future<HttpClientResponse> getListWatchedMovies() async {
    return await _client.get(
      Constants.baseUrl + '/list/${_idList.idList}',
      queryParameters: {'api_key': Constants.apiKey},
    );
  }
}
