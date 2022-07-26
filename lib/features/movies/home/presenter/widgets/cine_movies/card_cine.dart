import 'package:flutter/material.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

import 'card_details_movies_cine.dart';

class CardCine extends StatelessWidget {
  final MovieEntipy movie;
  const CardCine({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width,
      constraints: const BoxConstraints(maxWidth: 500),
      //color: Colors.red,
      child: Column(
        children: [
          Container(
            height: mediaSize.height * 0.3,
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${movie.posterPath}')),
            ),
          ),
          CardDetailsMoviesCine(
            movie: movie,
          )
        ],
      ),
    );
  }
}
