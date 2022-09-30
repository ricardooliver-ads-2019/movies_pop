import 'package:dartz/dartz.dart';
import 'package:movies_pop/core/erros/failures.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/list_watchaed_movies_Id_entity.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_lists_movies_entity.dart';
import 'package:movies_pop/features/shared/entities/movies_page_entipy/movies_page_entipy.dart';

abstract class HomeRepository {
  Future<Either<Failure, MoviesPageEntipy>> getMoviesPlayingInBrazilNow(
      {required int page});
  Future<Either<Failure, MoviesPageEntipy>> getMoviesPopular(
      {required int page});
  Future<Either<Failure, MyListsMoviesEntity>> getMyLists();
  Future<Either<Failure, ListWatchaedMoviesIdEntity>>
      createMyListWatchedMovies();
}
