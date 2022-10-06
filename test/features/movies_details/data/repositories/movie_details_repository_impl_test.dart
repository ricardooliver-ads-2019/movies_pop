import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies_details/data/datasources/movie_details_datasources.dart';
import 'package:movies_pop/features/movies_details/data/models/movie_details_model.dart';
import 'package:movies_pop/features/movies_details/data/repositories/movie_details_repository_impl.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';
import 'package:movies_pop/features/movies_details/domain/repositories/movie_details_repository.dart';

import '../../../../mocks/models.dart';

class MockMovieDetailsDatasources extends Mock
    implements MovieDetailsDatasources {}

void main() {
  late MovieDetailsDatasources datasources;
  late MovieDetailsRepository repository;

  setUp(() {
    datasources = MockMovieDetailsDatasources();
    repository =
        MovieDetailsRepositoryImpl(movieDetailsDatasources: datasources);
  });

  int movieId = 675;
  MovieDetailsEntity movieDetails = MovieDetailsModel.fromMap(movieDetailsMock);
  Failure error = const ErrorNotFound(
    message: 'Erro com o tipo de solicitação',
    error: 'Not-Found',
    statusCode: 404,
  );

  test('Deve retornar uma instancia de MovieDetailsEntity', () async {
    when(() => datasources.getMovieDetails(movieId: movieId)).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: movieDetailsMock,
        statusCode: 200,
        statusMessage: 'Success',
      ),
    );

    final result = await repository.getMovieDetails(movieId: movieId);

    expect(result.fold((l) => l, (r) => r), isA<MovieDetailsEntity>());

    verify(() => datasources.getMovieDetails(movieId: movieId)).called(1);
  });

  test('Deve retornar os Detalhes de um filme', () async {
    when(() => datasources.getMovieDetails(movieId: movieId)).thenAnswer(
      (_) async => HttpClientResponseSuccess(
        data: movieDetailsMock,
        statusCode: 200,
        statusMessage: 'Success',
      ),
    );

    final result = await repository.getMovieDetails(movieId: movieId);
    final response = result.fold((l) => l, (r) => r);

    expect(response, movieDetails);
  });

  test('Deve retornar um error do tipo ErrorNotFound', () async {
    when(() => datasources.getMovieDetails(movieId: movieId)).thenAnswer(
      (_) async => HttpClientResponseError(
        data: null,
        statusCode: 404,
        statusMessage: 'Error',
      ),
    );

    final result = await repository.getMovieDetails(movieId: movieId);
    final response = result.fold((l) => l, (r) => r);

    expect(response, isA<ErrorNotFound>());
  });
}
