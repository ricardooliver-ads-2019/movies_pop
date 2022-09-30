import 'package:movies_pop/features/movies_details/data/models/genre_model.dart';
import 'package:movies_pop/features/movies_details/data/models/trailer_movie_model.dart';
import 'package:movies_pop/features/movies_details/domain/entities/genre_entity.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';
import 'package:movies_pop/features/movies_details/domain/entities/trailer_movie_entity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  MovieDetailsModel({
    required int id,
    required String title,
    required String? posterPath,
    required String? backdropPath,
    required String sinopse,
    required int runtime,
    required double stars,
    required DateTime? releaseDate,
    required List<String> urlImages,
    required List<GenreEntity> genre,
    required List<TrailerMovieEntity> trailers,
  }) : super(
          id: id,
          title: title,
          posterPath: posterPath,
          backdropPath: backdropPath,
          sinopse: sinopse,
          runtime: runtime,
          stars: stars,
          releaseDate: releaseDate,
          urlImages: urlImages,
          genre: genre,
          trailers: trailers,
        );

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    var urlImagesPosters = map['images']['backdrops'];
    var urlImages = urlImagesPosters
            ?.map<String>(
                (i) => 'https://image.tmdb.org/t/p/w500${i['file_path']}')
            .toList() ??
        [];
    return MovieDetailsModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      posterPath: map['poster_path'],
      sinopse: map['overview'] == '' ? 'Sem Descrição' : map['overview'],
      backdropPath: map['backdrop_path'],
      stars: map['vote_average']?.toDouble() ?? 0.0,
      releaseDate: map['release_date'] == ''
          ? null
          : DateTime.parse(map['release_date']),
      runtime: map['runtime']?.toInt() ?? 0,
      urlImages: urlImages,
      genre: (map['genres'] as List)
          .map((genre) => GenreModel.fromMap(genre))
          .toList(),
      trailers: (map['videos']['results'] as List)
          .map((video) => TrailerMovieModel.fromMap(video))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'MovieDetailsEntity(id: $id, title: $title, posterPath: $posterPath, sinopse: $sinopse, backdropPath: $backdropPath, stars: $stars, releaseDate: $releaseDate, runtime: $runtime, urlImages: $urlImages, genre: $genre, trailers: $trailers)';
  }
}
