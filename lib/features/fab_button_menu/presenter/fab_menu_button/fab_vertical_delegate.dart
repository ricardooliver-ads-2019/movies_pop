import 'package:flutter/cupertino.dart';

class FabVerticalDelegate extends FlowDelegate {
  final AnimationController animation;
  FabVerticalDelegate({
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    const buttonSize = 40;
    const buttonRadius = buttonSize / 2;
    const buttonMargin = 8;

    final positionX = context.size.width - buttonSize;
    const positionY = 0.0;

    final lastFabIndex = context.childCount - 1;

    for (var i = lastFabIndex; i >= 0; i--) {
      final y = positionY + ((buttonSize + buttonMargin) * i * animation.value);
      final size = (i != 0) ? animation.value : 1.0;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(positionX, y, 0)
          ..translate(buttonRadius, buttonRadius)
          ..scale(size)
          ..translate(-buttonRadius, -buttonRadius),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
