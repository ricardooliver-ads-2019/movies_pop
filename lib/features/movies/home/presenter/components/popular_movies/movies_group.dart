import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'popular_cubit_controller/popular_cubit_controller.dart';
import 'popular_cubit_controller/popular_state.dart';
import 'widgets/card_movies.dart';

class MoviesGroup extends StatefulWidget {
  final String? title;
  const MoviesGroup({Key? key, required this.title}) : super(key: key);

  @override
  State<MoviesGroup> createState() => _MoviesGroupState();
}

class _MoviesGroupState extends State<MoviesGroup> {
  @override
  void initState() {
    final _controller = context.read<PopularCubitController>();
    _controller.getMoviesPopular(page: 1);
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
        return SizedBox(
          //color: Colors.black,
          width: mediaSize.width,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
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
                  //color: Colors.red,
                  height: mediaSize.height * 0.4,
                  width: mediaSize.width,
                  constraints:
                      const BoxConstraints(maxWidth: 800, minHeight: 270),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.pagePopularMovies.movies.length,
                      itemBuilder: (context, index) {
                        var movie = state.pagePopularMovies.movies[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: CardMovies(movie: movie),
                        );
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
