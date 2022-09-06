import 'package:flutter/material.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/widgets/card_details_movie.dart';
import 'package:movies_pop/features/shared/widgets/circular_progress_stars.dart';

class CardMovies extends StatelessWidget {
  final MovieEntipy movie;

  const CardMovies({Key? key, required this.movie}) : super(key: key);

  DateTime checkDate(DateTime? date) {
    if (date == null) {
      return DateTime.now();
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: mediaSize.width * 0.40,
                  height: mediaSize.height * 0.30,
                  constraints: const BoxConstraints(
                      maxWidth: 200,
                      minWidth: 170,
                      minHeight: 270,
                      maxHeight: 270),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                      ),
                      filterQuality: FilterQuality.medium,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: CardDetailsMovie(movie: movie),
                )
              ],
            ),
            Positioned(
                left: 10,
                top: 270 - 25,
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: CircularProgressStars(
                      value: movie.stars,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
