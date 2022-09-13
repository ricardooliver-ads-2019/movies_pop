import 'package:get_it/get_it.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/network/dio/dio_client.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network_connection/i_network_connection.dart';
import 'package:movies_pop/core/network_connection/network_connection_impl.dart';
import 'package:movies_pop/core/shared_features/status_movies/data/datasources/status_movies_datasources.dart';
import 'package:movies_pop/core/shared_features/status_movies/data/datasources/status_movies_datasources_impl.dart';
import 'package:movies_pop/core/shared_features/status_movies/data/repositories/status_movies_repository_impl.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/repositories/status_movies_repository.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/usecase/add_movie_to_watch_movies_list_usecase.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/usecase/add_movie_to_watched_movies_list_usecase.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/usecase/check_movie_in_my_list_watched_movies_usecase.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/usecase/get_status_movies_usecase.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/usecase/remove_movie_to_watch_movies_list_usecase.dart';
import 'package:movies_pop/core/shared_features/status_movies/domain/usecase/remove_movie_to_watched_movies_list_usecase.dart';
import 'package:movies_pop/core/user_lists_watched_movies/details_list_watched_movies.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_cubit_controller.dart';
import 'package:movies_pop/features/login/data/datasources/i_login_datasources.dart';
import 'package:movies_pop/features/login/data/datasources/login_datasources_impl.dart';
import 'package:movies_pop/features/login/data/repositories/login_repository_impl.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';
import 'package:movies_pop/features/login/domain/usecase/get_details_account.dart';
import 'package:movies_pop/features/login/domain/usecase/get_request_token_usecase.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_session_id_usecase.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_token_with_login_usecase.dart';
import 'package:movies_pop/features/login/presenter/controller/login_cubit_controller.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_cubit.dart';
import 'package:movies_pop/features/movies/home/data/datasources/home_datasource_impl.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';
import 'package:movies_pop/features/movies/home/data/repositories/home_repository_impl.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_playing_in_Brazil_now_usecase.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_popular_usecar.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/usecase_list_user/create_my_list_watched_movies_usecase.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/usecase_list_user/get_my_lists_usecase.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/cine_movies_cubit_controller/cine_movies_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/popular_cubit_controller/popular_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/controller/home_cubit_controller.dart';
import 'package:movies_pop/features/movies_details/data/datasources/movie_details_datasources.dart';
import 'package:movies_pop/features/movies_details/data/datasources/movie_details_datasources_impl.dart';
import 'package:movies_pop/features/movies_details/data/repositories/movie_details_repository_impl.dart';
import 'package:movies_pop/features/movies_details/domain/repositories/movie_details_repository.dart';
import 'package:movies_pop/features/movies_details/domain/usecase/get_movie_details_usecase.dart';
import 'package:movies_pop/features/movies_details/presenter/controller/movie_details_cubit_controller.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/card_details/card_buttons/controller/card_Buttons_cubit_controller.dart';
import 'package:movies_pop/features/watch_movies/data/datasources/watch_movies_datasources.dart';
import 'package:movies_pop/features/watch_movies/data/datasources/watch_movies_datasources_impl.dart';
import 'package:movies_pop/features/watch_movies/data/repositories/watch_movies_repository_impl.dart';
import 'package:movies_pop/features/watch_movies/domain/repositories/watch_movies_repository.dart';
import 'package:movies_pop/features/watch_movies/domain/usecase/get_list_watch_movies_usecase.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_cubit_controller.dart';
import 'package:movies_pop/features/watched_movies/data/datasources/watchaed_movies_datasource.dart';
import 'package:movies_pop/features/watched_movies/data/datasources/watchaed_movies_datasource_impl.dart';
import 'package:movies_pop/features/watched_movies/data/repositories/watchaed_movies_repository_impl.dart';
import 'package:movies_pop/features/watched_movies/domain/repositories/watchaed_movies_repository.dart';
import 'package:movies_pop/features/watched_movies/domain/usecase/get_my_list_watched_movies_usecase.dart';
import 'package:movies_pop/features/watched_movies/presenter/controller/watched_cubit_controller.dart';

GetIt getItDependency = GetIt.instance;

