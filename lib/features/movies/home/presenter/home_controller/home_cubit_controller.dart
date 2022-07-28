import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movies_page_entipy/movies_page_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_playing_in_Brazil_now_usecase.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_popular_usecar.dart';

part 'home_state.dart';

class HomeCubitController extends Cubit<HomeState> {
  final GetMoviesPlayingInBrazilNowUsecase _moviesPlayingInbrazilNowUsecase;
  final GetMoviesPopularUsecar _moviesPopularUsecar;

  HomeCubitController({
    required GetMoviesPlayingInBrazilNowUsecase moviesPlayingInBrazilNowUsecase,
    required GetMoviesPopularUsecar moviesPopularUsecar,
  })  : _moviesPlayingInbrazilNowUsecase = moviesPlayingInBrazilNowUsecase,
        _moviesPopularUsecar = moviesPopularUsecar,
        super(const HomeState.initial());

  Future<void> getMoviesPlayingInBrazilNowUsecase(int page) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _moviesPlayingInbrazilNowUsecase.call(page: page);
    result.fold(
      (error) => emit(state.copyWith(
        status: HomeStatus.error,
        error: error,
      )),
      (pageMovies) => emit(state.copyWith(
        status: HomeStatus.success,
        pageCineMovies: pageMovies,
      )),
    );
  }

  Future<void> getPageMoviesPopular(int page) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _moviesPopularUsecar.call(page: page);
    result.fold(
      (error) => emit(state.copyWith(
        status: HomeStatus.error,
        error: error,
      )),
      (pageMoviesPopular) => emit(state.copyWith(
        status: HomeStatus.success,
        pagePopularMovies: pageMoviesPopular,
      )),
    );
  }
}
