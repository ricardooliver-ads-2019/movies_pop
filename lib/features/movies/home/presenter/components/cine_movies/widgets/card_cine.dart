import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_cubit_controller.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_state.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/fab_menu_button/fab_menu_Button.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';

import 'stars.dart';

class CardCine extends StatelessWidget {
  final MovieEntipy movie;
  final bool isCurrentPage;
  const CardCine({Key? key, required this.movie, required this.isCurrentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = isCurrentPage ? 200 : 160;
    final double top = isCurrentPage ? 0 : 20;
    final double botton = isCurrentPage ? 30 : 20;
    final double right = isCurrentPage ? 0 : 0;
    final double left = isCurrentPage ? 20 : 30;
    final Color color =
        isCurrentPage ? Colors.white.withOpacity(0.8) : Colors.black54;
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width,
            height: mediaSize.height,
            constraints: const BoxConstraints(
              maxHeight: 250,
              maxWidth: 190,
              minWidth: 160,
              minHeight: 190,
            ),
            child: AnimatedContainer(
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
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  filterQuality: FilterQuality.medium,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      child: BlocProvider(
                          create: (_) =>
                              getItDependency.get<FabButtonCubitController>(),
                          child: BlocBuilder<FabButtonCubitController,
                                  FabButtonState>(
                              buildWhen: (previous, current) =>
                                  previous != current,
                              builder: (context, state) {
                                return FabMenuButton(movieId: movie.id);
                              })),
                    ),
                  )
                ],
              ),
            ),
          ),
          Stars(
            color: Colors.yellow.shade800,
            size: 18,
            value: movie.stars / 2,
            animated: isCurrentPage,
          ),
        ],
      ),
    );
  }
}
