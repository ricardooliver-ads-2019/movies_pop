import 'package:equatable/equatable.dart';

//enum HomeStatus { inital,success}

class MainNavigationPageState extends Equatable {
  final List<String> page = ['/home', '/watched_movies', '/watch_movies'];
  final int pageIndex;

  MainNavigationPageState._({
    this.pageIndex = 0,
  });

  MainNavigationPageState.intial()
      : this._(
          pageIndex: 0,
        );

  @override
  List<Object?> get props => [page, pageIndex];

  MainNavigationPageState copyWith({
    int? pageIndex,
  }) {
    return MainNavigationPageState._(pageIndex: pageIndex ?? this.pageIndex);
  }
}
