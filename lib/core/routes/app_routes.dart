import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/login/presenter/controller/login_cubit_controller.dart';
import 'package:movies_pop/features/login/presenter/screen/login_screen.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_cubit.dart';
import 'package:movies_pop/features/main_navigation_page/main_navigation_page.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/controller/home_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/home_screen.dart';
import 'package:movies_pop/features/splash/splash_screen.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_cubit_controller.dart';
import 'package:movies_pop/features/watch_movies/presenter/screen/watch_movies_screen.dart';
import 'package:movies_pop/features/watched_movies/presenter/controller/watched_cubit_controller.dart';
import 'package:movies_pop/features/watched_movies/presenter/screen/watched_movies_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
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

      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<LoginCubitController>(
                  create: (_) => getItDependency.get<LoginCubitController>(),
                  child: const LoginScreen(),
                ));

      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => getItDependency.get<HomeCubitController>(),
                  child: const HomeScreen(),
                ));

      case AppRoutes.watchedMovies:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => getItDependency.get<WatchedCubitController>(),
                  child: const WatchedMoviesScreen(),
                ));

      case AppRoutes.watchMovies:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) =>
                      getItDependency.get<WatchMoviesCubitController>(),
                  child: const WatchMoviesScreen(),
                ));

      default:
        null;
    }
    return null;
  }
}
