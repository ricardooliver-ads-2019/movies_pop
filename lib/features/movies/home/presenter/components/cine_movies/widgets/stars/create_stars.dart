import 'package:flutter/material.dart';

List<Widget> generateStars(double value, Color color, double size) {
  if (value > 5) {
    while (value > 5) {
      value = value / 2;
    }
  }
  List<Icon> totalStars = [];
  List<Icon> fullStars = [];
  List<Icon> emptyStars = [];
  Icon? halfStar;

  var quantStarsCheias = value ~/ 1;

  if (value % 1 != 0) {
    halfStar = Icon(
      Icons.star_half_outlined,
      color: color,
      size: size,
    );
  }

  var quantStarsVazias = (5 - value).floor();

  fullStars = List<Icon>.generate(
    quantStarsCheias,
    (index) {
      return Icon(
        Icons.star_outlined,
        color: color,
        size: size,
      );
    },
  );

  emptyStars = List<Icon>.generate(
    quantStarsVazias,
    (index) {
      return Icon(
        Icons.star_outline,
        color: color,
        size: size,
      );
    },
  );

  if (halfStar != null) {
    return totalStars = [...fullStars, halfStar, ...emptyStars];
  }
  totalStars = [...fullStars, ...emptyStars];

  return totalStars;
}
