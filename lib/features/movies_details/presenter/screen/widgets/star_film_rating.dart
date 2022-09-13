import 'package:flutter/material.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/widgets/stars/create_stars.dart';

class StarFilmRating extends StatelessWidget {
  final double value;
  const StarFilmRating({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var star = generateStars(value, Colors.yellow.shade800, 18);
    return SizedBox(
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  (value / 2).toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(children: star),
            ],
          ),
        ],
      ),
    );
  }
}
