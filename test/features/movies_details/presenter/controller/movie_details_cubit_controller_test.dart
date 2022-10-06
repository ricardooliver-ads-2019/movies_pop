import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies_details/data/models/movie_details_model.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';
import 'package:movies_pop/features/movies_details/domain/usecase/get_movie_details_usecase.dart';
import 'package:movies_pop/features/movies_details/presenter/controller/movie_details_cubit_controller.dart';

import '../../../../mocks/models.dart';

class MockGetMovieDetailsUsecase extends Mock
    implements GetMovieDetailsUsecase {}

void main() {
  late GetMovieDetailsUsecase usecase;
  late MovieDetailsCubitController cubitController;

  setUp(() {
    usecase = MockGetMovieDetailsUsecase();
    cubitController =
        MovieDetailsCubitController(getMovieDetailsUsecase: usecase);
  });

  int movieId = 675;
  MovieDetailsEntity movieDetails = MovieDetailsModel.fromMap(movieDetailsMock);
  Failure error = const ErrorNotFound(
    message: 'Erro com o tipo de solicitação',
    error: 'Not-Found',
    statusCode: 404,
  );

  blocTest<MovieDetailsCubitController, MovieDetailsState>(
    'Deve retornar o estado de SuccessMovieDetails',
    build: () {
      when(() => usecase.call(movieId: movieId))
          .thenAnswer((_) async => Right(movieDetails));
      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.getMovieDetails(movieId: movieId);
    },
    expect: () => [
      LoadingMovieDetails(),
      SuccessMovieDetails(movie: movieDetails),
    ],
  );

  blocTest<MovieDetailsCubitController, MovieDetailsState>(
    'Deve retornar o estado de ErrorMovieDetails',
    build: () {
      when(() => usecase.call(movieId: movieId))
          .thenAnswer((_) async => Left(error));
      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.getMovieDetails(movieId: movieId);
    },
    expect: () => [
      LoadingMovieDetails(),
      ErrorMovieDetails(error: error),
    ],
  );
}
