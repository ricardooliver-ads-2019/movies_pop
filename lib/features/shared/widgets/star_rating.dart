import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';

class StarRating extends StatelessWidget {
  final double value;

  const StarRating({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value.toStringAsFixed(1),
              style: AppTextStyles.starRating,
            ),
            const Icon(
              Icons.star_outlined,
              size: 8,
              color: AppColors.stars,
            )
          ],
        ),
      ),
    );
  }
}
