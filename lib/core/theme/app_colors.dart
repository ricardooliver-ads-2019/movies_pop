import 'package:flutter/material.dart';

class AppColors {
  static const primary = Colors.white;
  static const secondary = Colors.blue;
  static const thirdary = Color.fromARGB(255, 9, 29, 46);
  static const black = Colors.black87;
  static const transparent = Colors.transparent;
  static const grey = Color(0xFF585666);
  static const delete = Color.fromARGB(255, 216, 119, 119);
  static const red = Color.fromARGB(255, 224, 16, 16);
  static const heading = Color(0xFF585666);
  static const check = Color.fromARGB(255, 137, 199, 118);
  static const green = Color.fromARGB(255, 76, 175, 80);

  static const stroke = Color(0xFFE3E3E6);
  static const shape = Color(0xFFFAFAFC);
  static const background = Color(0xFFFFFFFF);
  static const backgroundCardMovies = Color.fromARGB(255, 224, 224, 224);
  static const shimmerGrey = Color(0xFFB1B0B8);
  static const shimmerHighlightColor = Colors.white;
  static const shimmerBaseColor = Colors.grey;
  static const stars = Color.fromARGB(255, 249, 168, 37);
  static const releaseDate = Color.fromARGB(255, 148, 167, 177);
  static const linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.black87,
      Colors.blue,
      Colors.white,
    ],
    stops: [
      0.01,
      0.5,
      0.9,
    ],
  );
}
