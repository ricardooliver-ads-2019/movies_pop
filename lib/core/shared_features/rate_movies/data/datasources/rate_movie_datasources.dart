import 'package:movies_pop/core/network/http_client_response.dart';

abstract class RateMovieDatasources {
  Future<HttpClientResponse> rateMovie({
    required int movieId,
    required double rating,
  });
  Future<HttpClientResponse> deleteRatingMovie({required int movieId});
}
