import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';
import 'package:movies_pop/features/watch_movies/domain/repositories/watch_movies_repository.dart';
import 'package:movies_pop/features/watch_movies/domain/usecase/get_list_watch_movies_usecase.dart';

class MockMoviesRepository extends Mock implements WatchMoviesRepository {}

void main() {
  late GetListWatchMoviesUsecase usecase;
  late WatchMoviesRepository repository;

  setUp(() {
    repository = MockMoviesRepository();
    usecase = GetListWatchMoviesUsecase(watchMoviesRopository: repository);
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

  test('get list watch movies usecase ...', () async {
    when(() => repository.getListWatchMovies(page: page))
        .thenAnswer((_) async => Right(moviesPage));

    final result = await usecase.call(page);

    final responseSuccess = result.fold((l) => null, (r) => r);

    expect(responseSuccess, isA<MoviesPageEntipy>());
    expect(responseSuccess, moviesPage);

    verify(() => repository.getListWatchMovies(page: page)).called(1);
  });

  test('get list watch movies usecase error ...', () async {
    when(() => repository.getListWatchMovies(page: page))
        .thenAnswer((_) async => const Left(error));

    final result = await usecase.call(page);

    final responseSuccess = result.fold((l) => l, (r) => null);

    expect(responseSuccess, isA<Failure>());
    expect(responseSuccess, isA<GenericFailure>());
    expect(responseSuccess, error);

    verify(() => repository.getListWatchMovies(page: page)).called(1);
  });
}
