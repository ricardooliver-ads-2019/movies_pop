import 'package:movies_pop/features/movies/home/domain/entities/lists_movies__entities/my_list_entipy.dart';

class MyListsModel extends MyListEntipy {
  @override
  final int id;
  const MyListsModel({
    required this.id,
    required String name,
    required String description,
  }) : super(id: id, name: name, description: description);

  factory MyListsModel.fronJson({required Map<String, dynamic> json}) {
    return MyListsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };
}
