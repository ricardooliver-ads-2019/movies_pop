import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';

class HomeDatasourceImpl implements IHomeDatasource {
  final HttpClient _client;
  final AuthSession _auth;
  HomeDatasourceImpl({required HttpClient client, required AuthSession auth})
      : _client = client,
        _auth = auth;

  @override
  Future<HttpClientResponse> getMoviesPlayingInBrazilNow(
      {required int page}) async {
    return await _client.get(
      Constants.baseUrl + '/movie/now_playing',
      queryParameters: {
        'api_key': Constants.apiKey,
        'language': 'pt-br',
        'regio': 'Brazil',
        'page': page
      },
    );
  }

  @override
  Future<HttpClientResponse> getMoviesPopular({required int page}) async {
    return await _client
        .get(Constants.baseUrl + '/movie/popular', queryParameters: {
      'api_key': Constants.apiKey,
      'language': 'pt-br',
      'regio': 'Brazil',
      'page': page
    });
  }

  @override
  Future<HttpClientResponse> createMyListWatchedMovies() async {
    return await _client.post(Constants.baseUrl + '/list', queryParameters: {
      'api_key': Constants.apiKey,
      'session_id': _auth.sessionId,
    }, data: {
      'name': 'filmes_já_vistos',
      'description': 'lista de filmes que já assisti',
      'language': 'pt'
    });
  }

  @override
  Future<HttpClientResponse> getMylists() async {
    return await _client.get(
      Constants.baseUrl + '/account/${_auth.id}/lists',
      queryParameters: {
        'api_key': Constants.apiKey,
        'session_id': _auth.sessionId,
      },
    );
  }
}
