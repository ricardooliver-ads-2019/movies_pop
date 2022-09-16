import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';
import 'package:movies_pop/features/movies_details/domain/entities/genre_entity.dart';
import 'package:movies_pop/features/movies_details/domain/entities/movie_details_entity.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/star_film_rating.dart';

class CardDetails extends StatelessWidget {
  MovieDetailsEntity movie;
  Widget sectionButtons;
  CardDetails({
    Key? key,
    required this.sectionButtons,
    required this.movie,
  }) : super(key: key);
  final dateFormat = DateFormat('y');
  DateTime data = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width:
              mediaSize.width >= 300 ? mediaSize.width * 0.47 : mediaSize.width,
          height: mediaSize.height * 0.40,
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: 300,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: AppTextStyles.titleCardDetails,
                ),
                Text(
                  getGenres(movie.genre),
                  style: AppTextStyles.titleGenres,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      runTime(movie.runtime),
                      style: AppTextStyles.runTime,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      movie.releaseDate != null
                          ? '(' + dateFormat.format(movie.releaseDate!) + ')'
                          : '',
                      style: AppTextStyles.dateY,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                StarFilmRating(value: movie.stars),
                Container(
                    width: mediaSize.width * 0.5,
                    constraints: const BoxConstraints(maxWidth: 150),
                    child: sectionButtons),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String getGenres(List<GenreEntity> list) {
    List<String> genres = [];
    for (var genre in list) {
      genres.add(genre.name);
    }
    return genres.join(', ');
  }

  String runTime(int time) {
    if (time >= 60) {
      var hous = time ~/ 60;
      var minut = time - (hous * 60);
      return '${hous}h${minut > 10 ? minut : '0' '$minut'}';
    }
    return '${time}m';
  }
}
