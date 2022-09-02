import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/widgets/card_movies.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/watched_movies/domain/entities/tv_entity.dart';
import 'package:movies_pop/features/watched_movies/presenter/controller/watched_cubit_controller.dart';
import 'package:movies_pop/features/watched_movies/presenter/controller/watched_state.dart';

class WatchedMoviesScreen extends StatefulWidget {
  const WatchedMoviesScreen({Key? key}) : super(key: key);

  @override
  State<WatchedMoviesScreen> createState() => _WatchedMoviesScreenState();
}

class _WatchedMoviesScreenState extends State<WatchedMoviesScreen> {
  late final WatchedCubitController _controller;
  final listMoviesWatched = ValueNotifier<List<MovieEntipy>>([]);

  @override
  void initState() {
    super.initState();
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
        body: BlocConsumer<WatchedCubitController, WatchedState>(
      listener: (context, state) async {
        if (state is SucccessWatchedState) {
          listMoviesWatched.value.addAll(state.myListMoviesWatched.listMovies);
          listMoviesWatched.value.removeWhere((element) => element is TvEntity);
          setState(() {});
        }
        if (state is ErrorWatchedState) {
          final mensagen = state.error.message?.toString() ?? 'Error';
          final snackBar = SnackBar(
            content: Text(mensagen),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    ? const CircularProgressIndicator()
                    : Wrap(
                        alignment: WrapAlignment.start,
                        children: listMoviesWatched.value
                            .map((m) => Container(
                                width: mediaSize.width * 0.46,
                                constraints: const BoxConstraints(
                                    maxWidth: 215, minWidth: 175),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: CardMovies(movie: m),
                                )))
                            .toList(),
                      ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
