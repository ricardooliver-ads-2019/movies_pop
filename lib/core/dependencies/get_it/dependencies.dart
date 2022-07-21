import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_pop/core/network/dio/dio_client.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network_connection/i_network_connection.dart';
import 'package:movies_pop/core/network_connection/network_connection_impl.dart';

GetIt getItDependency = GetIt.instance;

Future<void> getItDependencies() async {
  getItDependency
      .registerSingleton<DataConnectionChecker>(DataConnectionChecker());
  getItDependency.registerFactory<INetworkConnection>(() =>
      NetworkConnectionImpl(
          connectionChecker: getItDependency<DataConnectionChecker>()));
  getItDependency.registerLazySingleton<HttpClient>(() =>
      DioClient(networkConnection: getItDependency<NetworkConnectionImpl>()));
}
