import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/network/http_client.dart';
import 'package:movies_pop/core/network/http_client_response.dart';
import 'package:movies_pop/features/movies/home/data/datasources/home_datasource_impl.dart';
import 'package:movies_pop/features/movies/home/data/datasources/i_home_datasource.dart';
import 'package:movies_pop/features/movies/home/data/models/my_lists_movies_model.dart';

import '../../../../../mocks/models.dart';
import '../../domain/usecase/mocks/mocks_my_lists.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late IHomeDatasource datasource;
  late HttpClientMock client;
  late AuthSession auth;

  setUp(() {
    client = HttpClientMock();
    auth = AuthSession();
    datasource = HomeDatasourceImpl(client: client, auth: auth);
  });

  const int page = 1;

  const urlBase = 'https://api.themoviedb.org/3/movie/now_playing';
  const urlBaseMoviesPopular = 'https://api.themoviedb.org/3/movie/popular';

  test('deve obter uma resposta de sucesso', () async {
    // Arrange
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => HttpClientResponseSuccess(
            data: movieMock, statusCode: 200, statusMessage: 'success'));
    // Act
    final result = await datasource.getMoviesPlayingInBrazilNow(page: page);

    //Asset
    verify(() => client.get(urlBase, queryParameters: {
          'api_key': '899e6212bb39852b379032c9c5e25689',
          'language': 'pt-br',
          'regio': 'Brazil',
          'page': page
        })).called(1);
  });

  test('deve obter uma resposta de sucesso', () async {
    // Arrange
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => HttpClientResponseSuccess(
            data: movieMock, statusCode: 200, statusMessage: 'success'));
    // Act
    final result = await datasource.getMoviesPopular(page: page);
    //Asset
    verify(() => client.get(urlBaseMoviesPopular, queryParameters: {
          'api_key': '899e6212bb39852b379032c9c5e25689',
          'language': 'pt-br',
          'regio': 'Brazil',
          'page': page
        })).called(1);
  });

  test('deve obter uma resposta de sucesso', () async {
    // Arrange
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => HttpClientResponseSuccess(
              data: movieMock,
              statusCode: 200,
              statusMessage: 'success',
            ));
    // Act
    final result = await datasource.getMoviesPopular(page: page);
    //Asset
    verify(() => client.get(urlBaseMoviesPopular, queryParameters: {
          'api_key': '899e6212bb39852b379032c9c5e25689',
          'language': 'pt-br',
          'regio': 'Brazil',
          'page': page
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

  test('watchaed movies datasource impl ...', () async {
    when(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => HttpClientResponseSuccess(
            data: mockMylists, statusCode: 200, statusMessage: 'success'));

    final result = await datasource.getMylists();

    final response =
        MyListsMoviesModel.fromJson((result.data as Map<String, dynamic>));

    expect(response, MyListsMoviesModel.fromJson(mockMylists));

    verify(() =>
            client.get(any(), queryParameters: any(named: 'queryParameters')))
        .called(1);
  });
}
