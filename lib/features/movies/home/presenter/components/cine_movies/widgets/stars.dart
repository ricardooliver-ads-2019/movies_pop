import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final bool test;
  final double value;
  final Color color;
  final double size;
  Stars(
      {Key? key,
      required this.value,
      required this.color,
      required this.size,
      required this.test})
      : super(key: key);
  late List<Widget> stars;
  final positionTop = 0.0;

  var duration = 500;

  @override
  Widget build(BuildContext context) {
    double position = -size;
    var stars = generateStars(value, color, size);
    return Container(
      //color: Colors.green,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            //color: Colors.red,
            width: size * 5,
            height: size,
            child: Stack(
              children: List.generate(5, (index) {
                return AnimatedPositioned(
                    child: stars[index],
                    top: test ? positionTop : -size,
                    left: position += size,
                    curve: Curves.bounceInOut,
                    duration: Duration(milliseconds: duration * index));
              }),
            ),
          ),
          AnimatedOpacity(
            opacity: test ? 1 : 0,
            //left: position += size,
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: duration),
            child: Text(
              value.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.blue,
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
// class _StarsState extends State<Stars> {
//   late double position = -widget.size;
//   late double positionTop = -widget.size;
//   @override
//   void initState() {
//     positionTop = -widget.size;
//     position = widget.size * 5;
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {
//         positionTop = 0;
//         position = -widget.size;
//       });
//     });
//   }

List<Widget> generateStars(double value, Color color, double size) {
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
