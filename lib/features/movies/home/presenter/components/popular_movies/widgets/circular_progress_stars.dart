import 'package:flutter/material.dart';

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
    print(controller.value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: mediaSize.width * 0.1,
          height: mediaSize.width * 0.1,
          constraints: const BoxConstraints(
            maxHeight: 38,
            maxWidth: 38,
            minHeight: 23,
            minWidth: 23,
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/images/star.png',
            ),
          )),
          child: Center(
            child: Text(
              (widget.value / 2).toStringAsFixed(1),
              style: const TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: widget.value / 10),
          duration: const Duration(milliseconds: 2000),
          builder: (context, double value, child) => Container(
            width: mediaSize.width * 0.105,
            height: mediaSize.width * 0.105,
            constraints: const BoxConstraints(
              maxHeight: 40,
              maxWidth: 40,
              minHeight: 25,
              minWidth: 25,
            ),
            child: CircularProgressIndicator(
              color: const Color.fromARGB(255, 4, 171, 248),
              backgroundColor: Colors.grey.withOpacity(0.5),
              value: value,
              semanticsLabel: 'Linear progress indicator',
            ),
          ),
        )
      ],
    );
  }
}
