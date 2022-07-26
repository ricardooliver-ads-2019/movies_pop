import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_cubit.dart';
import 'package:movies_pop/features/main_navigation_page/main_navigation_page.dart';
import 'package:movies_pop/features/movies/home/presenter/home_controller/home_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/home_screen.dart';
import 'package:movies_pop/features/watch_movies/watch_movies_screen.dart';
import 'package:movies_pop/features/watched_movies/watched_movies_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const mainNavigationPage = '/main_navigation_page';
  static const home = '/home';
  static const watchedMovies = '/watched_movies';
  static const watchMovies = '/watch_movies';
  static const movieDetails = '/movie_details';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainNavigationPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getItDependency.get<MainNavigationPageCubit>(),
            child: const MainNavigationPage(),
          ),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (contex) => BlocProvider(
            create: (contex) => getItDependency.get<HomeCubitController>(),
            child: const HomeScreen(),
          ),
        );

      case AppRoutes.watchedMovies:
        return MaterialPageRoute(builder: (_) => const WatchedMoviesScreen());

      case AppRoutes.watchMovies:
        return MaterialPageRoute(builder: (_) => const WatchMoviesScreen());

      default:
        null;
    }
    return null;
  }
}
