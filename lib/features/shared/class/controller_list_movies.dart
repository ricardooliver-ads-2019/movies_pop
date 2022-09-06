import 'package:flutter/material.dart';

import '../entities/movie_entipy/movie_entipy.dart';

class ControllerListMovies extends ValueNotifier<List<MovieEntipy>> {
  ControllerListMovies({List<MovieEntipy>? value}) : super(value ?? []);

  void removeItem(int id) {
    value.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
