import 'package:flutter/material.dart';
import 'package:movies_pop/features/movies/home/presenter/components/fab_menu_button/fab_vertical_delegate.dart';

class FabMenuButton extends StatefulWidget {
  const FabMenuButton({Key? key}) : super(key: key);

  @override
  State<FabMenuButton> createState() => _FabMenuButtonState();
}

class _FabMenuButtonState extends State<FabMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  final menuIsOpen = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  toggleButtonMenu() {
    menuIsOpen.value ? animation.reverse() : animation.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    Color actionButtonColor =
        menuIsOpen.value ? Colors.white : Colors.white.withOpacity(0.5);
    return Flow(
      clipBehavior: Clip.none,
      delegate: FabVerticalDelegate(animation: animation),
      children: [
        FloatingActionButton(
          backgroundColor: actionButtonColor,
          child: AnimatedIcon(
            progress: animation,
            icon: AnimatedIcons.menu_close,
            color: Colors.blue,
          ),
          onPressed: () {
            toggleButtonMenu();
            setState(() {});
          },
        ),
        FloatingActionButton(
          backgroundColor: actionButtonColor,
          child: Icon(
            Icons.video_library_rounded,
            color: menuIsOpen.value ? Colors.blue : Colors.transparent,
          ),
          onPressed: () {},
        ),
        FloatingActionButton(
          backgroundColor: actionButtonColor,
          child: Icon(
            Icons.live_tv_sharp,
            color: menuIsOpen.value ? Colors.blue : Colors.transparent,
          ),
          onPressed: () {},
        ),
        FloatingActionButton(
          backgroundColor: actionButtonColor,
          child: Icon(
            Icons.star_outlined,
            color: menuIsOpen.value ? Colors.blue : Colors.transparent,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
