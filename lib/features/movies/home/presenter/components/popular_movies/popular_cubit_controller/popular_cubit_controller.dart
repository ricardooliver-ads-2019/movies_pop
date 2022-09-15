import 'package:bloc/bloc.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/get_movies_popular_usecar.dart';

import 'popular_state.dart';

class PopularCubitController extends Cubit<PopularState> {
  final GetMoviesPopularUsecar _moviesPopularUsecar;
  PopularCubitController({required GetMoviesPopularUsecar moviesPopularUsecar})
      : _moviesPopularUsecar = moviesPopularUsecar,
        super(InitialPopularState());

  Future<void> getMoviesPopular({required int page}) async {
    emit(LoadingPopularState());
    final result = await _moviesPopularUsecar.call(page: page);
    result.fold(
      (error) => emit(
        ErrorPopularState(error: error),
      ),
      (pagePopularMovies) => emit(
        SuccessPopularState(pagePopularMovies: pagePopularMovies),
      ),
    );
  }
}
