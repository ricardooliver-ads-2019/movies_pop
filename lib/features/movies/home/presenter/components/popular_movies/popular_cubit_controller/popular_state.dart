import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movies_page_entipy/movies_page_entipy.dart';

class PopularState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialPopularState extends PopularState {
  @override
  List<Object?> get props => [];
}

class LoadingPopularState extends PopularState {
  @override
  List<Object> get props => [];
}

class SuccessPopularState extends PopularState {
  SuccessPopularState({required this.pagePopularMovies});

  final MoviesPageEntipy pagePopularMovies;

  @override
  List<Object> get props => [];
}

class ErrorPopularState extends PopularState {
  ErrorPopularState({required this.error});

  final Failure error;

  @override
  List<Object> get props => [];
}
