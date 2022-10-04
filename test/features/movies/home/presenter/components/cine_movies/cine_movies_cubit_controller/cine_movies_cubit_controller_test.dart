import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_playing_in_Brazil_now_usecase.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/cine_movies_cubit_controller/cine_movies_cubit_controller.dart';
import 'package:movies_pop/features/shared/models/movies_page_model/movies_page_model.dart';

import '../../../../../../../mocks/models.dart';

class MockGetMoviesPlayingInBrazilNowUsecase extends Mock
    implements GetMoviesPlayingInBrazilNowUsecase {}

void main() {
  late GetMoviesPlayingInBrazilNowUsecase usecase;
  late CineMoviesCubitController cubitController;

  setUp(() {
    usecase = MockGetMoviesPlayingInBrazilNowUsecase();
    cubitController =
        CineMoviesCubitController(moviesPlayingInBrazilNowUsecase: usecase);
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

  blocTest<CineMoviesCubitController, CineMoviesState>(
    'deve retornar uma pagina de filmes que estão passando atualmente no cinema,',
    build: () {
      when(() => usecase.call(page: page))
          .thenAnswer((_) async => Right(pageMovies));
      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.getMoviesPlayingInBrazilNowUsecase(page: page);
    },
    expect: () => [
      LoadingState(),
      SuccessState(pageCineMovies: pageMovies),
    ],
  );

  blocTest<CineMoviesCubitController, CineMoviesState>(
    'deve retornar um estado de ErrorState,',
    build: () {
      when(() => usecase.call(page: page))
          .thenAnswer((_) async => const Left(error));
      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.getMoviesPlayingInBrazilNowUsecase(page: page);
    },
    expect: () => [
      LoadingState(),
      ErrorState(error: error),
    ],
  );
}
