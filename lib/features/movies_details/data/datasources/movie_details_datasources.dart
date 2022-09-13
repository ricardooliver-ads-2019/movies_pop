import 'package:movies_pop/core/network/http_client_response.dart';

abstract class MovieDetailsDatasources {
  Future<HttpClientResponse> getMovieDetails({required int movieId});
}
