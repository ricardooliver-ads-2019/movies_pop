import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_colors.dart';

class ActionButton extends StatelessWidget {
  VoidCallback action;
  bool check;
  IconData typeIcon;

  ActionButton({
    Key? key,
    required this.action,
    required this.check,
    required this.typeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        typeIcon,
        color: check ? AppColors.red : AppColors.secondary,
        size: 30,
      ),
      onTap: action,
    );
  }
}
