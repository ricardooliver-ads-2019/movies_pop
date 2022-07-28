import 'package:flutter/material.dart';

class Stars extends StatefulWidget {
  final double value;
  final Color color;
  final double size;
  Stars(
      {Key? key, required this.value, required this.color, required this.size})
      : super(key: key);
  late List<Widget> stars;
  @override
  State<Stars> createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  late double position;
  late double positionTop;
  @override
  void initState() {
    positionTop = -widget.size;
    position = widget.size * 5;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        positionTop = 0;
        position = -widget.size;
      });
    });
  }

  var duration = 1;

  @override
  Widget build(BuildContext context) {
    var stars = generateStars(widget.value, widget.color, widget.size);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          //color: Colors.red,
          width: widget.size * 5,
          height: widget.size,
          child: Stack(
            children: List.generate(5, (index) {
              return AnimatedPositioned(
                  child: stars[index],
                  top: positionTop,
                  left: position += widget.size,
                  curve: Curves.bounceInOut,
                  duration: Duration(seconds: duration * index));
            }),
          ),
        ),
        Text(
          widget.value.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

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
