import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_cubit_controller.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/controller/fab_button_state.dart';
import 'package:movies_pop/features/fab_button_menu/presenter/fab_menu_button/fab_vertical_delegate.dart';

class FabMenuButton extends StatefulWidget {
  final int movieId;
  final bool movieInListWatched;
  final bool movieInListWatch;
  final ValueChanged<int>? validarListWatched;
  final ValueChanged<int>? validarListWatch;
  const FabMenuButton({
    Key? key,
    required this.movieId,
    this.validarListWatched,
    this.validarListWatch,
    this.movieInListWatched = false,
    this.movieInListWatch = false,
  }) : super(key: key);

  @override
  State<FabMenuButton> createState() => _FabMenuButtonState();
}

class _FabMenuButtonState extends State<FabMenuButton>
    with SingleTickerProviderStateMixin {
  late final FabButtonCubitController _controller;
  late AnimationController animation;

  final menuIsOpen = ValueNotifier<bool>(false);
  final watchedMovies = ValueNotifier<bool>(false);
  final watchMovies = ValueNotifier<bool>(false);
  final rated = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _controller = context.read<FabButtonCubitController>();
    _controller.getStateMovies(widget.movieId);
    _controller.checkMovieInMyListWatchedMovies(widget.movieId);
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  toggleButtonMenu() {
    menuIsOpen.value ? animation.reverse() : animation.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  Color checkMovies(ValueNotifier<bool> value) {
    if (value.value) {
      return Colors.red;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    Color actionButtonColor =
        menuIsOpen.value ? Colors.white : Colors.white.withOpacity(0.5);
    return BlocListener<FabButtonCubitController, FabButtonState>(
      listener: (context, state) {
        setState(() {});
        if (state is SuccessFabButtonState) {
          watchMovies.value = state.movieStatus.watchMovie;
          if (state.movieStatus.rated is bool) {
            rated.value = state.movieStatus.rated;
          } else {
            rated.value = true;
          }
        }
        if (state is SuccessMovieStatusInListWatchedMoviesFabButtonState) {
          watchedMovies.value =
              state.checkMovieInMyListWatchedMoviesEntity.status;
        }
        if (state is RequestAddMoviesToWatched) {
          if (state.response) {
            watchedMovies.value = true;
          }
          final snackBar = SnackBar(
            content: Text(state.response
                ? Constants.messageAddMoveiSuccess
                : Constants.messageAddMoveiError),
            backgroundColor: state.response ? Colors.green : Colors.red,
            dismissDirection: DismissDirection.startToEnd,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is RequestRemoveMoviesToWatched) {
          if (state.response) {
            watchedMovies.value = false;
          }
          final snackBar = SnackBar(
            content: Text(state.response
                ? Constants.messageRemoveMoveiSuccess
                : Constants.messageRemoveMoveiError),
            backgroundColor: state.response ? Colors.green : Colors.red,
            dismissDirection: DismissDirection.up,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is RequestAddMoviesToWatchList) {
          if (state.response) {
            watchMovies.value = true;
          }
          final snackBar = SnackBar(
            content: Text(state.response
                ? Constants.messageAddMoveiSuccess
                : Constants.messageAddMoveiError),
            backgroundColor: state.response ? Colors.green : Colors.red,
            dismissDirection: DismissDirection.startToEnd,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {});
        }

        if (state is RequestRemoveMoviesToWatchList) {
          if (state.response) {
            watchMovies.value = false;
          }
          final snackBar = SnackBar(
            content: Text(state.response
                ? Constants.messageRemoveMoveiSuccess
                : Constants.messageRemoveMoveiError),
            backgroundColor: state.response ? Colors.green : Colors.red,
            dismissDirection: DismissDirection.up,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5, top: 5),
        child: Flow(
          clipBehavior: Clip.none,
          delegate: FabVerticalDelegate(animation: animation),
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                backgroundColor: actionButtonColor,
                child: AnimatedIcon(
                  progress: animation,
                  icon: AnimatedIcons.menu_close,
                  color: Colors.blue,
                ),
                onPressed: () {
                  toggleButtonMenu();
                  setState(() {});
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                debugPrint('tess');
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  backgroundColor: actionButtonColor,
                  child: Icon(
                    Icons.video_library_rounded,
                    color: menuIsOpen.value
                        ? widget.movieInListWatched
                            ? Colors.red
                            : checkMovies(watchedMovies)
                        : Colors.transparent,
                  ),
                  onPressed: () {
                    setState(() {
                      if (watchedMovies.value ||
                          widget.movieInListWatched != false) {
                        var validar = widget.validarListWatched;
                        if (validar != null) {
                          validar(widget.movieId);
                        }

                        _controller
                            .removeMovieToWatchedMoviesList(widget.movieId);
                      } else {
                        _controller.addMovieToWatchedMoviesList(widget.movieId);
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                backgroundColor: actionButtonColor,
                child: Icon(
                  Icons.live_tv_sharp,
                  color: menuIsOpen.value
                      ? widget.movieInListWatch
                          ? Colors.red
                          : checkMovies(watchMovies)
                      : Colors.transparent,
                ),
                onPressed: () {
                  setState(() {
                    if (watchMovies.value || widget.movieInListWatch != false) {
                      var validar = widget.validarListWatch;
                      if (validar != null) {
                        validar(widget.movieId);
                      }
                      _controller.removeMovieToWatchMoviesList(
                          movieId: widget.movieId);
                    } else {
                      _controller.addMovieToWatchMoviesList(widget.movieId);
                    }
                  });
                },
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                backgroundColor: actionButtonColor,
                child: Icon(
                  Icons.star_outlined,
                  color: menuIsOpen.value
                      ? checkMovies(rated)
                      : Colors.transparent,
                ),
                onPressed: () {
                  debugPrint('object');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
