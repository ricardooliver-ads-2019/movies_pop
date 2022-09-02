import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/widgets/card_movies.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_cubit_controller.dart';
import 'package:movies_pop/features/watch_movies/presenter/controller/watch_movies_state.dart';

class WatchMoviesScreen extends StatefulWidget {
  const WatchMoviesScreen({Key? key}) : super(key: key);

  @override
  State<WatchMoviesScreen> createState() => _WatchMoviesScreenState();
}

class _WatchMoviesScreenState extends State<WatchMoviesScreen> {
  late WatchMoviesCubitController _controller;
  final listMoviesWatch = ValueNotifier<List<MovieEntipy>>([]);
  int page = 1;
  int totalPages = 1;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = context.read<WatchMoviesCubitController>();
    _controller.getListWatchMovies(page: page);
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
              listMoviesWatch.value.addAll(state.moviesPageEntipy.movies);
              setState(() {});
            }
            if (state is ErrorWatchMoviesState) {
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
              child: state is LoadingWatchMoviesState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      key: const PageStorageKey<String>('watchList'),
                      controller: _scrollController,
                      child: SizedBox(
                        child: Center(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: listMoviesWatch.value
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
