import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/features/main_navigation_page/controller/main_navigation_page_state.dart';
import 'package:movies_pop/features/main_navigation_page/main_navigation_page.dart';

class MainNavigationPageCubit extends Cubit<MainNavigationPageState> {
  MainNavigationPageCubit() : super(MainNavigationPageState.intial());

  void goToPage(int page, BuildContext context) {
    emit(state.copyWith(pageIndex: page));
    navigatorState.currentState!.pushNamed(
      state.page[page],
    );
  }
}
