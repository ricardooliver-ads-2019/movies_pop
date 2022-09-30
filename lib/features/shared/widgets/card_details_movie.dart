import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';

class CardDetailsMovie extends StatelessWidget {
  final MovieEntipy movie;
  CardDetailsMovie({Key? key, required this.movie}) : super(key: key);
  final dateFormat = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br');

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width * 0.40,
      height: 70,
      constraints: const BoxConstraints(
        maxWidth: 200,
        minWidth: 170,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              movie.title,
              style: AppTextStyles.titleCardMovies,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            movie.releaseDate == null
                ? const Text('')
                : Text(
                    dateFormat.format(movie.releaseDate!),
                    style: AppTextStyles.releaseDateCardMovies,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ],
        ),
      ),
    );
  }
}
