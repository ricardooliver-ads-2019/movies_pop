// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/routes/app_routes.dart';
import 'package:movies_pop/core/theme/color_schemes.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_cubit.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_state.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late MainNavigationPageCubit _controller;
  @override
  void initState() {
    super.initState();
    _controller = _controller = context.read<MainNavigationPageCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationPageCubit, MainNavigationPageState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: darkColorScheme.onPrimary,
              unselectedItemColor: darkColorScheme.secondary,
              onTap: (index) {
                _controller.goToPage(index, context);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.movie), label: 'Filmes'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_library_rounded),
                    label: 'Já vistos'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.live_tv_sharp), label: 'Assistir'),
              ]),
          body: Navigator(
            key: navigatorState,
            initialRoute: '/home',
            onGenerateRoute: AppRoutes.onGenerateRoute,
          ),
        );
      },
    );
  }
}

GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
