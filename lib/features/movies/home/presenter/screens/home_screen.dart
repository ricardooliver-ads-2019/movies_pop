import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/movies_group.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/popular_cubit_controller/popular_cubit_controller.dart';
import 'package:movies_pop/features/movies/home/presenter/components/popular_movies/popular_cubit_controller/popular_state.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/controller/home_cubit_controller.dart';

import '../components/cine_movies/cine_group.dart';
import '../components/cine_movies/cine_movies_cubit_controller/cine_movies_cubit_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> animationPositionWidth;
  late final Animation<double> animationPositionHeight;
  late final Animation<double> animationOpacity;
  late final HomeCubitController _controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationPositionWidth =
        Tween<double>(begin: MediaQuery.of(context).size.width, end: 0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.80, 1, curve: Curves.easeOut)));

    animationPositionHeight =
        Tween<double>(begin: MediaQuery.of(context).size.height, end: 0)
            .animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.80, 1, curve: Curves.easeOut),
    ));

    animationOpacity = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
  }

  @override
  void initState() {
    _controller = context.read<HomeCubitController>();
    _controller.getMyList();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      _animationController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Stack(
            children: [
              Column(
                children: [
                  BlocProvider(
                    create: (_) =>
                        getItDependency.get<CineMoviesCubitController>(),
                    child:
                        BlocBuilder<CineMoviesCubitController, CineMoviesState>(
                            buildWhen: (previous, current) =>
                                previous != current,
                            builder: (context, state) {
                              return const CineGroup();
                            }),
                  ),
                  BlocProvider(
                    create: (_) =>
                        getItDependency.get<PopularCubitController>(),
                    child: BlocBuilder<PopularCubitController, PopularState>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) {
                          return const MoviesGroup(title: 'Mais populares');
                        }),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, __) {
                      return Opacity(
                        opacity: animationOpacity.value,
                        child: Container(
                          width: animationPositionWidth.value,
                          height: animationPositionHeight.value,
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
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
