import 'package:flutter/material.dart';
import 'package:movies_pop/core/routes/app_routes.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/widgets/card_details_movie.dart';
import 'package:movies_pop/features/shared/widgets/circular_progress_stars.dart';

class CardMovies extends StatefulWidget {
  final MovieEntipy movie;

  const CardMovies({Key? key, required this.movie}) : super(key: key);

  @override
  State<CardMovies> createState() => _CardMoviesState();
}

class _CardMoviesState extends State<CardMovies>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationOpacity;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    animationOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeInCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.movieDetails, arguments: widget.movie.id);
      },
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: mediaSize.width * 0.40,
                height: 270,
                constraints: const BoxConstraints(
                  maxWidth: 200,
                  minWidth: 170,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCardMovies,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AnimatedBuilder(
                    animation: animationController,
                    builder: (_, __) {
                      return Opacity(
                        opacity: animationOpacity.value,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            Constants.baseUrlImage +
                                '${widget.movie.posterPath}',
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: CardDetailsMovie(movie: widget.movie),
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
                    value: widget.movie.stars,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
