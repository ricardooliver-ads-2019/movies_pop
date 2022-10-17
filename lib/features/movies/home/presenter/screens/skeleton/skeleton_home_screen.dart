import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/features/movies/home/presenter/screens/skeleton/widgets/box_text_rectangle.dart';
import 'package:movies_pop/features/shared/widgets/card_movies_skeleton.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonHomeScreen extends StatelessWidget {
  const SkeletonHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      highlightColor: AppColors.shimmerHighlightColor,
      baseColor: AppColors.shimmerBaseColor.shade300,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: mediaSize.width,
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Center(child: BoxTextRectangle()),
                const SizedBox(height: 40),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      CardMoviesSkeleton(),
                      CardMoviesSkeleton(),
                      CardMoviesSkeleton(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: BoxTextRectangle(),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      CardMoviesSkeleton(),
                      CardMoviesSkeleton(),
                      CardMoviesSkeleton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
