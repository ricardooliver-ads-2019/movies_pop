import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_cubit_controller.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_state.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/fab_menu_button/fab_menu_Button.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';

class CardMovies extends StatelessWidget {
  final MovieEntipy movie;
  final dateFormat = DateFormat('y');
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
      width: mediaSize.width * 0.40,
      height: mediaSize.height * 0.30,
      constraints: const BoxConstraints(
          maxWidth: 200, minWidth: 170, minHeight: 270, maxHeight: 300),
      child: InkWell(
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
                    maxWidth: 200,
                    minWidth: 170,
                    minHeight: 270,
                    maxHeight: 300),
                decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
