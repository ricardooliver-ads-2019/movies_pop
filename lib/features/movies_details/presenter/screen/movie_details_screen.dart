import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/skeleton/screen_movie_details_skeleton.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/box_images_movie.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/card_details/card_buttons/card_buttons.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/card_details/card_buttons/controller/card_Buttons_cubit_controller.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/card_details/card_details.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/card_trailer_movie.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/sinopse_movie.dart';
import 'package:movies_pop/features/shared/widgets/snackBar/snackBar_sistem.dart';

import '../controller/movie_details_cubit_controller.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late final MovieDetailsCubitController _controller;
  bool watchedMovies = false;
  bool watchMovies = false;
  dynamic rated;

  @override
  void initState() {
    super.initState();
    _controller = context.read<MovieDetailsCubitController>();
    _controller.getMovieDetails(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: const Text('Detalhe'),
      ),
      body: BlocConsumer<MovieDetailsCubitController, MovieDetailsState>(
        listener: (context, state) {
          if (state is ErrorMovieDetails) {
            final message = state.error.message?.toString() ?? 'Error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarErrorGeneric(message),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingMovieDetails) {
            return SizedBox(
              child: const ScreenMovieDetailsSkeleton(),
              width: mediaSize.width,
              height: mediaSize.height,
            );
          }

          if (state is SuccessMovieDetails) {
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        width: mediaSize.width,
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            BoxImageMovie(
                                urlImage:
                                    'https://image.tmdb.org/t/p/w500${state.movie.posterPath}'),
                            CardDetails(
                              movie: state.movie,
                              sectionButtons: BlocProvider(
                                  create: (context) => getItDependency
                                      .get<CardButtonsCubitController>(),
                                  child: CardButtons(
                                    movieId: widget.movieId,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SinopseMovie(
                        description: state.movie.sinopse,
                      ),
                      Visibility(
                        visible: state.movie.urlImages.isNotEmpty,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: mediaSize.height * 0.33,
                          width: mediaSize.width,
                          constraints: const BoxConstraints(
                            maxHeight: 300,
                            maxWidth: 800,
                          ),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.movie.urlImages.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: BoxImageMovie(
                                      urlImage:
                                          'https://image.tmdb.org/t/p/w200${state.movie.urlImages[index]}'),
                                );
                              })),
                        ),
                      ),
                      Visibility(
                        visible: state.movie.trailers.isNotEmpty,
                        child:
                            CardTrailerMovie(listTrailer: state.movie.trailers),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SingleChildScrollView(
            child: Center(child: SizedBox()),
          );
        },
      ),
    );
  }
}
