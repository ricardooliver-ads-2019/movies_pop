import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/features/shared/widgets/star_rating.dart';

class CircularProgressStars extends StatefulWidget {
  final double value;
  const CircularProgressStars({Key? key, required this.value})
      : super(key: key);

  @override
  State<CircularProgressStars> createState() => _CircularProgressStarsState();
}

class _CircularProgressStarsState extends State<CircularProgressStars>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      lowerBound: 0,
      upperBound: widget.value / 2,
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color setColor(double value) {
    if (value < 2.5) {
      return AppColors.red;
    }
    if (value < 3.5) {
      return AppColors.secondary;
    }
    return AppColors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StarRating(value: widget.value / 2),
        Align(
          alignment: Alignment.center,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: widget.value / 10),
            duration: const Duration(milliseconds: 2000),
            builder: (context, double value, child) => SizedBox(
              width: 46,
              height: 46,
              child: CircularProgressIndicator(
                color: setColor(widget.value / 2),
                backgroundColor: Colors.grey.withOpacity(0.5),
                value: value,
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
          ),
        )
      ],
    );
  }
}
