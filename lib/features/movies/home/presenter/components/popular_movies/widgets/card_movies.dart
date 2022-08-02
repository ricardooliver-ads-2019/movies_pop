import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/presenter/components/fab_menu_button/fab_menu_Button.dart';

import 'circular_progress_stars.dart';

class CardMovies extends StatelessWidget {
  final MovieEntipy movie;
  final dateFormat = DateFormat('y');
  CardMovies({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints(minHeight: 270, minWidth: 170),
      //color: Colors.green,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Container(
                        width: mediaSize.width * 0.40,
                        height: mediaSize.height * 0.30,
                        constraints: const BoxConstraints(
                          maxWidth: 160,
                          minHeight: 220,
                          minWidth: 160,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                            ),
                          ),
                          //borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Column(
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          dateFormat.format(movie.releaseDate),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  CircularProgressStars(
                    value: movie.stars,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 40,
            height: 40,
            child: FabMenuButton(),
          )
        ],
      ),
    );
  }
}
