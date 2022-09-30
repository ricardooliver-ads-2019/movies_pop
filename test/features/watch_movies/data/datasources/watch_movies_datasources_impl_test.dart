import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/watch_movies/data/datasources/watch_movies_datasources.dart';
import 'package:movies_pop/features/watch_movies/data/datasources/watch_movies_datasources_impl.dart';

import '../../../../mocks/models.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockAuthSession extends Mock implements AuthSession {}

void main() {
  late HttpClient client;
  late WatchMoviesDatasources datasources;
  late AuthSession auth;
  setUp(() {
    client = MockHttpClient();
    auth = MockAuthSession();
    datasources = WatchMoviesDatasourcesImpl(client: client, auth: auth);
  });

  // const urlBase = 'https://api.themoviedb.org/3/';
  // const apiKey = '899e6212bb39852b379032c9c5e25689';

  const int page = 1;

  final HttpClientResponse responseError = HttpClientResponseError(
    data: '',
    statusCode: 404,
    statusMessage: 'Not-Found',
  );

  final HttpClientResponse responseSuccess = HttpClientResponseSuccess(
    data: mockPageMovie,
    statusCode: 200,
    statusMessage: 'Success',
  );
  test('Deve retornar um  HttpClientResponseSuccess...', () async {
    when(() => auth.id).thenReturn(2656566);
    when(() => auth.sessionId).thenReturn('265h6566');
    when(
      () => client.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenAnswer((_) async => responseSuccess);

    final result = await datasources.getListWatchMovies(page: page);

    expect(result, isA<HttpClientResponseSuccess>());

    // verify(
    //   () => client.get(urlBase + '/account/${auth.id}/watchlist/movies',
    //       queryParameters: {
    //         'api_key': '899e6212bb39852b379032c9c5e25689',
    //         'language': 'pt-br',
    //         'session_id': auth.sessionId,
    //         'page': page
    //       }),
    // ).called(1);

    verify(
      () => client.get(any(), queryParameters: any(named: 'queryParameters')),
    ).called(1);
  });

  test('Deve retornar um  HttpClientError...', () async {
    when(() => auth.id).thenReturn(2656566);
    when(() => auth.sessionId).thenReturn('265h6566');
    when(
      () => client.get(any(), queryParameters: any(named: 'queryParameters')),
    ).thenAnswer((_) async => responseError);

    final result = await datasources.getListWatchMovies(page: page);

    expect(result, isA<HttpClientResponseError>());

    verify(
      () => client.get(any(), queryParameters: any(named: 'queryParameters')),
    ).called(1);
  });
}
