import 'package:equatable/equatable.dart';

class TrailerMovieEntity extends Equatable {
  final String regio;
  final String id;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  const TrailerMovieEntity({
    required this.regio,
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
  });

  @override
  List<Object?> get props => [regio, id, name, key, site, size, type, official];
}
