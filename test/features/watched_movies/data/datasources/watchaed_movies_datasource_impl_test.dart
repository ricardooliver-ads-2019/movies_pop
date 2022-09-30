import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/watched_movies/data/datasources/watchaed_movies_datasource.dart';
import 'package:movies_pop/features/watched_movies/data/datasources/watchaed_movies_datasource_impl.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late WatchaedMoviesDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = MockHttpClient();
    datasource = WatchaedMoviesDatasourceImpl(client: client);
  });

  const urlBase = 'https://api.themoviedb.org/3/list/5555';

  Map<String, dynamic> tResponseRequestGetWatchaedMovies = {
    "created_by": "travisbell",
    "description": "This is pretty wicked.",
    "favorite_count": 0,
    "id": "5555",
    "items": [
      {
        "poster_path": "/fpemzjF623QVTe98pCVlwwtFC5N.jpg",
        "adult": false,
        "overview":
            "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
        "release_date": "1999-10-12",
        "original_title": "Fight Club",
        "genre_ids": [18],
        "id": 550,
        "media_type": "movie",
        "original_language": "en",
        "title": "Fight Club",
        "backdrop_path": null,
        "popularity": 1.5,
        "vote_count": 3439,
        "video": false,
        "vote_average": 7.8
      }
    ],
    "item_count": 46,
    "iso_639_1": "en",
    "name": "filmes_já_vistos",
    "poster_path": "/6KhhINGLbwzylPdRGqu4JxtzAJ3.jpg"
  };

  final respon = HttpClientResponseSuccess(
    data: tResponseRequestGetWatchaedMovies,
    statusCode: 200,
    statusMessage: 'success',
  );

  final responError = HttpClientResponseSuccess(
    data: null,
    statusCode: 404,
    statusMessage: 'false',
  );

  test('watchaed movies datasource impl ...', () async {
    when(
      () => client.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer(
      (_) async => respon,
    );

    final result = await datasource.getListWatchedMovies(idList: 5555);

    expect(result, respon);
    verify(
      () => client.get(urlBase, queryParameters: {
        'api_key': '899e6212bb39852b379032c9c5e25689',
      }),
    ).called(1);
  });

  test('Error watchaed movies datasource impl ...', () async {
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer(
      (_) async => responError,
    );

    final result = await datasource.getListWatchedMovies(idList: 5555);

    expect(result, responError);
    verify(
      () => client.get(urlBase, queryParameters: {
        'api_key': '899e6212bb39852b379032c9c5e25689',
      }),
    ).called(1);
  });
}
