import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';

class ButtonRequestRating extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icons;
  final VoidCallback action;
  const ButtonRequestRating(
      {Key? key,
      required this.label,
      required this.color,
      required this.action,
      required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 238, 241),
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icons,
              color: color,
            ),
            Text(
              label,
              style: AppTextStyles.titleBotton,
            )
          ],
        ),
      ),
    );
  }
}
