part of 'movie_details_cubit_controller.dart';

abstract class MovieDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialMovieDetails extends MovieDetailsState {}

class LoadingMovieDetails extends MovieDetailsState {}

class SuccessMovieDetails extends MovieDetailsState {
  final MovieDetailsEntity movie;

  SuccessMovieDetails({required this.movie});
  @override
  List<Object?> get props => [movie];
}

class ErrorMovieDetails extends MovieDetailsState {
  final Failure error;
  ErrorMovieDetails({required this.error});

  @override
  List<Object?> get props => [error];
}
