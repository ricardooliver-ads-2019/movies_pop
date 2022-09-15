import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/shared/widgets/card_movies_skeleton.dart';
import 'package:movies_pop/features/shared/widgets/snackBar/snackBar_sistem.dart';

import '../../../../../../core/dependencies/get_it/dependencies.dart';
import '../../../../../fab_button_menu/presenter/controller/fab_button_cubit_controller.dart';
import '../../../../../fab_button_menu/presenter/controller/fab_button_state.dart';
import '../../../../../fab_button_menu/presenter/fab_menu_button/fab_menu_Button.dart';
import '../../../../../shared/widgets/card_movies.dart';
import 'popular_cubit_controller/popular_cubit_controller.dart';
import 'popular_cubit_controller/popular_state.dart';

class MoviesGroup extends StatefulWidget {
  final String? title;
  const MoviesGroup({Key? key, required this.title}) : super(key: key);

  @override
  State<MoviesGroup> createState() => _MoviesGroupState();
}

class _MoviesGroupState extends State<MoviesGroup> {
  int page = 1;
  int pageFin = 1;
  late final PopularCubitController _controller;
  late final ScrollController _scrollControllerr;
  List<Widget> listComponets = [];
  @override
  void initState() {
    _controller = context.read<PopularCubitController>();
    _controller.getMoviesPopular(page: page);

    _scrollControllerr = ScrollController();
    _scrollControllerr.addListener(infiniteScroll);
  }

  infiniteScroll() {
    if (page <= pageFin) {
      if (_scrollControllerr.position.pixels ==
          _scrollControllerr.position.maxScrollExtent) {
        page++;
        _controller.getMoviesPopular(page: page);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollControllerr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;

    return BlocConsumer<PopularCubitController, PopularState>(
        listener: (context, state) {
      if (state is LoadingPopularState) {
        for (var i = 0; i < 5; i++) {
          listComponets.add(const CardMoviesSkeleton());
        }
      }

      if (state is SuccessPopularState) {
        pageFin = state.pagePopularMovies.totalPages;
        if (listComponets.isNotEmpty) {
          for (var i = 0; i < 5; i++) {
            listComponets.removeLast();
          }
        }

        listComponets.addAll(state.pagePopularMovies.movies
            .map((movie) => Container(
                  margin: const EdgeInsets.all(10),
                  height: 350,
                  width: mediaSize.width * 0.40,
                  constraints: const BoxConstraints(
                    maxWidth: 200,
                    minWidth: 170,
                  ),
                  child: Stack(
                    children: [
                      CardMovies(movie: movie),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BlocProvider(
                          create: (_) =>
                              getItDependency.get<FabButtonCubitController>(),
                          child: BlocBuilder<FabButtonCubitController,
                              FabButtonState>(
                            buildWhen: (previous, current) =>
                                previous != current,
                            builder: (context, state) {
                              return FabMenuButton(movieId: movie.id);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList());
      }
      if (state is ErrorPopularState) {
        final message = state.error.message?.toString() ?? 'Error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarSistem().snackBarErrorGeneric(message),
        );
      }
    }, builder: (context, state) {
      return SizedBox(
        width: mediaSize.width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  '${widget.title}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                controller: _scrollControllerr,
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: listComponets,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
