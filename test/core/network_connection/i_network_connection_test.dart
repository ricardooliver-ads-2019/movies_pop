import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/network_connection/i_network_connection.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

class MockNetworkConnectionImpl extends Mock implements INetworkConnection {}

void main() {
  late INetworkConnection networkConnectionImpl;
  late DataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkConnectionImpl = MockNetworkConnectionImpl();
  });
  final tHasConnectionFutureTrue = Future.value(true);
  final tHasConnectionFutureFalse = Future.value(false);
  group('Teste de verificação de internet', () {
    test('deve retornar que não há conexão de rede', () async {
      when(() => mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => tHasConnectionFutureFalse);

      when(() => networkConnectionImpl.isConnected)
          .thenAnswer((_) async => Future.value(true));

      final result = await networkConnectionImpl.isConnected;
      //verify(() => mockDataConnectionChecker.hasConnection).called(1);
      verify(() => networkConnectionImpl.isConnected).called(1);
      expect(result, true);
    });

    test('deve retornar que não há conexão de rede', () async {
      when(() => mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => tHasConnectionFutureTrue);

      when(() => networkConnectionImpl.isConnected)
          .thenAnswer((_) async => Future.value(false));

      final result = await networkConnectionImpl.isConnected;
      //verify(() => mockDataConnectionChecker.hasConnection).called(1);
      verify(() => networkConnectionImpl.isConnected).called(1);
      expect(result, false);
    });
  });
}
