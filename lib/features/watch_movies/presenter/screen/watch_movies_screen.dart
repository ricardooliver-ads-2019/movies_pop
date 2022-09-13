import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/shared/class/controller_list_movies.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/widgets/card_movies.dart';
import 'package:movies_pop/features/shared/widgets/snackBar/snackBar_sistem.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_cubit_controller.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_state.dart';

import '../../../fab_button_menu/presenter/controller/fab_button_cubit_controller.dart';
import '../../../fab_button_menu/presenter/controller/fab_button_state.dart';
import '../../../fab_button_menu/presenter/fab_menu_button/fab_menu_Button.dart';

class WatchMoviesScreen extends StatefulWidget {
  const WatchMoviesScreen({Key? key}) : super(key: key);

  @override
  State<WatchMoviesScreen> createState() => _WatchMoviesScreenState();
}

class _WatchMoviesScreenState extends State<WatchMoviesScreen> {
  late WatchMoviesCubitController _controller;
  late ControllerListMovies controllerListMovies;
  int page = 1;
  int totalPages = 1;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    controllerListMovies = ControllerListMovies();
    _controller = context.read<WatchMoviesCubitController>();
    _controller.getListWatchMovies(page: page);
    _scrollController.addListener(infiniteScroll);
  }

  infiniteScroll() {
    if (page < totalPages) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        _controller.getListWatchMovies(page: page);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            'Assistir depois',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black87,
              Colors.blue,
              Colors.white,
            ],
            stops: [
              0.01,
              0.5,
              0.9,
            ],
          ))),
        ),
        body: BlocConsumer<WatchMoviesCubitController, WatchMoviesState>(
          listener: (context, state) async {
            if (state is SuccessWatchMoviesState) {
              page = state.moviesPageEntipy.page;
              totalPages = state.moviesPageEntipy.totalPages;
              controllerListMovies.value.addAll(state.moviesPageEntipy.movies);
              setState(() {});
            }
            if (state is ErrorWatchMoviesState) {
              final message = state.error.message?.toString() ?? 'Error';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBarSistem().snackBarErrorGeneric(message),
              );
            }
          },
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black87,
                  Colors.blue,
                  Colors.white,
                ],
                stops: [
                  0.01,
                  0.5,
                  0.9,
                ],
              )),
              width: mediaSize.width,
              height: mediaSize.height,
              child: state is LoadingWatchMoviesState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      key: const PageStorageKey<String>('ListWatcMovies'),
                      controller: _scrollController,
                      child: Center(
                        child: ValueListenableBuilder<List<MovieEntipy>>(
                            valueListenable: controllerListMovies,
                            builder: (context, _, __) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: controllerListMovies.value
                                      .map(
                                        (m) => Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 350,
                                          width: mediaSize.width * 0.40,
                                          constraints: const BoxConstraints(
                                            maxWidth: 200,
                                            minWidth: 170,
                                          ),
                                          child: Stack(
                                            children: [
                                              CardMovies(movie: m),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: BlocProvider(
                                                  create: (_) =>
                                                      getItDependency.get<
                                                          FabButtonCubitController>(),
                                                  child: BlocBuilder<
                                                      FabButtonCubitController,
                                                      FabButtonState>(
                                                    buildWhen:
                                                        (previous, current) =>
                                                            previous != current,
                                                    builder: (context, state) {
                                                      return FabMenuButton(
                                                        movieInListWatch: true,
                                                        movieId: m.id,
                                                        validarListWatch: (id) {
                                                          controllerListMovies
                                                              .removeItem(id);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                            }),
                      ),
                    ),
            );
          },
        ));
  }
}
