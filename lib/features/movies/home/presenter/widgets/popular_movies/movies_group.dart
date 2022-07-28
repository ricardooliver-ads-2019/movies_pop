import 'package:flutter/material.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

import 'card_movies.dart';

class MoviesGroup extends StatelessWidget {
  final String title;
  final List<MovieEntipy>? listMovies;
  const MoviesGroup({Key? key, required this.title, required this.listMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;

    return SizedBox(
      //color: Colors.black,
      width: mediaSize.width,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mais Populares',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                //color: Colors.red,
                height: mediaSize.height * 0.4,
                width: mediaSize.width,
                constraints:
                    const BoxConstraints(maxWidth: 800, minHeight: 270),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listMovies!.length,
                    itemBuilder: (context, index) {
                      var movie = listMovies![index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: CardMovies(movie: movie),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
