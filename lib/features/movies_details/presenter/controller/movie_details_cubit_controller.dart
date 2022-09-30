import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';
import 'package:movies_pop/features/movies_details/domain/usecase/get_movie_details_usecase.dart';

part 'movie_details_state.dart';

class MovieDetailsCubitController extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUsecase _getMovieDetailsUsecase;

  MovieDetailsCubitController({
    required GetMovieDetailsUsecase getMovieDetailsUsecase,
  })  : _getMovieDetailsUsecase = getMovieDetailsUsecase,
        super(InitialMovieDetails());

  Future<void> getMovieDetails({required int movieId}) async {
    emit(LoadingMovieDetails());
    final result = await _getMovieDetailsUsecase.call(movieId: movieId);
    result.fold(
      (error) => emit(ErrorMovieDetails(error: error)),
      (movie) => emit(SuccessMovieDetails(movie: movie)),
    );
  }
}
