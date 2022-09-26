import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/shared/models/movie_model/movie_model.dart';
import 'package:movies_pop/features/watched_movies/data/datasources/watchaed_movies_datasource.dart';
import 'package:movies_pop/features/watched_movies/data/models/list_watched_movies_model.dart';
import 'package:movies_pop/features/watched_movies/data/repositories/watchaed_movies_repository_impl.dart';
import 'package:movies_pop/features/watched_movies/domain/repositories/watchaed_movies_repository.dart';

import '../../../../mocks/models.dart';

class WatchaedMoviesDatasourceMock extends Mock
    implements WatchaedMoviesDatasource {}

void main() {
  late WatchaedMoviesDatasource datasource;
  late WatchaedMoviesRepository repository;
  setUp(() {
    datasource = WatchaedMoviesDatasourceMock();
    repository = WatchaedMoviesRepositoryImpl(datasource: datasource);
  });
  final dataRespSuccessListEmpty = {
    "created_by": "travisbell",
    "description": "This is pretty wicked.",
    "favorite_count": 0,
    "id": "50941077760ee35e1500000c",
    "items": mockListMoviesIsEmpty,
    "item_count": 46,
    "iso_639_1": "en",
    "name": "filmes_já_vistos",
    "poster_path": "/6KhhINGLbwzylPdRGqu4JxtzAJ3.jpg"
  };
  final dataRespSuccess = {
    "created_by": "travisbell",
    "description": "This is pretty wicked.",
    "favorite_count": 0,
    "id": "50941077760ee35e1500000c",
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
  final HttpClientResponse responseSuccess = HttpClientResponse(
    data: dataRespSuccess,
    statusCode: 200,
    statusMessage: 'Success',
  );

  final HttpClientResponse responseSuccessListEmpty = HttpClientResponse(
    data: dataRespSuccessListEmpty,
    statusCode: 200,
    statusMessage: 'Success',
  );

  final List<MovieModel> listMovieEntity = [
    MovieModel(
      id: 550,
      title: 'Fight Club',
      posterPath: '/fpemzjF623QVTe98pCVlwwtFC5N.jpg',
      stars: 7.8,
      releaseDate: DateTime.parse("1999-10-12"),
      backdropPath: null,
    )
  ];

  late final listWatched = ListWatchedMoviesModel(
    name: 'filmes_já_vistos',
    listMovies: listMovieEntity,
  );

  const Failure error =
      GenericFailure(message: 'Erro Genérico', error: 'error', statusCode: 401);

  const Failure errorListEmpty = GenericFailure(
    error: '',
    message: 'Lista de filmes vazia',
    statusCode: 000,
  );

  test('watchaed movies repository impl ...', () async {
    when(() => datasource.getListWatchedMovies(idList: 55225))
        .thenAnswer((_) async => responseSuccess);

    final result = await repository.getListWatchedMovies(idList: 55225);
    final expectListWatched = result.fold((l) => null, (r) => r);

    expect(expectListWatched, listWatched);

    verify(() => datasource.getListWatchedMovies(idList: 55225)).called(1);
  });

  test('Error or get watchaed movies repository impl ...', () async {
    when(() => datasource.getListWatchedMovies(idList: 55225))
        .thenAnswer((_) async => responseSuccessListEmpty);

    final result = await repository.getListWatchedMovies(idList: 55225);
    final expectListWatched = result.fold((l) => l, (r) => null);

    expect(expectListWatched, errorListEmpty);

    verify(() => datasource.getListWatchedMovies(idList: 55225)).called(1);
  });
}
