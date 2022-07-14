import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';
import 'package:movies_pop/features/movies/home/data/repositories/home_repository_impl.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

class MockHomeDatasourceImpl extends Mock implements IHomeDatasource {}

void main() {
  late HomeRepositoryImpl repositoryImpl;
  late IHomeDatasource datasource;

  setUp(() {
    datasource = MockHomeDatasourceImpl();
    repositoryImpl = HomeRepositoryImpl(datasource: datasource);
  });
  final DateTime tDate = DateTime(2021, 02, 02);
  final tMovieEntipy = MovieEntipy(
    id: 2,
    title: 'Homen de Ferro',
    stars: 4.3,
    //genre: tListGeneres,
    posterPath: 'testeUrl',
    releaseDate: tDate,
  );
  final List<MovieEntipy> tListMovieEnpity = [tMovieEntipy];

  test('deve obter um HttpClientResponseError', () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow()).thenAnswer((_) async =>
        HttpClientResponseError(data: '', statusCode: 200, statusMessage: ''));
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow();
    // Assert
    expect(
        result,
        const Left(
            GenericFailure(error: null, message: null, statusCode: null)));
    verify(() => datasource.getMoviesPlayingInBrazilNow());
  });

  test('deve obter uma lista de moledo de filmes', () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow()).thenAnswer((_) async =>
        HttpClientResponseSuccess(
            data: '', statusCode: 200, statusMessage: ''));
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow();
    // Assert
    expect(result, Right(tListMovieEnpity));
  });
}
