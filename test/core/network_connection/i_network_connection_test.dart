import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/network_connection/network_connection_impl.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  late NetworkConnectionImpl networkConnectionImpl;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkConnectionImpl =
        NetworkConnectionImpl(connectionChecker: mockDataConnectionChecker);
  });

  group('Teste de verificação de internet', () {
    test('deve retornar que há conexão de rede', () async {
      final tHasConnectionFuture = Future.value(true);
      when(() => mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      final result = await networkConnectionImpl.isConnected;
      verify(() => mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });

    test('deve retornar que não há conexão de rede', () async {
      final tHasConnectionFuture = Future.value(false);
      when(() => mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      final result = await networkConnectionImpl.isConnected;
      verify(() => mockDataConnectionChecker.hasConnection);
      expect(result, false);
    });
  });
}
