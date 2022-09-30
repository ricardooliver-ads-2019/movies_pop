import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/shared_features/status_movies/data/datasources/status_movies_datasources.dart';
import 'package:movies_pop/core/user_lists_watched_movies/details_list_watched_movies.dart';
import 'package:movies_pop/core/utils/constants.dart';

class StatusMoviesDatasourcesImpl implements StatusMoviesDatasources {
  final HttpClient _client;
  final AuthSession _auth;
  final DetailsListWatchedMovies _detailsListWatchedMovies;
  StatusMoviesDatasourcesImpl(
      {required HttpClient client,
      required AuthSession auth,
      required DetailsListWatchedMovies detailsListWatchedMovies})
      : _client = client,
        _auth = auth,
        _detailsListWatchedMovies = detailsListWatchedMovies;
  @override
  Future<HttpClientResponse> getStatusMovies({required int movieId}) async {
    return await _client.get(
      Constants.baseUrl + '/movie/$movieId/account_states',
      queryParameters: {
        'api_key': Constants.apiKey,
        'session_id': _auth.sessionId
      },
    );
  }

  @override
  checkMovieInMyListWatchedMovies({required int movieId}) async {
    return await _client.get(
      Constants.baseUrl +
          '/list/${_detailsListWatchedMovies.idList}/item_status',
      queryParameters: {'api_key': Constants.apiKey, 'movie_id': movieId},
    );
  }

  @override
  Future<HttpClientResponse> addMovieToWatchedMoviesList(
      {required int movieId}) async {
    return await _client.post(
        Constants.baseUrl +
            '/list/${_detailsListWatchedMovies.idList}/add_item',
        queryParameters: {
          'api_key': Constants.apiKey,
          'session_id': _auth.sessionId
        },
        data: {
          "media_id": movieId
        });
  }

  @override
  Future<HttpClientResponse> removeMovieToWatchedMoviesList(
      {required int movieId}) async {
    return await _client.post(
        Constants.baseUrl +
            '/list/${_detailsListWatchedMovies.idList}/remove_item',
        queryParameters: {
          'api_key': Constants.apiKey,
          'session_id': _auth.sessionId
        },
        data: {
          "media_id": movieId
        });
  }

  @override
  Future<HttpClientResponse> addMovieToWatchMoviesList(
      {required int movieId}) async {
    return await _client.post(
        Constants.baseUrl + '/account/${_auth.id}/watchlist',
        queryParameters: {
          'api_key': Constants.apiKey,
          'session_id': _auth.sessionId
        },
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "watchlist": true
        });
  }

  @override
  Future<HttpClientResponse> removeMovieToWatchMoviesList(
      {required int movieId}) async {
    return await _client.post(
        Constants.baseUrl + '/account/${_auth.id}/watchlist',
        queryParameters: {
          'api_key': Constants.apiKey,
          'session_id': _auth.sessionId
        },
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "watchlist": false
        });
  }
}
