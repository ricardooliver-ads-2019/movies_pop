import 'package:get_it/get_it.dart';
import 'package:movies_pop/core/network/dio/dio_client.dart';
import 'package:movies_pop/core/network/http_client.dart';

GetIt getItDependency = GetIt.instance;

Future<void> getItDependencies() async {
  getItDependency.registerLazySingleton<HttpClient>(() => DioClient());
}
