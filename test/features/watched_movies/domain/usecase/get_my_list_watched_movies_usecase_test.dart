import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/list_watched_movies_entity.dart';
import 'package:movies_pop/features/watched_movies/domain/repositories/watchaed_movies_repository.dart';
import 'package:movies_pop/features/watched_movies/domain/usecase/get_my_list_watched_movies_usecase.dart';

class MockRepositoryWatchedMovies extends Mock
    implements WatchaedMoviesRepository {}

void main() {
  late WatchaedMoviesRepository watchaedMoviesRepository;

  late GetMyListWatchedMoviesUsecase usecase;

  setUp(() {
    watchaedMoviesRepository = MockRepositoryWatchedMovies();

    usecase =
        GetMyListWatchedMoviesUsecase(repository: watchaedMoviesRepository);
  });

  final List<MovieEntipy> listMovieEntity = [];

  late final listWatched = ListWatchedMoviesEntity(
      name: 'filmes_já_vistos', listMovies: listMovieEntity);

  const Failure error =
      GenericFailure(message: 'Erro Genérico', error: 'error', statusCode: 401);

  test('get my list watched movies...', () async {
    when(() => watchaedMoviesRepository.getListWatchedMovies(idList: 55255))
        .thenAnswer((_) async => Right(listWatched));

    final result = await usecase.call(idList: 55255);

    expect(result.fold((l) => null, (r) => r), listWatched);

    verify(() => watchaedMoviesRepository.getListWatchedMovies(idList: 55255))
        .called(1);
  });

  test('Error or get my list watched movies...', () async {
    when(() => watchaedMoviesRepository.getListWatchedMovies(idList: 55255))
        .thenAnswer((_) async => const Left(error));

    final result = await usecase.call(idList: 55255);

    expect(result.fold((l) => l, (r) => null), error);

    verify(() => watchaedMoviesRepository.getListWatchedMovies(idList: 55255))
        .called(1);
  });
}

// listener: (context, state) async {
//           if (state is CotacaoDolarErro || state is CotacaoDolarErroAtualizar) {
//             final result = await CoordinatorProvider.instance
//                 .mostrarBottomSheetGenericaErro(
//               acaoBotaoPrimario: () async {
//                 await _cubit.pegarCotacaoDolar(pagina: numeroPagina);
//               },
//             );
//             if (result != null) {
//               CoordinatorProvider.instance
//                   .get<ComumCartaoCoordinator>()
//                   .voltar();
//             }
//           }
//         },

