import 'package:flutter/material.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';

class CardCineBackground extends StatelessWidget {
  final MovieEntipy movie;
  const CardCineBackground({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaSize.width,
      //constraints: const BoxConstraints(maxWidth: 500),
      //color: Colors.red,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: mediaSize.height * 0.4,
                constraints:
                    const BoxConstraints(maxHeight: 500, minHeight: 380),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
                  ),
                ),
              ),
              Container(
                height: mediaSize.height * 0.3,
                constraints:
                    const BoxConstraints(maxHeight: 500, minHeight: 380),
                decoration:
                    BoxDecoration(color: Colors.black54.withOpacity(0.4)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}