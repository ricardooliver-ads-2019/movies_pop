import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/shared/class/controller_list_movies.dart';
import 'package:movies_pop/features/shared/widgets/card_movies.dart';
import 'package:movies_pop/features/shared/widgets/snackBar/snackBar_sistem.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/tv_entity.dart';
import 'package:movies_pop/features/watched_movies/presenter/controller/watched_cubit_controller.dart';

import '../../../../core/dependencies/get_it/dependencies.dart';
import '../../../fab_button_menu/presenter/controller/fab_button_cubit_controller.dart';
import '../../../fab_button_menu/presenter/controller/fab_button_state.dart';
import '../../../fab_button_menu/presenter/fab_menu_button/fab_menu_Button.dart';

class WatchedMoviesScreen extends StatefulWidget {
  const WatchedMoviesScreen({Key? key}) : super(key: key);

  @override
  State<WatchedMoviesScreen> createState() => _WatchedMoviesScreenState();
}

class _WatchedMoviesScreenState extends State<WatchedMoviesScreen> {
  late final WatchedCubitController _controller;
  late ControllerListMovies controllerListMovies;

  @override
  void initState() {
    super.initState();
    controllerListMovies = ControllerListMovies();
    _controller = context.read<WatchedCubitController>();
    _controller.getMyListWatchedMovies();
  }

  @override
  void dispose() {
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
            'Filmes já vistos',
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
        body: BlocConsumer<WatchedCubitController, WatchedState>(
          listener: (context, state) async {
            if (state is SucccessWatchedState) {
              controllerListMovies.value
                  .addAll(state.myListMoviesWatched.listMovies);
              controllerListMovies.value
                  .removeWhere((element) => element is TvEntity);
            }
            if (state is ErrorWatchedState) {
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
              child: SingleChildScrollView(
                child: SizedBox(
                  width: mediaSize.width,
                  child: Center(
                    child: state is LoadingWatchedState
                        ? SizedBox(
                            width: mediaSize.width,
                            height: mediaSize.height,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        : ValueListenableBuilder(
                            valueListenable: controllerListMovies,
                            builder: (context, _, __) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: controllerListMovies.value
                                      .map((m) => Container(
                                          margin: const EdgeInsets.all(10),
                                          // color: Colors.green,
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
                                                        buildWhen: (previous,
                                                                current) =>
                                                            previous != current,
                                                        builder:
                                                            (context, state) {
                                                          return FabMenuButton(
                                                            movieInListWatched:
                                                                true,
                                                            movieId: m.id,
                                                            validarListWatched:
                                                                (id) {
                                                              controllerListMovies
                                                                  .removeItem(
                                                                      id);
                                                            },
                                                          );
                                                        })),
                                              ),
                                            ],
                                          )))
                                      .toList(),
                                ),
                              );
                            }),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
