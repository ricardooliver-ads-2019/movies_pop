import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/cine_movies_cubit_controller/cine_movies_cubit_controller.dart';

import 'widgets/card_cine.dart';

class CineGroup extends StatefulWidget {
  const CineGroup({Key? key}) : super(key: key);

  @override
  State<CineGroup> createState() => _CineGroupState();
}

class _CineGroupState extends State<CineGroup> {
  @override
  void initState() {
    super.initState();
    final _controller = context.read<CineMoviesCubitController>();
    _controller.getMoviesPlayingInBrazilNowUsecase(1);
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return BlocBuilder<CineMoviesCubitController, CineMoviesState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return Container(
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
        return Container(
          //color: Colors.red,
          height: mediaSize.height * 0.4,
          constraints: const BoxConstraints(
              maxHeight: 500, maxWidth: 800, minHeight: 320),
          child: PageView.builder(
              itemCount: state.pageCineMovies.movies.length,
              itemBuilder: (context, index) {
                var movie = state.pageCineMovies.movies[index];
                return CardCine(movie: movie);
              }),
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
