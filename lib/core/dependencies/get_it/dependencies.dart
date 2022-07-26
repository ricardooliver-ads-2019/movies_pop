import 'package:get_it/get_it.dart';
import 'package:movies_pop/core/network/dio/dio_client.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network_connection/i_network_connection.dart';
import 'package:movies_pop/core/network_connection/network_connection_impl.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_cubit.dart';
import 'package:movies_pop/features/movies/home/data/datasources/home_datasource_impl.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';
import 'package:movies_pop/features/movies/home/data/repositories/home_repository_impl.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_playing_in_Brazil_now_usecase.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_popular_usecar.dart';
import 'package:movies_pop/features/movies/home/presenter/home_controller/home_cubit_controller.dart';

GetIt getItDependency = GetIt.instance;

Future<void> getItDependencies() async {
  getItDependency
      .registerFactory<INetworkConnection>(() => NetworkConnectionImpl());

  getItDependency.registerLazySingleton<HttpClient>(
      () => DioClient(networkConnection: getItDependency()));

  getItDependency.registerLazySingleton<IHomeDatasource>(
      () => HomeDatasourceImpl(client: getItDependency<HttpClient>()));

  getItDependency.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(datasource: getItDependency<IHomeDatasource>()));

  getItDependency.registerLazySingleton<GetMoviesPlayingInBrazilNowUsecase>(
      () => GetMoviesPlayingInBrazilNowUsecase(
          repository: getItDependency<HomeRepository>()));

  getItDependency.registerLazySingleton<GetMoviesPopularUsecar>(() =>
      GetMoviesPopularUsecar(repository: getItDependency<HomeRepository>()));

//=========================== Cubits ===========================
  getItDependency.registerFactory<MainNavigationPageCubit>(
      () => MainNavigationPageCubit());

  getItDependency
      .registerFactory<HomeCubitController>(() => HomeCubitController(
            moviesPlayingInBrazilNowUsecase:
                getItDependency<GetMoviesPlayingInBrazilNowUsecase>(),
            moviesPopularUsecar: getItDependency<GetMoviesPopularUsecar>(),
          ));
}
