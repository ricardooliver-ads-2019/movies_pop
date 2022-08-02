import 'package:flutter/material.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/presenter/components/fab_menu_button/fab_menu_Button.dart';

import 'stars.dart';

class CardCine extends StatelessWidget {
  final MovieEntipy movie;
  final bool isCurrentPage;
  const CardCine({Key? key, required this.movie, required this.isCurrentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = isCurrentPage ? 180 : 150;
    final double top = isCurrentPage ? 50 : 70;
    final double botton = isCurrentPage ? 30 : 20;
    final double right = isCurrentPage ? 20 : 30;
    final double left = isCurrentPage ? 20 : 30;
    final Color color =
        isCurrentPage ? Colors.white.withOpacity(0.8) : Colors.black54;
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      //color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: EdgeInsets.only(
                    left: left, top: top, bottom: botton, right: right),
                width: width,
                height: mediaSize.height,
                constraints: const BoxConstraints(
                  maxHeight: 240,
                  maxWidth: 190,
                  minWidth: 160,
                  minHeight: 190,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: color,
                      blurRadius: 2,
                      spreadRadius: 5,
                    )
                  ],
                  //color: Colors.yellow,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                      fit: BoxFit.fill),
                ),
              ),
              AnimatedPositioned(
                top: isCurrentPage ? 50 : 70,
                right: isCurrentPage ? 25 : 35,
                duration: const Duration(milliseconds: 500),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: FabMenuButton(),
                ),
              )
            ],
          ),
          Stars(
            color: Colors.yellow.shade800,
            size: 18,
            value: movie.stars / 2,
            test: isCurrentPage,
          ),
        ],
      ),
    );
  }
}
