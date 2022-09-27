import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/models/movies_page_model/movies_page_model.dart';
import 'package:movies_pop/features/watch_movies/domain/usecase/get_list_watch_movies_usecase.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_cubit_controller.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_state.dart';

import '../../../../mocks/models.dart';

class MockGetListWatchMoviesUsecase extends Mock
    implements GetListWatchMoviesUsecase {}

void main() {
  late final GetListWatchMoviesUsecase usecase;
  late final WatchMoviesCubitController cubitController;

  setUp(() {
    usecase = MockGetListWatchMoviesUsecase();
    cubitController = WatchMoviesCubitController(usecase: usecase);
  });

  const int page = 1;

  const Failure error = ErrorNotFound(
    error: 'result.data',
    message:
        'Tivemos um probleminha com a sua solicitação, tente novamente mais tarde!',
    statusCode: 404,
  );

  final pageMovies = MoviesPageModel.fromJson(mockPageMovie);

  final pageMoviesListEmpty =
      MoviesPageModel.fromJson(mockPageMovieWithListMoviesIsEmpty);

  blocTest<WatchMoviesCubitController, WatchMoviesState>(
    'Deve retornar um caso de SuccessWatchMoviesState ...',
    build: () {
      when(() => usecase.call(page)).thenAnswer((_) async => Right(pageMovies));
      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.getListWatchMovies(page: page);
    },
    expect: () => [
      LoadingWatchMoviesState(),
      SuccessWatchMoviesState(moviesPageEntipy: pageMovies),
    ],
  );

  blocTest<WatchMoviesCubitController, WatchMoviesState>(
    'Deve retornar um caso de ListIsEmptyWatchMoviesState ...',
    build: () {
      when(() => usecase.call(page))
          .thenAnswer((_) async => Right(pageMoviesListEmpty));
      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.getListWatchMovies(page: page);
    },
    expect: () => [
      LoadingWatchMoviesState(),
      ListIsEmptyWatchMoviesState(moviesPageEntipy: pageMoviesListEmpty),
    ],
  );

  blocTest<WatchMoviesCubitController, WatchMoviesState>(
    'Deve retornar um caso de ErrorWatchMoviesState ...',
    build: () {
      when(() => usecase.call(page)).thenAnswer((_) async => const Left(error));
      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.getListWatchMovies(page: page);
    },
    expect: () => [
      LoadingWatchMoviesState(),
      ErrorWatchMoviesState(error: error),
    ],
  );
}
