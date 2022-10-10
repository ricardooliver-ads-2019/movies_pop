import 'package:bloc/bloc.dart';
import 'package:movies_pop/features/shared/shared_features/rate_movies/domain/usecases/delete_rating_movie_usecase.dart';
import 'package:movies_pop/features/shared/shared_features/rate_movies/domain/usecases/rate_movie_usecase.dart';
import 'package:movies_pop/features/shared/shared_features/rate_movies/presenter/controller/bottom_sheet_rate_movie_state.dart';
import 'package:movies_pop/features/shared/shared_features/status_movies/domain/usecase/get_status_movies_usecase.dart';

class BottomSheetRateMovieCubitController
    extends Cubit<BottomSheetRateMovieState> {
  final GetStatusMoviesUsecase _getStatusMoviesUsecase;
  final RateMovieUsecase _rateMovieUsecase;
  final DeleteRatingMovieUsecase _deleteRatingMovieUsecase;
  BottomSheetRateMovieCubitController({
    required GetStatusMoviesUsecase getStatusMoviesUsecase,
    required RateMovieUsecase rateMovieUsecase,
    required DeleteRatingMovieUsecase deleteRatingMovieUsecase,
  })  : _getStatusMoviesUsecase = getStatusMoviesUsecase,
        _rateMovieUsecase = rateMovieUsecase,
        _deleteRatingMovieUsecase = deleteRatingMovieUsecase,
        super(const InitialBottomSheetRateMovieState());

  Future<void> getStatusRatingMovie({required int movieId}) async {
    final result = await _getStatusMoviesUsecase.call(movieId: movieId);
    result.fold((error) => emit(ErrorBottomSheetRateMovieState(error: error)),
        (statusMovies) {
      if (statusMovies.rated is bool) {
        emit(const SuccessStatusRatingMovie());
      } else {
        emit(SuccessStatusRatingMovie(
            filmIsRated: true, rate: statusMovies.rated));
      }
    });
  }

  Future<void> rateMovie({required int movieId, required double rating}) async {
    final result =
        await _rateMovieUsecase.call(movieId: movieId, rating: rating);
    result.fold((error) => emit(ErrorBottomSheetRateMovieState(error: error)),
        (statusMovies) {
      emit(
        SuccessRateMovieState(
            filmIsRated: statusMovies,
            rate: rating,
            requestSuccess: statusMovies),
      );
    });
  }

  Future<void> deleteRatingMovie({required int movieId}) async {
    final result = await _deleteRatingMovieUsecase.call(
      movieId: movieId,
    );
    result.fold((error) => emit(ErrorBottomSheetRateMovieState(error: error)),
        (statusMovies) {
      emit(
        SuccessDeleteRatingMovieState(
            filmIsRated: false, rate: 0.0, requestSuccess: statusMovies),
      );
    });
  }
}
