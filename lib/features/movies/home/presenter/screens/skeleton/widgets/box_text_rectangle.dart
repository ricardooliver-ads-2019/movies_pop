import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_colors.dart';

class BoxTextRectangle extends StatelessWidget {
  const BoxTextRectangle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 40,
      decoration: BoxDecoration(
          color: AppColors.shimmerGrey,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
