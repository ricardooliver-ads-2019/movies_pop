import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/user_lists_watched_movies/details_list_watched_movies.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';
import 'package:movies_pop/features/watched_movies/domain/usecase/get_my_list_watched_movies_usecase.dart';
import 'package:movies_pop/features/watched_movies/presenter/controller/watched_cubit_controller.dart';

class MockGetMyListWatchedMoviesUsecase extends Mock
    implements GetMyListWatchedMoviesUsecase {}

class MockDetailsListWatchedMovies extends Mock
    implements DetailsListWatchedMovies {}

void main() {
  late GetMyListWatchedMoviesUsecase getMyListWatchedMoviesUsecase;
  late DetailsListWatchedMovies detailsListWatchedMovies;
  late WatchedCubitController cubitController;
  late ListWatchedMoviesEntity listWatchedMovies;
  late Failure error;
  late Failure errorNotFound;

  setUp(() {
    getMyListWatchedMoviesUsecase = MockGetMyListWatchedMoviesUsecase();
    detailsListWatchedMovies = MockDetailsListWatchedMovies();
    cubitController = WatchedCubitController(
      detailsListWatchedMovies: detailsListWatchedMovies,
      getMyListWatchedMoviesUsecase: getMyListWatchedMoviesUsecase,
    );

    listWatchedMovies = const ListWatchedMoviesEntity(
      name: 'filmes_já_vistos',
      listMovies: [],
    );
    error = const GenericFailure(
      message: 'Error',
      error: 'error',
      statusCode: 500,
    );
    errorNotFound = const ErrorNotFound(
      message: 'Error not found',
      error: 'error',
      statusCode: 404,
    );
  });

  blocTest<WatchedCubitController, WatchedState>(
    'Deve retornar um estado de SucccessWatchedState',
    build: () {
      when(
        () => getMyListWatchedMoviesUsecase.call(idList: any(named: 'idList')),
      ).thenAnswer((_) async => Right(listWatchedMovies));

      when(() => detailsListWatchedMovies.idList).thenReturn(5555);

      return cubitController;
    },
    setUp: () {},
    act: (cubitController) async {
      await cubitController.getMyListWatchedMovies();
    },
    expect: () => [
      LoadingWatchedState(),
      SucccessWatchedState(myListMoviesWatched: listWatchedMovies),
    ],
  );

  blocTest<WatchedCubitController, WatchedState>(
    'Deve retornar um estado de ErrorIdListNull',
    build: () {
      when(
        () => getMyListWatchedMoviesUsecase.call(idList: any(named: 'idList')),
      ).thenAnswer((_) async => Right(listWatchedMovies));

      when(() => detailsListWatchedMovies.idList).thenReturn(null);

      return cubitController;
    },
    setUp: () {},
    act: (cubitController) async {
      await cubitController.getMyListWatchedMovies();
    },
    expect: () => [
      LoadingWatchedState(),
      ErrorIdListNull(),
    ],
  );

  blocTest<WatchedCubitController, WatchedState>(
    'Deve retornar um estado de ErrorWatchedState',
    build: () {
      when(
        () => getMyListWatchedMoviesUsecase.call(idList: any(named: 'idList')),
      ).thenAnswer((_) async => Left(error));

      when(() => detailsListWatchedMovies.idList).thenReturn(5555);

      return cubitController;
    },
    setUp: () {},
    act: (cubitController) async {
      await cubitController.getMyListWatchedMovies();
    },
    expect: () => [
      LoadingWatchedState(),
      ErrorWatchedState(error: error),
    ],
  );

  blocTest<WatchedCubitController, WatchedState>(
    'Deve retornar um estado de ErrorWatchedState',
    build: () {
      when(
        () => getMyListWatchedMoviesUsecase.call(idList: any(named: 'idList')),
      ).thenAnswer((_) async => Left(error));

      when(() => detailsListWatchedMovies.idList).thenReturn(5555);

      return cubitController;
    },
    setUp: () {},
    act: (cubitController) async {
      await cubitController.getMyListWatchedMovies();
    },
    expect: () => [
      LoadingWatchedState(),
      ErrorWatchedState(error: error),
    ],
  );

  blocTest<WatchedCubitController, WatchedState>(
    'Deve retornar um estado de ErrorNotFoundWatchedState',
    build: () {
      when(
        () => getMyListWatchedMoviesUsecase.call(idList: any(named: 'idList')),
      ).thenAnswer((_) async => Left(errorNotFound));

      when(() => detailsListWatchedMovies.idList).thenReturn(5555);

      return cubitController;
    },
    setUp: () {},
    act: (cubitController) async {
      await cubitController.getMyListWatchedMovies();
    },
    expect: () => [
      LoadingWatchedState(),
      ErrorNotFoundWatchedState(error: errorNotFound),
    ],
  );
}
