import 'package:flutter/material.dart';

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
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                height: 0,
                letterSpacing: 0,
                wordSpacing: 0,
              ),
            ),
            Icon(
              Icons.star_outlined,
              size: 8,
              color: Colors.yellow.shade800,
            )
          ],
        ),
      ),
    );
  }
}
