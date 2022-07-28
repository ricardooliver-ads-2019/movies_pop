import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/movies/home/presenter/home_controller/home_cubit_controller.dart';

import '../widgets/cine_movies/cine_group.dart';
import '../widgets/popular_movies/movies_group.dart';

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
    _controller.getPageMoviesPopular(1);
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubitController, HomeState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == HomeStatus.error) {
            if (state.error != null) {
              AsukaSnackbar.alert('${state.error!.message}').show();
            }
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            default:
              //print(state.pagePopularMovies?.movies);
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (state.pageCineMovies != null &&
                          state.pageCineMovies!.movies.isNotEmpty)
                        CineGroup(listMovies: state.pageCineMovies?.movies),
                      // const SizedBox(height: 20),
                      if (state.pagePopularMovies != null &&
                          state.pagePopularMovies!.movies.isNotEmpty)
                        MoviesGroup(
                            title: 'Filmes Populares',
                            listMovies: state.pagePopularMovies?.movies),
                      //const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
          }
        });
  }
}
