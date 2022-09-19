import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/shared_features/rate_movies/presenter/controller/bottom_sheet_rate_movie_cubit_controller.dart';
import 'package:movies_pop/core/shared_features/rate_movies/presenter/controller/bottom_sheet_rate_movie_state.dart';
import 'package:movies_pop/core/shared_features/rate_movies/presenter/widgets/button_request_rating.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';
import 'package:movies_pop/core/utils/constants.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/widgets/stars/create_stars.dart';
import 'package:movies_pop/features/shared/widgets/snackBar/snackBar_sistem.dart';

class BottomSheetRateMovie extends StatefulWidget {
  final int movieId;
  final String? urlImage;
  final ValueChanged<bool> filmIsRated;
  const BottomSheetRateMovie({
    Key? key,
    required this.movieId,
    required this.filmIsRated,
    this.urlImage,
  }) : super(key: key);

  @override
  State<BottomSheetRateMovie> createState() => _BottomSheetRateMovieState();
}

class _BottomSheetRateMovieState extends State<BottomSheetRateMovie> {
  late final BottomSheetRateMovieCubitController _controller;
  late ControllerRatingValue rating;
  @override
  void initState() {
    super.initState();
    _controller = context.read<BottomSheetRateMovieCubitController>();
    _controller.getStatusRatingMovie(movieId: widget.movieId);
    rating = ControllerRatingValue(value: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomSheetRateMovieCubitController,
        BottomSheetRateMovieState>(
      listener: (context, state) {
        if (state is SuccessRateMovieState) {
          if (state.requestSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarAddSuccessGeneric(
                  'O filme foi avaliado com sucesso'),
            );
            widget.filmIsRated(state.requestSuccess);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarErrorGeneric(
                  'Erro ao tentar avaliar o filme, tente novamente após alguns minutos.'),
            );
          }
        }

        if (state is SuccessDeleteRatingMovieState) {
          if (state.requestSuccess) {
            widget.filmIsRated(!state.requestSuccess);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarRemoveSuccessGeneric(
                  'Sua avaliação foi removida com sucesso'),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarSistem().snackBarErrorGeneric(
                  'Erro ao tentar remover avaliação do filme, tente novamente após alguns minutos.'),
            );
          }
        }

        if (state is ErrorBottomSheetRateMovieState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarSistem().snackBarErrorGeneric(
                'Erro ao tentar avaliar o filme, tente novamente após alguns minutos.'),
          );
        }
      },
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.filmIsRated(state.filmIsRated);
        });

        rating.addValue(state.rate / 2);

        return Stack(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                  maxHeight: 400,
                ),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: AppColors.shape,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary,
                        blurRadius: 20,
                        spreadRadius: 1,
                        offset: (Offset(0, -5)),
                      )
                    ]),
                child: ValueListenableBuilder(
                    valueListenable: rating,
                    builder: (context, _, __) {
                      var star =
                          generateStars(rating.value, AppColors.stars, 20);
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Visibility(
                              visible: widget.urlImage != null,
                              child: SizedBox(
                                width: 80,
                                height: 120,
                                child: Image.network(
                                  Constants.baseUrlImage + '${widget.urlImage}',
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.medium,
                                ),
                              ),
                            ),
                            Text(
                              rating.value.toStringAsFixed(1),
                              style: AppTextStyles.titleBottonSheet,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: star,
                            ),
                            SizedBox(
                              width: 200,
                              child: ValueListenableBuilder(
                                  valueListenable: rating,
                                  builder: (context, _, __) {
                                    return Slider(
                                      activeColor: AppColors.secondary,
                                      value: rating.value,
                                      min: 0.0,
                                      max: 5.0,
                                      divisions: 10,
                                      onChanged: (double newValue) {
                                        rating.addValue(newValue.toDouble());
                                      },
                                    );
                                  }),
                            ),
                            Visibility(
                              visible: state.filmIsRated,
                              child: ButtonRequestRating(
                                label: 'Remover Avaliação',
                                color: AppColors.delete,
                                icons: Icons.highlight_remove_outlined,
                                action: () {
                                  _controller.deleteRatingMovie(
                                    movieId: widget.movieId,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonRequestRating(
                              label: state.filmIsRated
                                  ? 'Reavaliar Filme'
                                  : 'Adicionar Avaliação',
                              color: AppColors.check,
                              icons: Icons.check_circle_outline_rounded,
                              action: () {
                                if (rating.value == 0.0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBarSistem().snackBarErrorGeneric(
                                        'A nota para avaliar um filme tem que ser maior que 0!'),
                                  );
                                } else {
                                  _controller.rateMovie(
                                    movieId: widget.movieId,
                                    rating: rating.value * 2,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ControllerRatingValue extends ValueNotifier<double> {
  ControllerRatingValue({double value = 0.0}) : super(value);

  void addValue(double newValue) {
    value = newValue;
    notifyListeners();
  }
}
