import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/models/movie_model/movie_model.dart';

import '../../../../../mocks/models.dart';

void main() {
  final DateTime tDate = DateTime.parse('2022-03-04');
  final MovieModel tMovieModel = MovieModel(
    id: 86,
    title: 'A Day to Die',
    stars: 6.3,
    //genre: tListGeneres,
    posterPath: '/8Kce1utfytAG5m1PbtVoDzmDZJH.jpg',
    backdropPath: '/8Kce1utfytAG5m1PbtVoDzmDZJH.jpg',
    releaseDate: tDate,
  );

  print(tDate);

  test('deve responder que MovieModel é uma subclass de MovieEntipy', () {
    expect(tMovieModel, isA<MovieEntipy>());
  });

  test('deve obter como retorno a validação do model', () {
    print(tDate);
    final Map<String, dynamic> jsonMap = json.decode(movieMock);
    final result = MovieModel.fromJson(jsonMap);
    expect(result, tMovieModel);
  });
}
