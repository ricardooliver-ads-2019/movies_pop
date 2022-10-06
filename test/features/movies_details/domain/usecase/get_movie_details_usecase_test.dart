import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies_details/data/models/movie_details_model.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';
import 'package:movies_pop/features/movies_details/domain/repositories/movie_details_repository.dart';
import 'package:movies_pop/features/movies_details/domain/usecase/get_movie_details_usecase.dart';

import '../../../../mocks/models.dart';

class MockMovieDetailsRepository extends Mock
    implements MovieDetailsRepository {}

void main() {
  late MovieDetailsRepository repository;
  late GetMovieDetailsUsecase usecase;

  setUp(() {
    repository = MockMovieDetailsRepository();
    usecase = GetMovieDetailsUsecase(movieDetailsRepository: repository);
  });

  int movieId = 675;
  MovieDetailsEntity movieDetails = MovieDetailsModel.fromMap(movieDetailsMock);
  Failure error = const ErrorNotFound(
    message: 'Erro com o tipo de solicitação',
    error: 'Not-Found',
    statusCode: 404,
  );

  test('Deve retornar um instacia de MovieDetailsEntity', () async {
    when(() => repository.getMovieDetails(movieId: movieId))
        .thenAnswer((_) async => Right(movieDetails));

    final result = await usecase.call(movieId: movieId);

    expect(result.fold((l) => l, (r) => r), isA<MovieDetailsEntity>());

    verify(() => repository.getMovieDetails(movieId: movieId)).called(1);
  });

  test('Deve retornar um instacia de Failure', () async {
    when(() => repository.getMovieDetails(movieId: movieId))
        .thenAnswer((_) async => Left(error));

    final result = await usecase.call(movieId: movieId);

    expect(result.fold((l) => l, (r) => r), isA<Failure>());

    verify(() => repository.getMovieDetails(movieId: movieId)).called(1);
  });
}
