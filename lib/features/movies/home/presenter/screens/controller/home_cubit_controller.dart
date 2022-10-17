import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/user_lists_watched_movies/details_list_watched_movies.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_list_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/usecase_list_user/create_my_list_watched_movies_usecase.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/usecase_list_user/get_my_lists_usecase.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/controller/home_state.dart';

class HomeCubitController extends Cubit<HomeState> {
  final GetMyListsUsecase _getMyListsUsecase;
  final CreateMyListWatchedMoviesUsecase _createMyListWatchedMoviesUsecase;
  final DetailsListWatchedMovies _detailsListWatchedMovies;

  HomeCubitController({
    required GetMyListsUsecase getMyListsUsecase,
    required CreateMyListWatchedMoviesUsecase createMyListWatchedMoviesUsecase,
    required DetailsListWatchedMovies detailsListWatchedMovies,
  })  : _createMyListWatchedMoviesUsecase = createMyListWatchedMoviesUsecase,
        _getMyListsUsecase = getMyListsUsecase,
        _detailsListWatchedMovies = detailsListWatchedMovies,
        super(InitalHomeState());

  Future<void> getMyList() async {
    MyListEntipy? myList;
    emit(LoadingHomeState());
    final result = await _getMyListsUsecase.call();
    result.fold((erro) => emit(ErrorHomeState(error: erro)), (lists) {
      if (lists.myLists.isNotEmpty) {
        for (var list in lists.myLists) {
          if (list.name == 'filmes_já_vistos') {
            myList = list;
            _detailsListWatchedMovies.saveIdListWatchMovies(idList: list.id);
            _detailsListWatchedMovies.init();
            emit(SuccessHomeState());
            break;
          }
        }
        if (myList == null) {
          createMyListWatchedMoviesUsecase();
        }
      } else {
        createMyListWatchedMoviesUsecase();
      }
    });
  }

  Future<void> createMyListWatchedMoviesUsecase() async {
    emit(LoadingHomeState());
    final result =
        await _createMyListWatchedMoviesUsecase.createMyListWatchedMovies();
    result.fold((error) => emit(ErrorHomeState(error: error)), (listId) {
      _detailsListWatchedMovies.saveIdListWatchMovies(
          idList: listId.idListWatchedMovies);
      _detailsListWatchedMovies.init();
      emit(SuccessHomeState());
    });
  }
}
