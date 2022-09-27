import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';
import 'package:movies_pop/features/watch_movies/data/datasources/watch_movies_datasources.dart';
import 'package:movies_pop/features/watch_movies/data/repositories/watch_movies_repository_impl.dart';
import 'package:movies_pop/features/watch_movies/domain/repositories/watch_movies_repository.dart';

import '../../../../mocks/models.dart';

class MockWatchMoviesDatasources extends Mock
    implements WatchMoviesDatasources {}

void main() {
  late WatchMoviesDatasources datasources;
  late WatchMoviesRepository repository;
  setUp(() {
    datasources = MockWatchMoviesDatasources();
    repository = WatchMoviesRepositoryImpl(watchMoviesDatasources: datasources);
  });

  const Failure error = GenericFailure(
    message: 'Erro Genérico',
    error: 'error',
    statusCode: 401,
  );

  final DateTime tDate = DateTime(2021, 02, 02);

  final tMovieEntipy = MovieEntipy(
    id: 2,
    title: 'Homen de Ferro',
    stars: 4.3,
    //genre: tListGeneres,
    posterPath: 'testeUrl',
    backdropPath: 'testeUrl',
    releaseDate: tDate,
  );
  const int page = 1;
  final List<MovieEntipy> tListMovieEnpoty = [tMovieEntipy];
  final MoviesPageEntipy moviesPage = MoviesPageEntipy(
    page: page,
    movies: tListMovieEnpoty,
    totalPages: 5,
    totalResults: 22,
  );

  test('watch movies repository impl ...', () async {
    when(() => datasources.getListWatchMovies(page: page)).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: mockPageMovie,
        statusCode: 200,
        statusMessage: 'Success',
      ),
    );

    final result = await repository.getListWatchMovies(page: page);

    expect(result.fold((l) => null, (r) => r), isA<MoviesPageEntipy>());

    verify(() => datasources.getListWatchMovies(page: page)).called(1);
  });

  test('deve retornar com um ErrorNoConnection', () async {
    when(
      () => datasources.getListWatchMovies(page: page),
    ).thenAnswer(
      (_) async => HttpClientResponseError(
        data: '',
        statusCode: 0,
        statusMessage: 'no conection',
      ),
    );

    final result = await repository.getListWatchMovies(page: page);
    final returnRenponse = result.fold((l) => l, (r) => r);

    expect(returnRenponse, isA<ErrorNoConnection>());
    verify(() => datasources.getListWatchMovies(page: page)).called(1);
  });

  test('deve retornar com um ErrorNotFound', () async {
    when(
      () => datasources.getListWatchMovies(page: page),
    ).thenAnswer(
      (_) async => HttpClientResponseError(
        data: '',
        statusCode: 404,
        statusMessage: 'Not Found',
      ),
    );

    final result = await repository.getListWatchMovies(page: page);
    final returnRenponse = result.fold((l) => l, (r) => r);

    expect(returnRenponse, isA<ErrorNotFound>());
    verify(() => datasources.getListWatchMovies(page: page)).called(1);
  });

  test('deve retornar com um GenericFailure', () async {
    when(
      () => datasources.getListWatchMovies(page: page),
    ).thenAnswer(
      (_) async => HttpClientResponseError(
        data: '',
        statusCode: 555,
        statusMessage: 'Not Found',
      ),
    );

    final result = await repository.getListWatchMovies(page: page);
    final returnRenponse = result.fold((l) => l, (r) => r);

    expect(returnRenponse, isA<GenericFailure>());
    verify(() => datasources.getListWatchMovies(page: page)).called(1);
  });

  test('deve retornar com um ErrorInvalidData', () async {
    when(
      () => datasources.getListWatchMovies(page: page),
    ).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: mockPageMovieContractInvaled,
        statusCode: 200,
        statusMessage: 'Success',
      ),
    );

    final result = await repository.getListWatchMovies(page: page);
    final returnRenponse = result.fold((l) => l, (r) => r);

    expect(returnRenponse, isA<ErrorInvalidData>());
    verify(() => datasources.getListWatchMovies(page: page)).called(1);
  });
}
