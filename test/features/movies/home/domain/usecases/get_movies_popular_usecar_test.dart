import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/genere_entipy/genere_enpity.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movies_page_entipy/movies_page_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_popular_usecar.dart';

class MockRepositories extends Mock implements HomeRepository {}

void main() {
  late GetMoviesPopularUsecar usecar;
  late HomeRepository mockRepository;

  setUp(() {
    mockRepository = MockRepositories();
    usecar = GetMoviesPopularUsecar(repository: mockRepository);
  });
  final tGenere = GenereEnpity(id: 2, name: 'Ação');
  final DateTime tDate = DateTime(2021, 02, 02);
  final List<GenereEnpity> tListGeneres = [tGenere];
  final tMovieEntipy = MovieEntipy(
    id: 2,
    title: 'Homen de Ferro',
    stars: 4.3,
    //genre: tListGeneres,
    posterPath: 'testeUrl',
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

  const Failure error =
      GenericFailure(message: 'Erro Genérico', error: 'error', statusCode: 401);

  test('deve responder com uma EntipyMoviesPage de filmes populares', () async {
    when(() => mockRepository.getMoviesPopular(page: page))
        .thenAnswer((_) async => Right(moviesPage));

    final result = await usecar.call(page: page);

    expect(result, Right(moviesPage));

    verify(() => mockRepository.getMoviesPopular(page: page)).called(1);
  });

  test('deve responder com uma Falha de filmes populares', () async {
    when(() => mockRepository.getMoviesPopular(page: page))
        .thenAnswer((_) async => const Left(error));

    final result = await usecar(page: page);

    expect(result, const Left(error));

    verify(() => mockRepository.getMoviesPopular(page: page)).called(1);
  });
}
