import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:movies_pop/core/network_connection/i_network_connection.dart';

class NetworkConnectionImpl implements INetworkConnection {
  final DataConnectionChecker connectionChecker;

  NetworkConnectionImpl({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
