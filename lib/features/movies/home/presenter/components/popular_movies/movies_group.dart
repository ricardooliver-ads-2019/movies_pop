import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    _controller = context.read<PopularCubitController>();
    _controller.getMoviesPopular(page: page);
    print(_controller.state.props);
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

    return BlocBuilder<PopularCubitController, PopularState>(
        builder: (context, state) {
      if (state is LoadingPopularState) {
        return Container(
          height: mediaSize.height * 0.4,
          width: mediaSize.width,
          constraints: const BoxConstraints(maxWidth: 800, minHeight: 270),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ErrorPopularState) {
        if (state.error.message != null) {
          return Container(
            height: mediaSize.height * 0.4,
            width: mediaSize.width,
            constraints: const BoxConstraints(maxWidth: 800, minHeight: 270),
            child: Center(child: Text('${state.error.message}')),
          );
        }

        return Container(
          height: mediaSize.height * 0.4,
          width: mediaSize.width,
          constraints: const BoxConstraints(maxWidth: 800, minHeight: 270),
          child: const Center(child: Text('Error')),
        );
      } else if (state is SuccessPopularState) {
        pageFin = state.pagePopularMovies.totalPages;

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
                Container(
                  height: mediaSize.height * 0.4,
                  width: mediaSize.width,
                  constraints:
                      const BoxConstraints(maxWidth: 800, minHeight: 370),
                  child: ListView.builder(
                      key: const PageStorageKey<String>('MoviesPopular'),
                      controller: _scrollControllerr,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.pagePopularMovies.movies.length,
                      itemBuilder: (context, index) {
                        var movie = state.pagePopularMovies.movies[index];
                        return Container(
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
                                CardMovies(movie: movie),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: BlocProvider(
                                      create: (_) => getItDependency
                                          .get<FabButtonCubitController>(),
                                      child: BlocBuilder<
                                              FabButtonCubitController,
                                              FabButtonState>(
                                          buildWhen: (previous, current) =>
                                              previous != current,
                                          builder: (context, state) {
                                            return FabMenuButton(
                                                movieId: movie.id);
                                          })),
                                ),
                              ],
                            ));
                      }),
                ),
              ],
            ),
          ),
        );
      }
      return Container(
        height: mediaSize.height * 0.4,
        width: mediaSize.width,
        constraints: const BoxConstraints(maxWidth: 800, minHeight: 270),
      );
    });
  }
}
