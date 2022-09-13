import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/action_button.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/card_details/card_buttons/controller/card_Buttons_cubit_controller.dart';
import 'package:movies_pop/features/movies_details/presenter/screen/widgets/card_details/card_buttons/controller/card_buttons_state.dart';
import 'package:movies_pop/features/shared/widgets/snackBar/snackBar_sistem.dart';

class CardButtons extends StatefulWidget {
  final int movieId;
  const CardButtons({Key? key, required this.movieId}) : super(key: key);

  @override
  State<CardButtons> createState() => _CardButtonsState();
}

class _CardButtonsState extends State<CardButtons> {
  late final CardButtonsCubitController _controller;
  bool watchedMovies = false;
  bool watchMovies = false;
  dynamic rated;
  @override
  void initState() {
    super.initState();
    _controller = context.read<CardButtonsCubitController>();
    _controller.getStatusMovies(widget.movieId);
  }

  void validateActionWatchMoviesList(int id) {
    if (watchMovies) {
      _controller.removeMovieToWatchMoviesList(widget.movieId);
    } else {
      _controller.addMovieToWatchMoviesList(widget.movieId);
    }
  }

  void validateActionWatchedMoviesList(int id) {
    if (watchedMovies) {
      _controller.removeMovieToWatchedMoviesList(widget.movieId);
    } else {
      _controller.addMovieToWatchedMoviesList(widget.movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardButtonsCubitController, CardButtonsState>(
      listener: (context, state) {
        if (state is ErrorStatusMovie) {
          final message = state.error.message?.toString() ?? 'Error';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarSistem().snackBarErrorGeneric(message),
          );
        }

        if (state is SuccessStatusMovie) {
          watchMovies = state.movieStatus.watchMovie;
          watchedMovies = state.movieInMyListWatched.status;
          rated = state.movieStatus.rated;
        }

        if (state is RequestAddMoviesToWatchList) {
          if (state.response) {
            watchMovies = true;
          }
          if (state.response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarAddSuccessGeneric(
                  'O filme foi adicionado a sua lista de filmes que deseja assistir'),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarErrorGeneric(
                  'Erro ao adicionar o filme a sua lista de filmes que deseja assistir'),
            );
          }
        }

        if (state is RequestRemoveMoviesToWatchList) {
          if (state.response) {
            watchMovies = false;
          }
          if (state.response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarRemoveSuccessGeneric(
                  'O filme foi removido da sua lista de filmes que deseja assistir'),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarErrorGeneric(
                  'Erro ao remover o filme da sua lista de filmes que deseja assistir'),
            );
          }
        }

        if (state is RequestAddMoviesToWatched) {
          if (state.response) {
            watchedMovies = true;
          }
          if (state.response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarAddSuccessGeneric(
                  'O filme foi adicionado a sua lista de filmes já vistos'),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarErrorGeneric(
                  'Erro ao adicionar o filme a sua lista de filmes já vistos'),
            );
          }
        }

        if (state is RequestRemoveMoviesToWatched) {
          if (state.response) {
            watchedMovies = false;
          }
          if (state.response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarRemoveSuccessGeneric(
                  'O filme foi removido da sua lista de filmes já vistos'),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarErrorGeneric(
                  'Erro ao remover o filme da sua lista de filmes já vistos'),
            );
          }
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionButton(
              action: () {
                validateActionWatchedMoviesList(widget.movieId);
              },
              check: watchedMovies,
              typeIcon: Icons.video_library_rounded,
            ),
            ActionButton(
              action: () {
                validateActionWatchMoviesList(widget.movieId);
              },
              check: watchMovies,
              typeIcon: Icons.live_tv_sharp,
            ),
            ActionButton(
              action: () {},
              check: rated is bool ? false : true,
              typeIcon: Icons.star_outlined,
            ),
          ],
        );
      },
    );
  }
}
