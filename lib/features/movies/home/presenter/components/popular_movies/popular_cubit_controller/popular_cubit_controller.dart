import 'package:bloc/bloc.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movies_page_entipy/movies_page_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_popular_usecar.dart';

import 'popular_state.dart';

class PopularCubitController extends Cubit<PopularState> {
  List<MovieEntipy> listMovies = [];
  final GetMoviesPopularUsecar _moviesPopularUsecar;
  PopularCubitController({required GetMoviesPopularUsecar moviesPopularUsecar})
      : _moviesPopularUsecar = moviesPopularUsecar,
        super(InitialPopularState());

  Future<void> getMoviesPopular({required int page}) async {
    emit(LoadingPopularState());
    final result = await _moviesPopularUsecar.call(page: page);
    //print(result);
    result.fold(
      (error) => emit(
        ErrorPopularState(error: error),
      ),
      (pagePopularMovies) => emit(
        SuccessPopularState(
          pagePopularMovies: MoviesPageEntipy(
            page: pagePopularMovies.page,
            movies: listMovies = List.of(listMovies)
              ..addAll(pagePopularMovies.movies),
            totalPages: pagePopularMovies.totalPages,
            totalResults: pagePopularMovies.totalResults,
          ),
        ),
      ),
    );
  }
}