Future<void> getItDependencies() async {
  getItDependency
      .registerFactory<INetworkConnection>(() => NetworkConnectionImpl());

  getItDependency.registerSingleton<AuthSession>(AuthSession()..init());
  getItDependency.registerSingleton<DetailsListWatchedMovies>(
      DetailsListWatchedMovies()..init());

  getItDependency.registerLazySingleton<HttpClient>(
      () => DioClient(networkConnection: getItDependency()));

//=========================== FabButton =======================

  getItDependency.registerFactory<StatusMoviesDatasources>(() =>
      StatusMoviesDatasourcesImpl(
        detailsListWatchedMovies: getItDependency<DetailsListWatchedMovies>(),
        auth: getItDependency<AuthSession>(),
        client: getItDependency<HttpClient>(),
      ));

  getItDependency.registerFactory<StatusMoviesRepository>(() =>
      StatusMoviesRepositoryImpl(
          statusMoviesDatasources: getItDependency<StatusMoviesDatasources>()));

  getItDependency.registerFactory<GetStatusMoviesUsecase>(() =>
      GetStatusMoviesUsecase(
          statusMoviesRepository: getItDependency<StatusMoviesRepository>()));

  getItDependency.registerFactory<CheckMovieInMyListWatchedMoviesUsecase>(() =>
      CheckMovieInMyListWatchedMoviesUsecase(
          statusMoviesRepository: getItDependency<StatusMoviesRepository>()));

  getItDependency.registerFactory<AddMovieToWatchedMoviesListUsecase>(() =>
      AddMovieToWatchedMoviesListUsecase(
          statusMoviesRepository: getItDependency<StatusMoviesRepository>()));

  getItDependency.registerFactory<RemoveMovieToWatchedMoviesListUsecase>(() =>
      RemoveMovieToWatchedMoviesListUsecase(
          statusMoviesRepository: getItDependency<StatusMoviesRepository>()));

  getItDependency.registerFactory<AddMovieToWatchMoviesListUsecase>(() =>
      AddMovieToWatchMoviesListUsecase(
          statusMoviesRepository: getItDependency<StatusMoviesRepository>()));

  getItDependency.registerFactory<RemoveMovieToWatchMoviesListUsecase>(() =>
      RemoveMovieToWatchMoviesListUsecase(
          statusMoviesRepository: getItDependency<StatusMoviesRepository>()));

  getItDependency
      .registerFactory<FabButtonCubitController>(() => FabButtonCubitController(
            checkMovieInMyListWatchedMoviesUsecase:
                getItDependency<CheckMovieInMyListWatchedMoviesUsecase>(),
            getStatusMoviesUsecase: getItDependency<GetStatusMoviesUsecase>(),
            addMovieToWatchedMoviesListUsecase:
                getItDependency<AddMovieToWatchedMoviesListUsecase>(),
            removeMovieToWatchedMoviesListUsecase:
                getItDependency<RemoveMovieToWatchedMoviesListUsecase>(),
            addMovieToWatchMoviesListUsecase:
                getItDependency<AddMovieToWatchMoviesListUsecase>(),
            removeMovieToWatchMoviesListUsecase:
                getItDependency<RemoveMovieToWatchMoviesListUsecase>(),
          ));

//=========================== CardButtons =======================

  getItDependency.registerFactory<CardButtonsCubitController>(
      () => CardButtonsCubitController(
            getStatusMoviesUsecase: getItDependency<GetStatusMoviesUsecase>(),
            checkMovieInMyListWatchedMoviesUsecase:
                getItDependency<CheckMovieInMyListWatchedMoviesUsecase>(),
            addMovieToWatchMoviesListUsecase:
                getItDependency<AddMovieToWatchMoviesListUsecase>(),
            removeMovieToWatchMoviesListUsecase:
                getItDependency<RemoveMovieToWatchMoviesListUsecase>(),
            addMovieToWatchedMoviesListUsecase:
                getItDependency<AddMovieToWatchedMoviesListUsecase>(),
            removeMovieToWatchedMoviesListUsecase:
                getItDependency<RemoveMovieToWatchedMoviesListUsecase>(),
          ));

//=========================== Login ===========================

  getItDependency.registerFactory<ILoginDatasources>(
      () => LoginDatasourcesImpl(client: getItDependency<HttpClient>()));
  getItDependency.registerFactory<ILoginRepository>(() => LoginRepositoryImpl(
      loginDatasources: getItDependency<ILoginDatasources>()));
  getItDependency.registerFactory<GetRequestTokenUsecase>(() =>
      GetRequestTokenUsecase(
          iLoginRepository: getItDependency<ILoginRepository>()));
  getItDependency.registerFactory<ValidateTokenWithLoginUsecase>(() =>
      ValidateTokenWithLoginUsecase(
          repository: getItDependency<ILoginRepository>()));
  getItDependency.registerFactory<ValidateSessionIdUsecase>(() =>
      ValidateSessionIdUsecase(
          loginRepository: getItDependency<ILoginRepository>()));
  getItDependency.registerFactory<GetDetailsAccountUsecase>(() =>
      GetDetailsAccountUsecase(
          loginRepository: getItDependency<ILoginRepository>()));

  getItDependency.registerFactory<LoginCubitController>(
    () => LoginCubitController(
      authSession: getItDependency<AuthSession>(),
      getRequestTokenusecase: getItDependency<GetRequestTokenUsecase>(),
      validateTokenWithLoginUsecase:
          getItDependency<ValidateTokenWithLoginUsecase>(),
      validateSessionIdUsecase: getItDependency<ValidateSessionIdUsecase>(),
      getDetailsAccountUsecase: getItDependency<GetDetailsAccountUsecase>(),
      detailsListWatchedMovies: getItDependency<DetailsListWatchedMovies>(),
    ),
  );

//=========================== Home ===========================

  getItDependency.registerFactory<IHomeDatasource>(() => HomeDatasourceImpl(
      client: getItDependency<HttpClient>(),
      auth: getItDependency<AuthSession>()));

  getItDependency.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(datasource: getItDependency<IHomeDatasource>()));

  getItDependency.registerFactory<GetMoviesPlayingInBrazilNowUsecase>(() =>
      GetMoviesPlayingInBrazilNowUsecase(
          repository: getItDependency<HomeRepository>()));

  getItDependency.registerFactory<GetMoviesPopularUsecar>(() =>
      GetMoviesPopularUsecar(repository: getItDependency<HomeRepository>()));

  getItDependency.registerFactory<GetMyListsUsecase>(() =>
      GetMyListsUsecase(homeRepository: getItDependency<HomeRepository>()));

  getItDependency.registerFactory<CreateMyListWatchedMoviesUsecase>(() =>
      CreateMyListWatchedMoviesUsecase(
          homeRepository: getItDependency<HomeRepository>()));

  getItDependency.registerFactory<HomeCubitController>(() =>
      HomeCubitController(
          getMyListsUsecase: getItDependency<GetMyListsUsecase>(),
          createMyListWatchedMoviesUsecase:
              getItDependency<CreateMyListWatchedMoviesUsecase>(),
          detailsListWatchedMovies:
              getItDependency<DetailsListWatchedMovies>()));

