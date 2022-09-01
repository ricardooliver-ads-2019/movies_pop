import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitalHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadingHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ErrorHomeState extends HomeState {
  final Failure error;
  ErrorHomeState({required this.error});

  @override
  List<Object?> get props => [error];
}

class SuccessHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}
