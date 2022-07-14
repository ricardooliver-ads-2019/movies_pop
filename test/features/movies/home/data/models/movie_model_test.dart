import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_pop/features/movies/home/data/models/movie_model.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

import '../../../../../mocks/models_test.dart';

void main() {
  final DateTime tDate = DateTime(2022 - 03 - 04);
  final MovieModel tMovieModel = MovieModel(
    id: 86,
    title: 'A Day to Die',
    stars: 6.3,
    //genre: tListGeneres,
    posterPath: '/8Kce1utfytAG5m1PbtVoDzmDZJH.jpg',
    releaseDate: tDate,
  );
  test('deve responder que MovieModel é uma subclass de MovieEntipy', () {
    expect(tMovieModel, isA<MovieEntipy>());
  });

  test('deve obter como retorno a validação do model', () {
    final Map<String, dynamic> jsonMap = json.decode(movieMock);
    final result = MovieModel.fromJson(jsonMap);
    expect(result, tMovieModel);
  });
}
