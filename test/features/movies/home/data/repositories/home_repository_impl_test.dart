import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';
import 'package:movies_pop/features/movies/home/data/models/movies_page_model.dart';
import 'package:movies_pop/features/movies/home/data/repositories/home_repository_impl.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movies_page_entipy/movies_page_entipy.dart';

import '../../../../../mocks/models.dart';

class MockHomeDatasourceImpl extends Mock implements IHomeDatasource {}

void main() {
  late HomeRepositoryImpl repositoryImpl;
  late IHomeDatasource datasource;

  setUp(() {
    datasource = MockHomeDatasourceImpl();
    repositoryImpl = HomeRepositoryImpl(datasource: datasource);
  });

  final List<MovieEntipy> listMovies =
      MoviesPageModel.fromJson(mockPageMovie).movies;

  //final List<MovieEntipy> listMoviesIsEmpty =
  //    MoviesPageModel.fromJson(mockPageMovieWithListMoviesIsEmpty).movies;

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

  //final List<MovieEntipy> tListMovieEnpity = [tMovieEntipy];
  const int page = 1;

  // final MoviesPageEntipy moviesPage = MoviesPageEntipy(
  //   page: page,
  //   movies: tListMovieEnpity,
  //   totalPages: 5,
  //   totalResults: 22,
  // );

  test('deve obter um HttpClientResponseError', () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow(page: page)).thenAnswer(
        (_) async => HttpClientResponseError(
            data: '', statusCode: 500, statusMessage: ''));
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => null));
    // Assert
    expect(moviesReturn,
        const GenericFailure(error: '', statusCode: 500, message: ''));
    verify(() => datasource.getMoviesPlayingInBrazilNow(page: page));
  });

  test('deve retornar um HttpClientResponseError com statusCode == 0',
      () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow(page: page)).thenAnswer(
        (_) async => HttpClientResponseError(
            data: 'Error', statusCode: 0, statusMessage: 'no conection'));
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => null));
    print(moviesReturn);
    // Assert
    expect(
        moviesReturn,
        const GenericFailure(
            error: 'Error', statusCode: 0, message: 'no conection'));
    verify(() => datasource.getMoviesPlayingInBrazilNow(page: page)).called(1);
  });

  test('deve obter uma lista de moledo de filmes', () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow(page: page)).thenAnswer(
        (_) async => HttpClientResponseSuccess(
            data: mockPageMovie, statusCode: 200, statusMessage: 'Success'));
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow(page: page);
    final moviesReturn = result.fold((l) => null, ((r) => r));
    // Assert
    expect(
        moviesReturn,
        MoviesPageModel(
          page: page,
          movies: listMovies,
          totalPages: 69,
          totalResults: 1372,
        ));
  });

  test('deve obter uma lista de moledo de filmes', () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow(page: page)).thenAnswer(
        (_) async => HttpClientResponseSuccess(
            data: mockPageMovie, statusCode: 200, statusMessage: 'Success'));
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow(page: page);
    // Assert
    expect(result, isA<Right<Failure, MoviesPageEntipy>>());
  });

  test('deve obter uma falha de lista de filmes vazia', () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow(page: page)).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: mockPageMovieNull,
        statusCode: 200,
        statusMessage: 'Success',
      ),
    );
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => null));
    // Assert
    expect(
        moviesReturn,
        const GenericFailure(
          error: 'Lista de filmes vazia',
          message: 'Erro ao buscar lista de filmes',
          statusCode: 54,
        ));
  });

  test('deve obter uma falha de lista de filmes vazia', () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow(page: page))
        .thenAnswer((_) async => HttpClientResponseSuccess(
              data: mockPageMovieWithListMoviesIsEmpty,
              statusCode: 200,
              statusMessage: 'Success',
            ));
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => null));
    // Assert
    expect(
        moviesReturn,
        const GenericFailure(
          error: 'Lista de filmes vazia',
          message: 'Erro ao buscar lista de filmes',
          statusCode: 54,
        ));
  });

  test('deve obter uma falha conversão de contrato no MoviesPage', () async {
    // Arrange
    when(() => datasource.getMoviesPlayingInBrazilNow(page: page))
        .thenAnswer((_) async => HttpClientResponseSuccess(
              data: mockPageMovieContractInvaled,
              statusCode: 200,
              statusMessage: 'Success',
            ));
    // Act
    final result = await repositoryImpl.getMoviesPlayingInBrazilNow(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => null));

    // Assert
    expect(
        moviesReturn,
        const GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500,
        ));
  });

  // test('deve obter uma falha conversão de contrato no Movies', () async {
  //   // Arrange
  //   when(() => datasource.getMoviesPlayingInBrazilNow(page: page))
  //       .thenAnswer((_) async => HttpClientResponseSuccess(
  //             data: mockPageMovieWithContractMovieInvaled,
  //             statusCode: 200,
  //             statusMessage: 'Success',
  //           ));
  //   // Act
  //   final result = await repositoryImpl.getMoviesPlayingInBrazilNow(page: page);
  //   final moviesReturn = result.fold((l) => l, ((r) => null));
  //   // Assert
  //   expect(
  //       moviesReturn,
  //       const GenericFailure(
  //         message: 'Erro de conversão nos filmes',
  //         error: 'XXFilmeXX',
  //         statusCode: 500,
  //       ));
  // });

  //==============================================================

  test('deve obter um HttpClientResponseError', () async {
    // Arrange
    when(() => datasource.getMoviesPopular(page: page)).thenAnswer((_) async =>
        HttpClientResponseError(data: '', statusCode: 500, statusMessage: ''));
    // Act
    final result = await repositoryImpl.getMoviesPopular(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => r));
    // Assert
    expect(moviesReturn,
        const GenericFailure(error: '', message: '', statusCode: 500));
    verify(() => datasource.getMoviesPopular(page: page));
  });

  test('deve responder com um httpResponseError com status code == 0',
      () async {
    when(
      () => datasource.getMoviesPopular(page: page),
    ).thenAnswer((_) async => HttpClientResponseError(
        data: '', statusCode: 0, statusMessage: 'no conection'));

    final result = await repositoryImpl.getMoviesPopular(page: page);
    final returnRenponse = result.fold((l) => l, (r) => r);

    expect(
        returnRenponse,
        const GenericFailure(
            message: 'no conection', error: '', statusCode: 0));
  });

  test('deve obter uma lista de moledo de filmes', () async {
    // Arrange
    when(() => datasource.getMoviesPopular(page: page)).thenAnswer((_) async =>
        HttpClientResponseSuccess(
            data: mockPageMovie, statusCode: 200, statusMessage: 'Success'));
    // Act
    final result = await repositoryImpl.getMoviesPopular(page: page);
    final moviesReturn = result.fold((l) => null, ((r) => r));
    // Assert
    expect(
        moviesReturn,
        MoviesPageModel(
          page: page,
          movies: listMovies,
          totalPages: 69,
          totalResults: 1372,
        ));
  });

  test('deve obter uma lista de moledo de filmes', () async {
    // Arrange
    when(() => datasource.getMoviesPopular(page: page)).thenAnswer((_) async =>
        HttpClientResponseSuccess(
            data: mockPageMovie, statusCode: 200, statusMessage: 'Success'));
    // Act
    final result = await repositoryImpl.getMoviesPopular(page: page);
    // Assert
    expect(result, isA<Right<Failure, MoviesPageEntipy>>());
  });

  test('deve obter uma falha de lista de filmes vazia', () async {
    // Arrange
    when(() => datasource.getMoviesPopular(page: page)).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: mockPageMovieNull,
        statusCode: 200,
        statusMessage: 'Success',
      ),
    );
    // Act
    final result = await repositoryImpl.getMoviesPopular(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => null));
    // Assert
    expect(
        moviesReturn,
        const GenericFailure(
          error: 'Lista de filmes vazia',
          message: 'Erro ao buscar lista de filmes',
          statusCode: 000,
        ));
  });

  test('deve obter uma falha de lista de filmes vazia', () async {
    // Arrange
    when(() => datasource.getMoviesPopular(page: page))
        .thenAnswer((_) async => HttpClientResponseSuccess(
              data: mockPageMovieWithListMoviesIsEmpty,
              statusCode: 200,
              statusMessage: 'Success',
            ));
    // Act
    final result = await repositoryImpl.getMoviesPopular(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => null));
    // Assert
    expect(
        moviesReturn,
        const GenericFailure(
          error: 'Lista de filmes vazia',
          message: 'Erro ao buscar lista de filmes',
          statusCode: 000,
        ));
  });

  test('deve obter uma falha conversão de contrato no MoviesPage', () async {
    // Arrange
    when(() => datasource.getMoviesPopular(page: page))
        .thenAnswer((_) async => HttpClientResponseSuccess(
              data: mockPageMovieContractInvaled,
              statusCode: 200,
              statusMessage: 'Success',
            ));
    // Act
    final result = await repositoryImpl.getMoviesPopular(page: page);
    final moviesReturn = result.fold((l) => l, ((r) => null));
    // Assert
    expect(
        moviesReturn,
        const GenericFailure(
          message: 'Erro de conversão',
          error: 'xxMoviePagexx',
          statusCode: 500,
        ));
  });
}
