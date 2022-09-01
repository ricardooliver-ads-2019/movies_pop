import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_playing_in_Brazil_now_usecase.dart';

import '../../../../../../shared/entities/movie_entipy/movie_entipy.dart';
import '../../../../../../shared/entities/movies_page_entipy/movies_page_entipy.dart';

part 'cine_movies_state.dart';

class CineMoviesCubitController extends Cubit<CineMoviesState> {
  final GetMoviesPlayingInBrazilNowUsecase _moviesPlayingInbrazilNowUsecase;

  CineMoviesCubitController({
    required GetMoviesPlayingInBrazilNowUsecase moviesPlayingInBrazilNowUsecase,
  })  : _moviesPlayingInbrazilNowUsecase = moviesPlayingInBrazilNowUsecase,
        super(InitialState());

  List<MovieEntipy> list = [];

  Future getMoviesPlayingInBrazilNowUsecase({required int page}) async {
    //print(list);
    emit(LoadingState());
    final result = await _moviesPlayingInbrazilNowUsecase.call(page: page);
    result.fold(
      (error) => emit(ErrorState(error: error)),
      (pageCineMovies) => emit(
        SuccessState(
          pageCineMovies: MoviesPageEntipy(
            page: pageCineMovies.page,
            totalResults: pageCineMovies.totalResults,
            totalPages: pageCineMovies.totalPages,
            movies: list = List.of(list)
              ..addAll(pageCineMovies.movies as List<MovieEntipy>),
          ),
        ),
      ),
    );
    //print(list.length);
  }
}
