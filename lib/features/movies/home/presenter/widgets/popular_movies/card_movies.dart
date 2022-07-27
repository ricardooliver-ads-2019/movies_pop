import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_pop/features/movies/home/domain/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/movies/home/presenter/widgets/popular_movies/circular_progress_stars.dart';

class CardMovies extends StatelessWidget {
  final MovieEntipy movie;
  final dateFormat = DateFormat('y');
  CardMovies({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      //color: Colors.green,
      width: mediaSize.width * 0.40,
      height: mediaSize.height * 0.30,
      constraints: const BoxConstraints(maxWidth: 160),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    width: mediaSize.width * 0.40,
                    height: mediaSize.height * 0.30,
                    constraints: const BoxConstraints(maxWidth: 160),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
                        ),
                      ),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
                maxLines: 2,
              ),
            ],
          ),
          Positioned(
              right: 9,
              bottom: 60,
              child: CircularProgressStars(value: movie.stars)),
        ],
      ),
    );
  }
}
