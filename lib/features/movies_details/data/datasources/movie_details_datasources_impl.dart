import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/movies_details/data/datasources/movie_details_datasources.dart';

class MovieDetailsDatasourcesImpl implements MovieDetailsDatasources {
  final HttpClient _client;
  MovieDetailsDatasourcesImpl({required HttpClient client}) : _client = client;
  @override
  Future<HttpClientResponse> getMovieDetails({required int movieId}) async {
    return await _client
        .get(Constants.baseUrl + '/movie/$movieId', queryParameters: {
      'api_key': Constants.apiKey,
      'append_to_response': 'images,videos,credits',
      'include_image_language': 'en,pt-br',
      'include_video_language': 'en,pt-br',
      'language': 'pt-br'
    });
  }
}
