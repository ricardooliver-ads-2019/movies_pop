import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';

class HomeDatasourceImpl implements IHomeDatasource {
  final HttpClient _client;
  HomeDatasourceImpl({required HttpClient client}) : _client = client;

  @override
  Future<HttpClientResponse> getMoviesPlayingInBrazilNow() async {
    return await _client.get('https://api.themoviedb.org/3/movie/now_playing',
        queryParameters: {
          'api_key': '899e6212bb39852b379032c9c5e25689',
          'language': 'pt-br',
          'region': 'Brazil',
          'page': 2
        });
  }

  @override
  Future<HttpClientResponse> getMoviesPopular() {
    // TODO: implement getMoviesPopular
    throw UnimplementedError();
  }
}
