import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/movies_group.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/popular_cubit_controller/popular_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/popular_cubit_controller/popular_state.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/controller/home_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/controller/home_state.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/skeleton/skeleton_home_screen.dart';

import '../components/cine_movies/cine_group.dart';
import '../components/cine_movies/cine_movies_cubit_controller/cine_movies_cubit_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final HomeCubitController _controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = context.read<HomeCubitController>();
    _controller.getMyList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<HomeCubitController, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingHomeState) {
              return SizedBox(
                child: const SkeletonHomeScreen(),
                width: mediaSize.width,
                height: mediaSize.height,
              );
            }
            return Stack(
              children: [
                Column(
                  children: [
                    BlocProvider(
                      create: (_) =>
                          getItDependency.get<CineMoviesCubitController>(),
                      child: BlocBuilder<CineMoviesCubitController,
                          CineMoviesState>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) {
                          return const CineGroup();
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (_) =>
                          getItDependency.get<PopularCubitController>(),
                      child: BlocBuilder<PopularCubitController, PopularState>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) {
                          return const MoviesGroup(title: 'Mais populares');
                        },
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
