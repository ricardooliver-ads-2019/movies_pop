import 'package:flutter/material.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/presenter/widgets/cine_movies/card_cine.dart';

class CineGroup extends StatelessWidget {
  final List<MovieEntipy> listMovies;
  const CineGroup({Key? key, required this.listMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 300, maxWidth: 500),
      child: PageView.builder(
          itemCount: listMovies.length,
          itemBuilder: (context, index) {
            var movie = listMovies[index];
            return CardCine(movie: movie);
          }),
    );
  }
}
