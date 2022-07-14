import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies/home/data/datasources/home_datasource_impl.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';

import '../../../../../mocks/models_test.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late IHomeDatasource datasource;
  late HttpClientMock client;

  setUp(() {
    client = HttpClientMock();
    datasource = HomeDatasourceImpl(client: client);
  });

  const urlBase = 'https://api.themoviedb.org/3/movie/now_playing';

  test('deve obter uma resposta de sucesso', () async {
    // Arrange
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => HttpClientResponseSuccess(
            data: movieMock, statusCode: 200, statusMessage: 'success'));
    // Act
    final result = await datasource.getMoviesPlayingInBrazilNow();
    //Asset
    verify(() => client.get(urlBase, queryParameters: {
          'api_key': '899e6212bb39852b379032c9c5e25689',
          'language': 'pt-br',
          'region': 'Brazil',
          'page': 2
        })).called(1);
  });

  // test('deve obter uma resposta de sucesso', () async {
  //   when(() => client.get(any())).thenAnswer((_) async =>
  //       HttpClientResponseSuccess(
  //           data: movieMock, statusCode: 200, statusMessage: 'success'));

  //   final result = await datasource.getMoviesPlayingInBrazilNow();
  //   expect(
  //       result,
  //       HttpClientResponseSuccess(
  //           data: movieMock, statusCode: 200, statusMessage: 'success'));
  //   verify(() => client.get(any())).called(1);
  // });
}
