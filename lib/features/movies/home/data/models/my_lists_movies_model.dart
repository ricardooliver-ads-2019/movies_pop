import 'package:movies_pop/features/movies/home/data/models/my_lists_model.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_list_entipy.dart';
import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_lists_movies_entity.dart';

class MyListsMoviesModel extends MyListsMoviesEntity {
  const MyListsMoviesModel({
    required int page,
    required List<MyListEntipy> myLists,
    required int totalPages,
    required int totalResults,
  }) : super(
            page: page,
            myLists: myLists,
            totalPages: totalPages,
            totalResults: totalResults);
  factory MyListsMoviesModel.fromJson(Map<String, dynamic> json) {
    return MyListsMoviesModel(
      page: json['page'],
      myLists: (json['results'] as List)
          .map((list) => MyListsModel.fronJson(json: list))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
