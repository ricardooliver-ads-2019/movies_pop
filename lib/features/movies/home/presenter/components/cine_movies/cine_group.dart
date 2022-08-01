import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/cine_movies_cubit_controller/cine_movies_cubit_controller.dart';

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
  late final CineMoviesCubitController _controller;
  late final PageController _scrollController;
  late final PageController _scrollController2;
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
    return BlocBuilder<CineMoviesCubitController, CineMoviesState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return Container(
          color: Colors.transparent,
          width: mediaSize.width,
          height: mediaSize.height * 0.4,
          constraints: const BoxConstraints(
              maxHeight: 500, maxWidth: 800, minHeight: 320),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ErrorState) {
        if (state.error.message != null) {
          return Container(
            width: mediaSize.width,
            height: mediaSize.height * 0.4,
            constraints: const BoxConstraints(
                maxHeight: 500, maxWidth: 800, minHeight: 320),
            child: Center(child: Text('${state.error.message}')),
          );
        }

        return const Center(child: Text('Error'));
      } else if (state is SuccessState) {
        pageFin = state.pageCineMovies.totalPages;
        return Container(
          //color: Colors.red,
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
                    itemCount: state.pageCineMovies.movies.length,
                    itemBuilder: (context, index) {
                      var movie = state.pageCineMovies.movies[index];
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
                      itemCount: state.pageCineMovies.movies.length,
                      itemBuilder: (context, index) {
                        // print('$index tetetetetete');
                        // print(_currentPage);
                        bool isCurrentPage = index == _currentPage;
                        var movie = state.pageCineMovies.movies[index];
                        return CardCine(
                          movie: movie,
                          isCurrentPage: isCurrentPage,
                        );
                      }),
                ),
              ),
            ],
          ),
        );
      }
      return Container(
        width: mediaSize.width,
        height: mediaSize.height * 0.4,
        constraints:
            const BoxConstraints(maxHeight: 500, maxWidth: 800, minHeight: 320),
      );
    });
  }
}
