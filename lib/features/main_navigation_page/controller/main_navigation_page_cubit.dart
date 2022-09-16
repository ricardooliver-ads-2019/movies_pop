import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/user_lists_watched_movies/details_list_watched_movies.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_state.dart';
import 'package:movies_pop/features/main_navigation_page/main_navigation_page.dart';

class MainNavigationPageCubit extends Cubit<MainNavigationPageState> {
  static const INDEX_PAGE_EXIT = 3;
  final AuthSession _authSession;
  final DetailsListWatchedMovies _detailsListWatchedMovies;
  MainNavigationPageCubit(
      {required AuthSession authSession,
      required DetailsListWatchedMovies detailsListWatchedMovies})
      : _authSession = authSession,
        _detailsListWatchedMovies = detailsListWatchedMovies,
        super(MainNavigationPageState.intial());

  void goToPage(int page, BuildContext context) async {
    if (page == INDEX_PAGE_EXIT) {
      await _authSession.resetSessionId();
      await _detailsListWatchedMovies.resetIdListWatchMovies();
      Navigator.of(context).popAndPushNamed('/login');
    } else {
      emit(state.copyWith(pageIndex: page));
      navigatorState.currentState!.pushNamed(
        state.page[page],
      );
    }
  }
}
