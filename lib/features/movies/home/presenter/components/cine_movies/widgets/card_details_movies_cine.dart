import 'package:flutter/material.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

import '../stars.dart';

class CardDetailsMoviesCine extends StatelessWidget {
  final MovieEntipy movie;
  const CardDetailsMoviesCine({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
                const Text(
                  'Fantasia, Ação, Aventura',
                  style: TextStyle(
                    fontSize: 13,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                )
              ],
            ),
          ),
          Stars(
              value: movie.stars / 2, color: Colors.yellow.shade800, size: 15),
        ],
      ),
    );
  }
}
