import 'package:equatable/equatable.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_list_entipy.dart';

class MyListsMoviesEntity extends Equatable {
  const MyListsMoviesEntity({
    required this.page,
    required this.myLists,
    required this.totalPages,
    required this.totalResults,
  });
  final int page;
  final List<MyListEntipy> myLists;
  final int totalPages;
  final int totalResults;

  @override
  List<Object?> get props => [page, myLists, totalPages, totalResults];
}
