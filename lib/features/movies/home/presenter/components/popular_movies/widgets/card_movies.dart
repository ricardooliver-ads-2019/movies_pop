import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_cubit_controller.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_state.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/fab_menu_button/fab_menu_Button.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/widgets/circular_progress_stars.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';

class CardMovies extends StatelessWidget {
  final MovieEntipy movie;
  final dateFormat = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_br');
  CardMovies({Key? key, required this.movie}) : super(key: key);

  DateTime checkDate(DateTime? date) {
    if (date == null) {
      return DateTime.now();
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      // color: Colors.red,
      width: mediaSize.width * 0.40,
      height: mediaSize.height * 0.30,
      constraints: const BoxConstraints(
        maxWidth: 200,
        minWidth: 170,
        minHeight: 295,
        maxHeight: 300,
      ),
      child: InkWell(
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
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      //color: Colors.yellow,
                      width: mediaSize.width * 0.40,
                      height: mediaSize.height * 0.30,
                      constraints: const BoxConstraints(
                        maxWidth: 200,
                        minWidth: 170,
                        minHeight: 70,
                        maxHeight: 70,
                      ),
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
                  )
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: BlocProvider(
                    create: (_) =>
                        getItDependency.get<FabButtonCubitController>(),
                    child:
                        BlocBuilder<FabButtonCubitController, FabButtonState>(
                            buildWhen: (previous, current) =>
                                previous != current,
                            builder: (context, state) {
                              return FabMenuButton(movieId: movie.id);
                            })),
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
      ),
    );
  }
}
