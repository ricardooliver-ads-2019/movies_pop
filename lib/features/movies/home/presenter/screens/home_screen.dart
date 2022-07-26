import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/movies/home/presenter/home_controller/home_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/widgets/cine_movies/cine_group.dart';
import 'package:movies_pop/features/movies/home/presenter/widgets/popular_movies/movies_group.dart';

import '../../../../../core/mocks/list_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final _controller = context.read<HomeCubitController>();
    _controller.getMoviesPlayingInBrazilNowUsecase(1);
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaSize.height,
          width: mediaSize.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CineGroup(listMovies: listMoviesMock),
              const SizedBox(height: 20),
              MoviesGroup(title: 'Filmes Populares', listMovies: listMoviesMock)
            ],
          ),
        ),
      ),
    );
  }
}
