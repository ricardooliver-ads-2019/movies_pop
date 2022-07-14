import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/genere_entipy/genere_enpity.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_playing_in_Brazil_now_usecase.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetMoviesPlayingInBrazilNowUsecase usecase;
  late MockHomeRepository mockhomeRepository;

  setUp(() {
    mockhomeRepository = MockHomeRepository();
    usecase =
        GetMoviesPlayingInBrazilNowUsecase(repository: mockhomeRepository);
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
  final List<MovieEntipy> tListMovieEnpoty = [tMovieEntipy];

  const Failure error =
      GenericFailure(message: 'Erro Genérico', error: 'error', statusCode: 401);

  test('deve obter um lista de Filmes', () async {
    // arrange
    when(() => mockhomeRepository.getMoviesPlayingInBrazilNow())
        .thenAnswer((_) async => Right(tListMovieEnpoty));
    // act
    final result = await usecase();
    // assert
    expect(result, Right(tListMovieEnpoty));
    verify(() => mockhomeRepository.getMoviesPlayingInBrazilNow());
  });

  test('deve obter uma falha', () async {
    // arrange
    when(() => mockhomeRepository.getMoviesPlayingInBrazilNow())
        .thenAnswer((_) async => const Left(error));
    // act
    final result = await usecase();
    // assert
    expect(result, const Left(error));
    verify(() => mockhomeRepository.getMoviesPlayingInBrazilNow());
  });
}
