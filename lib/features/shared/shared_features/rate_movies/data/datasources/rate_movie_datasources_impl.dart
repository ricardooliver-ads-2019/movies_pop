import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/shared/shared_features/rate_movies/data/datasources/rate_movie_datasources.dart';

class RateMovieDatasourcesImpl implements RateMovieDatasources {
  final HttpClient _client;
  final AuthSession _auth;
  RateMovieDatasourcesImpl(
      {required HttpClient client, required AuthSession auth})
      : _client = client,
        _auth = auth;

  @override
  Future<HttpClientResponse> rateMovie({
    required int movieId,
    required double rating,
  }) async {
    return await _client.post(
      Constants.baseUrl + '/movie/$movieId/rating',
      queryParameters: {
        'api_key': Constants.apiKey,
        'session_id': _auth.sessionId
      },
      data: {"value": rating},
    );
  }

  @override
  Future<HttpClientResponse> deleteRatingMovie({required int movieId}) async {
    return await _client.delete(
      Constants.baseUrl + '/movie/$movieId/rating',
      queryParameters: {
        'api_key': Constants.apiKey,
        'session_id': _auth.sessionId
      },
    );
  }
}
