import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_popular_usecar.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/popular_cubit_controller/popular_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/popular_cubit_controller/popular_state.dart';
import 'package:movies_pop/features/shared/models/movies_page_model/movies_page_model.dart';

import '../../../../../../../mocks/models.dart';

class MockGetMoviesPopularUsecar extends Mock
    implements GetMoviesPopularUsecar {}

void main() {
  late GetMoviesPopularUsecar usecase;
  late PopularCubitController cubitController;

  setUp(() {
    usecase = MockGetMoviesPopularUsecar();
    cubitController = PopularCubitController(moviesPopularUsecar: usecase);
  });

  const int page = 1;

  const Failure error = ErrorNotFound(
    error: 'result.data',
    message:
        'Tivemos um probleminha com a sua solicitação, tente novamente mais tarde!',
    statusCode: 404,
  );

  final pageMovies = MoviesPageModel.fromJson(mockPageMovie);

  tearDown(() => cubitController.close());

  blocTest<PopularCubitController, PopularState>(
    'Deve retornar o estado de SuccessPopularState...',
    build: () {
      when(() => usecase.call(page: page))
          .thenAnswer((_) async => Right(pageMovies));
      return cubitController;
    },
    act: (cubitController) async {
      cubitController.getMoviesPopular(page: page);
    },
    expect: () => [
      LoadingPopularState(),
      SuccessPopularState(pagePopularMovies: pageMovies),
    ],
  );

  blocTest<PopularCubitController, PopularState>(
    'Deve retornar o estado de ErrorPopularStatee...',
    build: () {
      when(() => usecase.call(page: page))
          .thenAnswer((_) async => const Left(error));
      return cubitController;
    },
    act: (cubitController) async {
      cubitController.getMoviesPopular(page: page);
    },
    expect: () => [
      LoadingPopularState(),
      ErrorPopularState(error: error),
    ],
  );
}
