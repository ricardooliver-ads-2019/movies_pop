import 'package:get_it/get_it.dart';
import 'package:movies_pop/core/network/dio/dio_client.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network_connection/i_network_connection.dart';
import 'package:movies_pop/core/network_connection/network_connection_impl.dart';
import 'package:movies_pop/features/auth/auth.dart';
import 'package:movies_pop/features/login/data/datasources/i_login_datasources.dart';
import 'package:movies_pop/features/login/data/datasources/login_datasources_impl.dart';
import 'package:movies_pop/features/login/data/repositories/login_repository_impl.dart';
import 'package:movies_pop/features/login/domain/repositories/i_login_repository.dart';
import 'package:movies_pop/features/login/domain/usecase/get_details_account.dart';
import 'package:movies_pop/features/login/domain/usecase/get_request_token_usecase.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_session_id_usecase.dart';
import 'package:movies_pop/features/login/domain/usecase/validate_token_with_login_usecase.dart';
import 'package:movies_pop/features/login/presenter/componets/animated.dart';
import 'package:movies_pop/features/login/presenter/controller/login_cubit_controller.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_cubit.dart';
import 'package:movies_pop/features/movies/home/data/datasources/home_datasource_impl.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';
import 'package:movies_pop/features/movies/home/data/repositories/home_repository_impl.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_playing_in_Brazil_now_usecase.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_popular_usecar.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/cine_movies_cubit_controller/cine_movies_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/popular_cubit_controller/popular_cubit_controller.dart';

GetIt getItDependency = GetIt.instance;

Future<void> getItDependencies() async {
  getItDependency.registerSingleton<AnimatedButtonLogin>(AnimatedButtonLogin());
  getItDependency
      .registerFactory<INetworkConnection>(() => NetworkConnectionImpl());

  getItDependency.registerSingleton<AuthSession>(AuthSession()..init());

  getItDependency.registerLazySingleton<HttpClient>(
      () => DioClient(networkConnection: getItDependency()));

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

//=========================== Home ===========================

  getItDependency.registerFactory<IHomeDatasource>(
      () => HomeDatasourceImpl(client: getItDependency<HttpClient>()));

  getItDependency.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(datasource: getItDependency<IHomeDatasource>()));

  getItDependency.registerFactory<GetMoviesPlayingInBrazilNowUsecase>(() =>
      GetMoviesPlayingInBrazilNowUsecase(
          repository: getItDependency<HomeRepository>()));

  getItDependency.registerFactory<GetMoviesPopularUsecar>(() =>
      GetMoviesPopularUsecar(repository: getItDependency<HomeRepository>()));

//=========================== Cubits ===========================
  getItDependency.registerFactory<LoginCubitController>(() =>
      LoginCubitController(
        authSession: getItDependency<AuthSession>(),
        getRequestTokenusecase: getItDependency<GetRequestTokenUsecase>(),
        validateTokenWithLoginUsecase:
            getItDependency<ValidateTokenWithLoginUsecase>(),
        validateSessionIdUsecase: getItDependency<ValidateSessionIdUsecase>(),
        getDetailsAccountUsecase: getItDependency<GetDetailsAccountUsecase>(),
      ));

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
