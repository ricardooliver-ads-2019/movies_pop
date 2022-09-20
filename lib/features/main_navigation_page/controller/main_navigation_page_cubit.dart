import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/routes/app_routes.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';
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

  void goToPage(int page, BuildContext context) {
    if (page == INDEX_PAGE_EXIT) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sair',
                  style: AppTextStyles.titleHomeM,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.logout_outlined),
              ],
            ),
          ),
          content: Text('Deseja realmente se deslogar do aplicativo?',
              style: AppTextStyles.trailingRegular),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text('Cancelar', style: AppTextStyles.trailingRegular),
            ),
            TextButton(
              onPressed: () async {
                await _authSession.resetSessionId();
                await _detailsListWatchedMovies.resetIdListWatchMovies();
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login,
                    ModalRoute.withName(AppRoutes.mainNavigationPage));
              },
              child: Text('Sim', style: AppTextStyles.trailingRegular),
            ),
          ],
        ),
      );
    } else {
      emit(state.copyWith(pageIndex: page));
      navigatorState.currentState!.pushNamed(
        state.page[page],
      );
    }
  }
}
