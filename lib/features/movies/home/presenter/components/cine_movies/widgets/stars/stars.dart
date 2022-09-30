import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/features/movies/home/presenter/components/cine_movies/widgets/stars/create_stars.dart';

class Stars extends StatelessWidget {
  final bool animated;
  final double value;
  final Color color;
  final double size;
  Stars({
    Key? key,
    required this.value,
    required this.color,
    required this.size,
    required this.animated,
  }) : super(key: key);
  late List<Widget> stars;
  final positionTop = 0.0;

  var duration = 500;

  @override
  Widget build(BuildContext context) {
    double position = -size;
    var stars = generateStars(value, color, size);
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size * 5,
            height: size,
            child: Stack(
              children: List.generate(5, (index) {
                return AnimatedPositioned(
                    child: stars[index],
                    top: animated ? positionTop : -size,
                    left: position += size,
                    curve: Curves.bounceInOut,
                    duration: Duration(milliseconds: duration * index));
              }),
            ),
          ),
          AnimatedOpacity(
            opacity: animated ? 1 : 0,
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: duration),
            child: Text(
              value.toStringAsFixed(1),
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
