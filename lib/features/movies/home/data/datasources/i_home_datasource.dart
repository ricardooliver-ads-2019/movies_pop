import 'package:movies_pop/core/network/http_client_response.dart';

abstract class IHomeDatasource {
  Future<HttpClientResponse> getMoviesPlayingInBrazilNow();
  Future<HttpClientResponse> getMoviesPopular();
}