//=========================== WatchMovies ===========================

  getItDependency.registerFactory<WatchMoviesDatasources>(() =>
      WatchMoviesDatasourcesImpl(
          client: getItDependency<HttpClient>(),
          auth: getItDependency<AuthSession>()));

  getItDependency.registerFactory<WatchMoviesRepository>(() =>
      WatchMoviesRepositoryImpl(
          watchMoviesDatasources: getItDependency<WatchMoviesDatasources>()));

  getItDependency.registerFactory<WatchMoviesCubitController>(() =>
      WatchMoviesCubitController(
          usecase: getItDependency<GetListWatchMoviesUsecase>()));

  getItDependency.registerFactory<GetListWatchMoviesUsecase>(() =>
      GetListWatchMoviesUsecase(
          watchMoviesRopository: getItDependency<WatchMoviesRepository>()));

//=========================== WatchedMovies ===========================

  getItDependency.registerFactory<WatchaedMoviesDatasource>(() =>
      WatchaedMoviesDatasourceImpl(
          client: getItDependency<HttpClient>(),
          idList: getItDependency<DetailsListWatchedMovies>()));

  getItDependency.registerFactory<WatchaedMoviesRepository>(() =>
      WatchaedMoviesRepositoryImpl(
          datasource: getItDependency<WatchaedMoviesDatasource>()));

  getItDependency.registerFactory<GetMyListWatchedMoviesUsecase>(() =>
      GetMyListWatchedMoviesUsecase(
          repository: getItDependency<WatchaedMoviesRepository>()));

  getItDependency
      .registerFactory<WatchedCubitController>(() => WatchedCubitController(
            detailsListWatchedMovies:
                getItDependency<DetailsListWatchedMovies>(),
            getMyListWatchedMoviesUsecase:
                getItDependency<GetMyListWatchedMoviesUsecase>(),
          ));
//=========================== MovieDetails ===========================
  getItDependency.registerFactory<MovieDetailsDatasources>(
      () => MovieDetailsDatasourcesImpl(client: getItDependency<HttpClient>()));
  getItDependency.registerFactory<MovieDetailsRepository>(() =>
      MovieDetailsRepositoryImpl(
          movieDetailsDatasources: getItDependency<MovieDetailsDatasources>()));
  getItDependency.registerFactory<GetMovieDetailsUsecase>(() =>
      GetMovieDetailsUsecase(
          movieDetailsRepository: getItDependency<MovieDetailsRepository>()));
  getItDependency.registerFactory<MovieDetailsCubitController>(() =>
      MovieDetailsCubitController(
          getMovieDetailsUsecase: getItDependency<GetMovieDetailsUsecase>()));

//=========================== Cubits ===========================

  getItDependency.registerFactory<MainNavigationPageCubit>(
      () => MainNavigationPageCubit());

  getItDependency.registerFactory<CineMoviesCubitController>(() =>
      CineMoviesCubitController(
          moviesPlayingInBrazilNowUsecase:
              getItDependency<GetMoviesPlayingInBrazilNowUsecase>()));

  getItDependency
      .registerFactory<PopularCubitController>(() => PopularCubitController(
            moviesPopularUsecar: getItDependency<GetMoviesPopularUsecar>(),
          ));
}
