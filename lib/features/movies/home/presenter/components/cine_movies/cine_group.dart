import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/cine_movies_cubit_controller/cine_movies_cubit_controller.dart';
import 'package:movies_pop/features/shared/entities/movie_entipy/movie_entipy.dart';
import 'package:movies_pop/features/shared/widgets/snackBar/snackBar_sistem.dart';

import 'widgets/card_cine.dart';
import 'widgets/card_cine_background.dart';

class CineGroup extends StatefulWidget {
  const CineGroup({Key? key}) : super(key: key);

  @override
  State<CineGroup> createState() => _CineGroupState();
}

class _CineGroupState extends State<CineGroup> {
  int page = 1;
  int pageFin = 1;
  int _currentPage = 2;
  bool isLoading = true;
  late final CineMoviesCubitController _controller;
  late final PageController _scrollController;
  late final PageController _scrollController2;
  List<Widget> listComponets = [];
  List<MovieEntipy> listWithMovies = [];

  @override
  void initState() {
    super.initState();
    _controller = context.read<CineMoviesCubitController>();
    _controller.getMoviesPlayingInBrazilNowUsecase(page: page);
    _scrollController = PageController(viewportFraction: 0.45, initialPage: 2);
    _scrollController2 = PageController(initialPage: 2);
    _scrollController.addListener(
      () {
        infiniteScrolling();
        animatedBackgroundPath();
      },
    );
  }

  animatedBackgroundPath() {
    int next = _scrollController.page!.round();
    if (_currentPage != next) {
      setState(() {
        _currentPage = next;
      });
    }
    _scrollController2.animateToPage(_scrollController.page!.round(),
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  infiniteScrolling() {
    if (page <= pageFin) {
      if (_scrollController.position.pixels ==
          (_scrollController.position.maxScrollExtent)) {
        page++;
        _controller.getMoviesPlayingInBrazilNowUsecase(page: page);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return BlocConsumer<CineMoviesCubitController, CineMoviesState>(
        listener: (context, state) {
      if (state is LoadingState) {
        isLoading = true;
      }
      if (state is SuccessState) {
        listWithMovies.addAll(state.pageCineMovies.movies);
        pageFin = state.pageCineMovies.totalPages;
        isLoading = false;
      }
      if (state is ErrorState) {
        isLoading = false;
        final message = state.error.message?.toString() ?? 'Error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarSistem().snackBarErrorGeneric(message),
        );
      }
    }, builder: (context, state) {
      return SafeArea(
        child: Container(
          height: mediaSize.height * 0.4,
          constraints: const BoxConstraints(
              maxHeight: 500, maxWidth: 800, minHeight: 380),
          child: Stack(
            children: [
              Container(
                height: mediaSize.height * 0.4,
                constraints: const BoxConstraints(
                    maxHeight: 500, maxWidth: 800, minHeight: 380),
                child: PageView.builder(
                    key: const PageStorageKey<String>('MoviesCine'),
                    controller: _scrollController2,
                    itemCount: listWithMovies.length,
                    itemBuilder: (context, index) {
                      var movie = listWithMovies[index];
                      return CardCineBackground(movie: movie);
                    }),
              ),
              Container(
                height: mediaSize.height * 0.4,
                constraints: const BoxConstraints(
                    maxHeight: 500, maxWidth: 800, minHeight: 380),
                child: Center(
                  child: PageView.builder(
                      key: const PageStorageKey<String>('MoviesCine'),
                      controller: _scrollController,
                      itemCount: listWithMovies.length,
                      itemBuilder: (context, index) {
                        bool isCurrentPage = index == _currentPage;
                        var movie = listWithMovies[index];
                        return CardCine(
                          movie: movie,
                          isCurrentPage: isCurrentPage,
                        );
                      }),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  height: mediaSize.height * 0.4,
                  constraints: const BoxConstraints(
                    maxHeight: 500,
                    maxWidth: 800,
                    minHeight: 380,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ),
              Container(
                height: mediaSize.height * 0.10,
                width: mediaSize.width,
                padding: const EdgeInsets.only(top: 10),
                constraints: const BoxConstraints(
                  maxHeight: 70,
                  minHeight: 40,
                ),
                child: Center(
                    child: Text(
                  'Filmes em cartaz',
                  style: AppTextStyles.titleHomeM,
                )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
