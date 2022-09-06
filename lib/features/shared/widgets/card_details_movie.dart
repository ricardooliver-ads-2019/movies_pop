import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';

class CardDetailsMovie extends StatelessWidget {
  final MovieEntipy movie;
  CardDetailsMovie({Key? key, required this.movie}) : super(key: key);
  final dateFormat = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br');

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      // color: Colors.yellow,
      width: mediaSize.width * 0.40,
      height: mediaSize.height * 0.30,
      constraints: const BoxConstraints(
        maxWidth: 200,
        minWidth: 170,
        minHeight: 70,
        maxHeight: 70,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
            Visibility(
              visible: movie.releaseDate != null,
              child: Text(
                dateFormat.format(movie.releaseDate!),
                style: const TextStyle(
                  color: Color.fromARGB(255, 148, 167, 177),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
