import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/movies_details/data/datasources/movie_details_datasources.dart';
import 'package:movies_pop/features/movies_details/data/datasources/movie_details_datasources_impl.dart';
import 'package:movies_pop/features/movies_details/data/models/movie_details_model.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';

import '../../../../mocks/models.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late HttpClient client;
  late MovieDetailsDatasources datasources;

  setUp(() {
    client = MockHttpClient();
    datasources = MovieDetailsDatasourcesImpl(client: client);
  });

  int movieId = 675;
  MovieDetailsEntity movieDetails = MovieDetailsModel.fromMap(movieDetailsMock);

  var urlBase = 'https://api.themoviedb.org/3/movie/$movieId';

  test('movie details datasources impl ...', () async {
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: movieDetailsMock,
        statusCode: 200,
        statusMessage: 'Success',
      ),
    );

    final result = await datasources.getMovieDetails(movieId: movieId);
    final data = result.data;
    expect(data, movieDetailsMock);
  });

  test('movie details datasources impl ...', () async {
    when(() => client.get(
          urlBase,
          queryParameters: {
            'api_key': Constants.apiKey,
            'append_to_response': 'images,videos,credits',
            'include_image_language': 'en,pt-br',
            'include_video_language': 'en,pt-br',
            'language': 'pt-br'
          },
        )).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: movieDetailsMock,
        statusCode: 200,
        statusMessage: 'Success',
      ),
    );

    final result = await datasources.getMovieDetails(movieId: movieId);
    final data = result.data;
    expect(data, movieDetailsMock);

    verify(
      () => client.get(
        urlBase,
        queryParameters: {
          'api_key': Constants.apiKey,
          'append_to_response': 'images,videos,credits',
          'include_image_language': 'en,pt-br',
          'include_video_language': 'en,pt-br',
          'language': 'pt-br'
        },
      ),
    ).called(1);
  });

  test('Deve responder com um HttpClientResponseError ...', () async {
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer(
      (_) async => HttpClientResponseError(
        data: null,
        statusCode: 404,
        statusMessage: 'Failure',
      ),
    );

    final result = await datasources.getMovieDetails(movieId: movieId);

    expect(result, isA<HttpClientResponseError>());
  });
}
