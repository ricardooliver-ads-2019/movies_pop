import 'package:equatable/equatable.dart';
import 'package:movies_pop/core/erros/failures.dart';

abstract class BottomSheetRateMovieState extends Equatable {
  final double rate;
  final bool filmIsRated;
  final Failure? error;
  const BottomSheetRateMovieState({
    required this.rate,
    required this.filmIsRated,
    this.error,
  });
}

class InitialBottomSheetRateMovieState extends BottomSheetRateMovieState {
  const InitialBottomSheetRateMovieState(
      {double rate = 0.0, bool filmIsRated = false})
      : super(rate: rate, filmIsRated: filmIsRated);

  @override
  List<Object?> get props => [rate, filmIsRated];
}

class LoadginBottomSheetRateMovieState extends BottomSheetRateMovieState {
  const LoadginBottomSheetRateMovieState(
      {double rate = 0.0, bool filmIsRated = false})
      : super(rate: rate, filmIsRated: filmIsRated);

  @override
  List<Object?> get props => [rate, filmIsRated];
}

class SuccessStatusRatingMovie extends BottomSheetRateMovieState {
  const SuccessStatusRatingMovie({double rate = 0.0, bool filmIsRated = false})
      : super(rate: rate, filmIsRated: filmIsRated);

  @override
  List<Object?> get props => [rate, filmIsRated];
}

class SuccessRateMovieState extends BottomSheetRateMovieState {
  final bool requestSuccess;
  const SuccessRateMovieState({
    double rate = 0.0,
    bool filmIsRated = false,
    required this.requestSuccess,
  }) : super(rate: rate, filmIsRated: filmIsRated);

  @override
  List<Object?> get props => [rate, filmIsRated];
}

class SuccessDeleteRatingMovieState extends BottomSheetRateMovieState {
  final bool requestSuccess;
  const SuccessDeleteRatingMovieState({
    double rate = 0.0,
    bool filmIsRated = false,
    required this.requestSuccess,
  }) : super(rate: rate, filmIsRated: filmIsRated);

  @override
  List<Object?> get props => [rate, filmIsRated];
}

class ErrorBottomSheetRateMovieState extends BottomSheetRateMovieState {
  const ErrorBottomSheetRateMovieState(
      {double rate = 0.0, bool filmIsRated = false, required Failure error})
      : super(rate: rate, filmIsRated: filmIsRated, error: error);

  @override
  List<Object?> get props => [rate, filmIsRated, error];
}
