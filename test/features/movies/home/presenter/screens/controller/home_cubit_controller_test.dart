import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/core/user_lists_watched_movies/details_list_watched_movies.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_list_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_lists_movies_entity.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/usecase_list_user/create_my_list_watched_movies_usecase.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/usecase_list_user/get_my_lists_usecase.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/controller/home_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/controller/home_state.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';

class MockGetMyListsUsecase extends Mock implements GetMyListsUsecase {}

class MockCreateMyListWatchedMoviesUsecase extends Mock
    implements CreateMyListWatchedMoviesUsecase {}

class MockDetailsListWatchedMovies extends Mock
    implements DetailsListWatchedMovies {}

void main() {
  late GetMyListsUsecase getMyListsUsecase;
  late CreateMyListWatchedMoviesUsecase createMyListWatchedMoviesUsecase;
  late DetailsListWatchedMovies detailsListWatchedMovies;
  late HomeCubitController cubitController;
  late MyListsMoviesEntity myListsMoviesEntity;
  late MyListEntipy myListEntipy;
  late ListWatchedMoviesEntity listIsEmptyWatchedMovies;
  late ListWatchedMoviesEntity listWatchedMovies;
  late MovieEntipy movie;
  late Failure error;
  late Failure errorNotFound;

  setUp(() {
    getMyListsUsecase = MockGetMyListsUsecase();
    createMyListWatchedMoviesUsecase = MockCreateMyListWatchedMoviesUsecase();
    detailsListWatchedMovies = MockDetailsListWatchedMovies();
    cubitController = HomeCubitController(
      getMyListsUsecase: getMyListsUsecase,
      createMyListWatchedMoviesUsecase: createMyListWatchedMoviesUsecase,
      detailsListWatchedMovies: detailsListWatchedMovies,
    );
  });

  final DateTime tDate = DateTime(2021, 02, 02);

  movie = MovieEntipy(
    backdropPath: 'backdropPath',
    id: 11,
    title: 'final',
    posterPath: 'posterPath',
    stars: 8.5,
    releaseDate: tDate,
  );

  listIsEmptyWatchedMovies = const ListWatchedMoviesEntity(
    name: 'filmes_já_vistos',
    listMovies: [],
  );

  listWatchedMovies = ListWatchedMoviesEntity(
    name: 'filmes_já_vistos',
    listMovies: [movie],
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

  myListEntipy = const MyListEntipy(
      id: 8217379,
      name: 'filmes_já_vistos',
      description: 'lista de filmes que já assisti');

  myListsMoviesEntity = MyListsMoviesEntity(
      page: 1, myLists: [myListEntipy], totalPages: 2, totalResults: 20);

  tearDown(() => cubitController.close());

  blocTest<HomeCubitController, HomeState>(
    'home cubit controller ...',
    build: () {
      when(() =>
              detailsListWatchedMovies.saveIdListWatchMovies(idList: 8217379))
          .thenAnswer((_) async => Future.value());

      when(() => detailsListWatchedMovies.init())
          .thenAnswer((_) async => Future.value());

      when(() => getMyListsUsecase.call())
          .thenAnswer((_) async => Right(myListsMoviesEntity));
      return cubitController;
    },
    act: (cubitController) async {
      await cubitController.getMyList();
    },
    expect: () => [
      LoadingHomeState(),
      SuccessHomeState(),
    ],
  );
}
